''Copyright (c) 2010, HMCsoft and Ebben Feagan
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of HMCsoft nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

'Compiles LOC and a host of other information of a directory tree for later processing.

#define fbext_NoBuiltinInstanciations() 1

'ext includes
#include once "ext/misc.bi"
#include once "ext/xml.bi"
#include once "ext/strings.bi"
#include once "ext/debug.bi"
#include once "ext/file/file.bi"
#include once "ext/options.bi"
#include once "ext/hash.bi"

'fb includes
#include once "file.bi"

dim shared as string base_href
dim shared as integer ln
dim shared as ext.xml.node ptr last_was_in
dim shared as ext.File ff
dim shared num_code as uinteger
dim shared num_comment as uinteger
dim shared num_ws as uinteger
dim shared global_ws as uinteger
dim shared global_comment as uinteger
dim shared global_code as uinteger
dim shared global_lines as uinteger
dim shared global_files as uinteger
dim shared global_filesize as ulongint

enum linetype
unknown
whitespace
comment
code
type_
include
macro
end enum

enum statuscodes
default = 0
inFunction
multiLineDeclare
inType
end enum

declare sub AnalyzeFile( byval xnode as ext.xml.node ptr )
declare function readNextLine( ) as string
declare sub RecurseInto( byval xnode as ext.xml.node ptr )
declare function getLinetype( byval xnode as ext.xml.node ptr, byref lstr as const string ) as linetype
declare function isFunction( byval xnode as ext.xml.node ptr, byref lstr as const string ) as string
declare function getFunctionSignature( byref lstr as const string ) as string
declare function findFunction( byval xnode as ext.xml.node ptr, byval hash as uinteger ) as ext.xml.node ptr
declare function isType( byval xnode as ext.xml.node ptr, byref lstr as const string ) as linetype
declare function isPreProcessor( byval xnode as ext.xml.node ptr, byref lstr as const string ) as linetype
declare sub processParams( byval xnode as ext.xml.node ptr, byref pstr as const string )

using ext
using misc
using strings
using xml


''::: MAIN :::
dim as xml.tree xtree
dim as options.Parser opt

''::: OPTIONS :::
opt.setHelpHeader( !"FBEXT - KLOC\n" & _
"FreeBASIC Source Code Analyzer." )
var oo =    opt.addOption("o","output-file",true,true,false,,"Sets the file to output XML data to." )
var oi =    opt.addOption("i","input-file",true,true,false,,"Analyze a single file." )
var od =    opt.addOption("d","directory",true,true,false,,"Analyze the contents of a directory (includes subdirectories)." )
var lang =  opt.addOption("l","language",true,true,false,,"Sets the souce language, currently supported is: FreeBASIC." )
opt.setHelpFooter( !"The i and d options are mutually exclusive, you may only choose one or the other.\n" & _
!"Default behaviour is outputs all data to STDOUT and runs with the current directory as the target.\n" & _
"Copyright (c) 2010, The FreeBASIC Extended Library Development Group" )

opt.parse(__FB_ARGC__,__FB_ARGV__)

if opt.isSet(oi) = true AND opt.isSet(od) = true then
    opt.showHelp
    end 1
end if

var start_dir = curdir()
var outputf = ""
if opt.isSet(oo) then outputf = opt.getArg(oo)
if opt.isSet(od) then
    base_href = opt.getArg(od)
else
    base_href = curdir()
end if

'FBEXT_DPRINT("Counting lines in: " & curdir())
var ptag = xtree.root->appendChild("xml",ext.xml.processingInstruction)
ptag->attribute("version") = "1.0"
ptag->attribute("encoding") = "UTF-8"
xtree.root->appendChild("ext-kloc")
xtree.root->child("ext-kloc")->attribute("base-href") = base_href
chdir( base_href )
xtree.root->child("ext-kloc")->appendChild("directory")->attribute("name")= "/"

var start_time = timer

if not(opt.isSet(oi)) then
    RecurseInto( xtree.root->child("ext-kloc")->child("directory") )
else
    var fzz = xtree.root->child("ext-kloc")->child("directory")->appendChild("file")
    fzz->attribute("name") = opt.getArg(oi)
    AnalyzeFile( fzz )
end if

var stop_time = timer

chdir start_dir

var stats = xtree.root->child("ext-kloc")->appendChild("statistics")
var lines = stats->appendChild("lines",text)
lines->setText = str(global_lines)
lines->attribute("code") = str(global_code)
lines->attribute("whitespace") = str(global_ws)
lines->attribute("comments") = str(global_comment)
var fcstats = stats->appendChild("file-count",text)
fcstats->setText = str(global_files)
fcstats->attribute("total_in_bytes") = str(global_filesize)
fcstats->attribute("avg_file_size") = str(cast(ulongint,global_filesize / global_files))
stats->appendChild("run-date",text)->setText = date
stats->appendChild("run-time",text)->setText = time
var rlstats = stats->appendChild("run-length",text)
rlstats->setText = str(stop_time - start_time)
rlstats->attribute("unit") = "seconds"

if outputf = "" then
    open cons for output as #1
else
    open outputf for binary ACCESS WRITE as #1
end if

print #1, xtree

close

''::: END MAIN :::

sub RecurseInto( byval xnode as ext.xml.node ptr )


    dim as string this_dir

    this_dir = xnode->attribute("name")

    replace( this_dir, "//", "/" )

    if right(this_dir,1) = "/" then
        this_dir = left(this_dir,len(this_dir)-1)
    end if

    if len(this_dir) > 0 then
        chdir this_dir
    end if

    'FBEXT_DPRINT("In directory: " & curdir())


    for n as FILE_ITER = FILE_ITER("*",&h10) to ""

        var temp = n.filename()
        'FBEXT_DPRINT(":: " & temp)
        if (len(temp) > 0) ANDALSO (temp[0] <> asc(".")) then

            xnode->appendChild("directory")->attribute("name") = temp

        end if
    next n


    for m as FILE_ITER = FILE_ITER("*.bas",&h21) to ""

        var temp = m.filename()

        if (len(temp) > 0) ANDALSO (temp[0] <> asc(".")) then

            var new_file = xnode->appendChild("file")
            new_file->attribute("name") = temp

            AnalyzeFile( new_file )

        end if

    next m

    for m as FILE_ITER = FILE_ITER("*.bi",&h21) to ""

        var temp = m.filename()

        if (len(temp) > 0) ANDALSO (temp[0] <> asc(".")) then


            var new_file = xnode->appendChild("file")
            new_file->attribute("name") = temp

            AnalyzeFile( new_file )


        end if

    next m

    for r as integer = 0 to xnode->children("directory")-1
        RecurseInto( xnode->child("directory",r) )
    next

    if base_href <> curdir() then
        chdir ".."
    end if

end sub

function ReadNextLine( ) as string

    if not(ff.eof) then
        ln += 1
        return ff.readLine
    else
        return ""
    end if

end function

sub AnalyzeFile( byval xnode as ext.xml.node ptr )

    dim file_con as string
    global_files += 1
    num_code = 0
    num_comment = 0
    num_ws = 0
    dim file_size as ulongint = 0
    dim file_name as string
    dim as uinteger max_line = 0
    dim as uinteger avg_line = 0
    dim as integer file_enc = 0
    dim as double file_time = 0.0
    dim last_func as ext.xml.node ptr
    dim as uinteger max_line_num = 0

    file_con = ""



    dim status as statuscodes = default

    var this_dir = xnode->attribute("name")

    file_name = this_dir
    file_time = filedatetime( file_name )

    ff = ext.File(file_name,ext.ACCESS_TYPE.R)

    if ff.open = false then
        'FBEXT_DPRINT("Processing file: " & file_name)
        file_enc = fileattr( ff.handle, fbFileAttrEncoding )
        file_size = ff.lof
        global_filesize += file_size
        ln = 0
        while not ff.eof
            file_con = ReadNextLine
            if len(trim(file_con)) > 0 then
                var tlen = len(file_con)
                if tlen > max_line then
                    max_line = tlen
                    max_line_num = ln
                end if
                avg_line += tlen
                var lt = getLinetype(xnode, file_con)
                if lt = linetype.comment then
                    num_comment += 1
                else
                    num_code += 1
                end if
            else
                num_ws += 1
            end if

        wend

    else

        xnode->attribute("error") = "Unable to open file"
        ff.close
        return

    end if
    ff.close

    xnode->attribute("timestamp") = format(file_time,"yyyy-mm-ddThh:mm:ss")

    var strenc = ""
    select case file_enc
        case fbFileEncodASCII
            strenc = "ASCII"
        case fbFileEncodUTF16
            strenc = "UTF-16"
        case fbFileEncodUTF32
            strenc = "UTF-32"
        case else
            strenc = "UTF-8"
    end select

    xnode->attribute("encoding") = strenc

    xnode->attribute("filesize") = str(file_size)

    var tloc = xnode->appendChild( "line-count" )
    tloc->attribute("comment") = str(num_comment)
    tloc->attribute("code") = str(num_code)
    tloc->attribute("whitespace") = str(num_ws)
    tloc->attribute("total") = str(num_ws + num_code + num_comment)

    xnode->appendChild( "line-width" )
    xnode->child("line-width")->attribute("average") = str( avg_line \ iif((num_code + num_comment + num_ws)=0,1,(num_code + num_comment + num_ws)) )
    xnode->child("line-width")->attribute("max") = str( max_line )
    xnode->child("line-width")->attribute("max-on") = str( max_line_num )

    global_lines += num_ws + num_code + num_comment
    global_code += num_code
    global_comment += num_comment
    global_ws += num_ws

end sub

sub processParams( byval xnode as ext.xml.node ptr, byref pstr as const string )

    dim pstrs() as string
    explode(pstr,",",pstrs())
    for n as integer = lbound(pstrs) to ubound(pstrs)
        pstrs(n) = trim(pstrs(n))
        if pstrs(n) <> "" then
            dim pwords() as string
            explode(pstrs(n)," ", pwords())
            var nt = xnode->appendChild("parameter")
            var ttype = ""
            var seen_as = false
            for m as integer = lbound(pwords) to ubound(pwords)
                select case lcase(trim(pwords(m)))
                case "byval"
                    nt->attribute("pass") = "by value"
                case "byref"
                    nt->attribute("pass") = "by reference"
                case "as"
                    seen_as = true
                case else
                    if seen_as = false then
                        nt->attribute("name") = trim(pwords(m))
                    else
                        ttype = ttype & " " & trim(pwords(m))
                    end if
                end select
            next
            var hasdef = instr(ttype,"=")
            if hasdef > 0 then
                var defs = trim(mid(ttype,hasdef+1))
                ttype = trim(mid(ttype,1,hasdef-1))
                nt->attribute("type") = ttype
                nt->attribute("default-value") = defs
            else
                nt->attribute("type") = trim(ttype)
            end if
        end if
    next

end sub

function getLinetype( byval xnode as ext.xml.node ptr, byref lstr as const string ) as linetype

    'var lstr = trim(ReadNextLine)

    if lstr = "" then return linetype.whitespace

    if left(lstr,1) = "'" or left(lcase(lstr),3) = "rem" then return linetype.comment

    var detect = isPreProcessor( xnode, lstr )
    if detect >= linetype.include then return linetype.include

    detect = isType( xnode, lstr )
    if detect = linetype.type_ then return linetype.type_
    if left(lcase(lstr),8) = "end type" then last_was_in = null

    scope
    var detect = isfunction( xnode, lstr )
    if detect = "" then return linetype.code
    dim as ext.xml.node ptr last_func
    dim status as statuscodes
    var hash = ext.hashes.crc32(trim(lcase(lstr)))

    'return detect
    'proc defines first
    if (detect[1] = asc("[") orelse detect[1] = asc("{") _
        orelse detect[1] = asc("]") orelse detect[1] = asc("}")) _
        AND len(detect)>3 then

        select case detect[0]
            case asc(":") 'subdecl
                var nt = findFunction(xnode, ext.hashes.crc32("declare " & trim(lcase(lstr))))
                if nt = 0 then
                    if last_was_in <> null then
                        if last_was_in->child("functions") = null then last_was_in->appendChild("functions")
                        nt = last_was_in->child("functions")->appendChild("sub")
                    else
                        if xnode->child("functions") = null then xnode->appendChild("functions")
                        nt = xnode->child("functions")->appendChild("sub")
                    end if
                end if
                last_func = nt
                nt->attribute("name") = right(detect,len(detect)-3)
                nt->attribute("defined-on") = str(ln)
                if nt->attribute("signature-hash") = "" then nt->attribute("signature-hash") = hex(ext.hashes.crc32("declare " & trim(lcase(lstr))))
                nt->attribute("signature") = detect
                select case detect[1] 'calling convention
                    case asc("[") 'none set
                        'nt->attribute("call-conv") = "fbcall"
                    case asc("{") 'cdecl
                        nt->attribute("calling-convention") = "cdecl"
                    case asc("]") 'pascal
                        nt->attribute("calling-convention") = "pascal"
                    case asc("}") 'stdcall
                        nt->attribute("calling-convention") = "stdcall"
                end select
                if detect[2] = asc("<") then
                    nt->attribute("exported") = "true"
                else
                    nt->attribute("exported") = "false"
                end if
            case asc(";") 'funcdecl
                var nt = findFunction(xnode, ext.hashes.crc32("declare " & trim(lcase(lstr))))
                if nt = 0 then
                    if last_was_in <> null then
                        if last_was_in->child("functions") = null then xnode->appendChild("functions")
                        nt = last_was_in->child("functions")->appendChild("function")
                    else
                        if xnode->child("functions") = null then xnode->appendChild("functions")
                        nt = xnode->child("functions")->appendChild("function")
                    end if
                end if
                last_func = nt
                nt->attribute("name") = right(detect,len(detect)-3)
                nt->attribute("defined-on") = str(ln)
                if nt->attribute("signature-hash") = "" then nt->attribute("signature-hash") = hex(ext.hashes.crc32("declare " & trim(lcase(lstr))))
                nt->attribute("signature") = detect
                select case detect[1] 'calling convention
                    case asc("[") 'fbcall
                        'nt->attribute("call-conv") = "fbcall"
                    case asc("{") 'cdecl
                        nt->attribute("calling-convention") = "cdecl"
                    case asc("]") 'pascal
                        nt->attribute("calling-convention") = "pascal"
                    case asc("}") 'stdcall
                        nt->attribute("calling-convention") = "stdcall"
                end select
                if detect[2] = asc("<") then
                    nt->attribute("exported") = "true"
                else
                    nt->attribute("exported") = "false"
                end if
        end select
        status = inFunction

    else 'then declares
        select case detect[0]
            case asc(":") 'subdecl
                if xnode->child("functions") = null then xnode->appendChild("functions")
                var nt = xnode->child("functions")
                if last_was_in <> null then
                        if last_was_in->child("functions") = null then last_was_in->appendChild("functions")
                        nt = last_was_in->child("functions")->appendChild("sub")
                    else
                        if xnode->child("functions") = null then xnode->appendChild("functions")
                        nt = xnode->child("functions")->appendChild("sub")
                    end if
                nt->attribute("name") = right(detect,len(detect)-1)
                nt->attribute("signature-hash") = hex(hash)
                nt->attribute("declared-on") = str(ln)
                'nt->attribute("signature-d") = lstr 'detect
                var lp = instr(lstr,"(")
                var rp = instrrev(lstr,")")
                var params = trim(mid(lstr,lp+1,rp-lp-1))
                if params = "" then params = "none"
                'nt->attribute("parameters") = params
                var nc = nt->appendChild("parameters")
                processParams(nc,params)
                if nc->children = 0 then nt->removeChild("parameters")
            case asc(";") 'funcdecl
                if xnode->child("functions") = null then xnode->appendChild("functions")
                var nt = xnode->child("functions")
                if last_was_in <> null then
                        if last_was_in->child("functions") = null then last_was_in->appendChild("functions")
                        nt = last_was_in->child("functions")->appendChild("function")
                    else
                        if xnode->child("functions") = null then xnode->appendChild("functions")
                        nt = xnode->child("functions")->appendChild("function")
                    end if
                nt->attribute("name") = right(detect,len(detect)-1)
                nt->attribute("signature-hash") = hex(hash)
                nt->attribute("declared-on") = str(ln)
                'nt->attribute("signature-d") = lstr 'detect
                var lp = instr(lstr,"(")
                var rp = instrrev(lstr,")")
                var params = trim(mid(lstr,lp+1,rp-lp-1))
                'nt->attribute("parameters") = params
                var nc = nt->appendChild("parameters")
                processParams(nc,params)
                if nc->children = 0 then nt->removeChild("parameters")
                var las = instr(rp,lstr,"as")
                var retp = trim(mid(lstr,las+2))
                nt->attribute("return-type") = retp
        end select
    end if



    end scope

    return linetype.code

end function

private function findFunction( byval xnode as ext.xml.node ptr, byval hash as uinteger ) as ext.xml.node ptr

    dim nt as ext.xml.node ptr
    if last_was_in <> null then
        nt = last_was_in
    else
        nt = xnode
    end if
    var sch = nt->child("functions")->children("sub")
    var fch = nt->child("functions")->children("function")

    if sch > 0 then
        for n as integer = 0 to sch-1
            if nt->child("functions")->child("sub",n)->attribute("signature-hash") = hex(hash) then return nt->child("functions")->child("sub",n)
        next
    end if


    if fch > 0 then
        for n as integer = 0 to fch-1
            if nt->child("functions")->child("function",n)->attribute("signature-hash") = hex(hash) then return nt->child("functions")->child("function",n)
        next
    end if

    return 0

end function

function getFunctionSignature( byref lstr as const string ) as string

    dim as ext.bool isSub = true
    if instr(lcase(lstr),"sub") <1 then isSub = false

    var lparens = instr(lstr,"(")

    ''detect sub subname, and func funcname as return type
    if lparens < 1 then
        if isSub then return "( )"
        return ""'getReturnType(lstr) & " ( )"
    end if




end function

enum typeofparam
declare_
name_
callconv
as_
ppc
variadic
proctype
visibility
end enum

private function typeOfParameter( byref x as const string ) as typeofparam

    select case lcase(x)
        case "declare"
            return typeofparam.declare_
        case "sub", "function", "operator", "constructor", "property", "destructor"
            return typeofparam.proctype
        case "as"
            return typeofparam.as_
        case "byval", "byref", "bydesc"
            return typeofparam.ppc
        case "cdecl", "stdcall", "pascal"
            return typeofparam.callconv
        case "..."
            return typeofparam.variadic
        case "public", "private", "export"
            return typeofparam.visibility
        case else
            return typeofparam.name_
    end select

end function

function isFunction( byval xnode as ext.xml.node ptr, byref lstr as const string ) as string


    if instr(lcase(lstr),"declare") > 0 then
        'proc declare
        var newlstr = trim(right(lstr,len(lstr)-7))
        var iss = instr(lcase(newlstr),"sub")
        var isf = instr(lcase(newlstr),"function")
        if iss > 0 then
            newlstr = trim(mid(newlstr,iss+3))
            var wh = instr(newlstr,"(")
            var wh2 = instr(iss,newlstr," ")
            if wh2 < wh then swap wh, wh2
            if wh > 0 then
                newlstr = mid( newlstr, 1, wh-1 )
            end if
            if trim(newlstr) = "" then return ""
            return ":" & newlstr
        elseif isf > 0 then
            newlstr = trim(mid(newlstr,isf+8))
            var wh = instr(newlstr,"(")
            var wh2 = instr(isf, newlstr," ")
            if wh2 < wh then swap wh, wh2
            if wh > 0 then
                newlstr = mid( newlstr, 1, wh-1 )
            end if
            if trim(newlstr) = "" then return ""
            return ";" & newlstr
        else
            return ""
        end if

    else

        if (instr(lcase(lstr),"sub ") > 0 orelse instr(lcase(lstr),"function ") > 0) _
            ANDALSO left(lcase(lstr),4) <> "type" then
            'its probably a proc
            if (left(lcase(lstr),6) <> "public" orelse left(lcase(lstr),7) <> "private") ANDalso _
            (instr(lcase(lstr),"sub")>1 ORELSE instr(lcase(lstr),"function")>1) then return ""
            var ret = ""
            var cal = "[" 'FBCALL 0[, CDECL 1{, PASCAL 2], STDCALL 3}
            var exported = "," ', - 1<
            var whz = 5
            var wh = instr(lstr,"sub ")
            if wh <1 then wh = instr(lstr,"sub ")
            if wh <1 then
                wh = instr(lstr,"function ")
                if wh <1 then wh = instr(lstr,"function ")
                whz = 10
                ret = ";"
            else
                ret = ":"
            end if
            var newlstr = trim(mid(lstr,wh))
            var wh3 = instr(wh,newlstr,"(")
            var wh2 = instr(wh,newlstr," ")
            if wh3 < wh2 then swap wh2, wh3
            wh3 = instr(wh2+1,newlstr,"(")
            var wh4 = instr(wh2+1,newlstr," ")
            if wh4 < wh3 then swap wh3, wh4
            var fname = trim(mid(newlstr,wh2+1,wh3-whz))
            if fname = "" then return ""

            if instr(lcase(lstr),"cdecl")>0 then cal = "{"
            if instr(lcase(lstr),"pascal")>0 then cal = "]"
            if instr(lcase(lstr),"stdcall")>0 then cal = "}"
            if instr(lcase(lstr),"export")>0 then exported = "<"

            var wlstr = lcase(lstr)
            if instr(wlstr,"end sub") > 0 ORELSE _
            instr(wlstr,"end function") > 0 ORELSE _
            instr(wlstr,!"\"function\"")> 0 ORELSE _
            instr(wlstr,!"\"sub\"")>0 then return ""

            return ret & cal & exported & fname
        end if

    end if

    return ""


end function

type testTypeForwarding as integer

function isType( byval xnode as ext.xml.node ptr, byref lstr as const string ) as linetype

    if left(lcase(lstr),5) = "type " then

        var ret = trim(right(lstr,len(lstr)-4))
        var spa = instr(ret," ")
        if spa > 0 then
            ret = mid( ret, 1, spa-1 )
        end if

        var nt = xnode->appendChild("type")
        nt->attribute("name") = ret
        nt->attribute("defined-on") = str(ln)

        var aaa = instr(lcase(lstr)," as ")
        if aaa>1 then
            var wh2 = instr(lstr," ")
            if wh2 <0 then len(lstr)
            ret = mid(lstr, aaa+3, (wh2-1)-(aaa+3))
            nt->attribute("redirects-to") = trim(ret)
        else
            last_was_in = nt
        end if

        return linetype.type_

    end if

    return linetype.unknown

end function

function isPreProcessor( byval xnode as ext.xml.node ptr, byref lstr as const string ) as linetype

    var llstr = trim(lstr)

    'if llstr[0] = asc("#") then

    if left(lcase(llstr),8) = "#include" ORELSE left(lcase(llstr),9) = "# include" then

        var wh = instr(lstr, !"\"" )
        var wh2 = instr(wh+1, lstr, !"\"" )
        var ret = mid(lstr, wh+1, (wh2-1)-wh)
        var nt = xnode->appendChild("file-include",node_type_e.text)
        nt->setText = ret
        nt->attribute("line") = str(ln)
        if instr(lstr, "once")>0 and instr(lstr,"once")<wh then _
        nt->attribute("pragma") = "once"

        return linetype.include

    end if

    if left(lcase(llstr),7) = "#inclib" ORELSE left(lcase(llstr),8) = "# inclib" then

        var wh = instr(lstr, !"\"" )
        var wh2 = instr(wh+1, lstr, !"\"" )
        var ret = mid(lstr, wh+1, (wh2-1)-wh)

        var nt = xnode->appendChild("library-include",node_type_e.text)
        nt->setText = ret
        nt->attribute("line") = str(ln)

        return linetype.include

    end if
    'end if

    return linetype.unknown

end function
