''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
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

#ifdef __FB_WIN32__
#define CSLASH "\"
#define CONFIG_DIR environ("APPDATA") & CSLASH & __appname & CSLASH
#define CONFIG_NAME "config.xml"
#endif

#ifdef __FB_DOS__
#define CSLASH "\"
#define CONFIG_DIR exepath() & CSLASH
#define CONFIG_NAME left(__appname,8) & ".cfg"
#endif

#ifdef __FB_LINUX__
#define CSLASH "/"
#define CONFIG_DIR environ("HOME") & CSLASH & ".config" & CSLASH & __appname & CSLASH
#define CONFIG_NAME "config.xml"
#endif

#include once "ext/config.bi"
#include once "ext/strings/manip.bi"
#include once "vbcompat.bi"

namespace ext.config

dim shared __appname as string
dim shared _path as string
dim shared __tree as ext.xml.tree ptr

sub setAppName( byref appn as string )
    __appname = appn
    _path = CONFIG_DIR & CONFIG_NAME
end sub

sub setPath( byref path as string )
    _path = path
end sub

sub load()
    if __tree <> null then return
    if _path = "" then
        __appname = "UnnamedApp"
        _path = CONFIG_DIR & CONFIG_NAME
    end if

    __tree = new ext.xml.tree
    if fileexists(_path) then
        __tree->load(_path)
    else
        if _path = CONFIG_DIR & CONFIG_NAME then
            mkdir(CONFIG_DIR)
        end if
        __tree->root->appendchild(__appname)
    end if
end sub

sub save()

    var pretty = cast(string, *__tree)
    ext.strings.replace( pretty, ">", ">" & vbNewLine )

    open _path for output access write as #1
    print #1, pretty
    close #1

    delete __tree
    __tree = 0

end sub

function exists( byref name_ as string ) as ext.bool

    if __tree->root->child(__appname)->children(name_) > 0 then
        return ext.bool.true
    else
        return ext.bool.false
    end if

end function

sub remove( byref name_ as string )

    __tree->root->child(__appname)->removeChild(name_)

end sub

function getBool( byref name_ as string, byval default as ext.bool = ext.bool.false ) as ext.bool

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        var create = __tree->root->child(__appname)->appendChild(name_)
        select case default
        case ext.bool.true, ext.bool.ctrue
            create->attribute("enable") = "true"
        case ext.bool.false
            create->attribute("enable") = "false"
        case else
            create->attribute("enable") = "invalid"
        end select
        return default
    end if

    var ret2 = trim(ret->attribute("enable"))
    select case lcase(ret2)
    case "true"
        return ext.bool.true
    case "false"
        return ext.bool.false
    case else
        return default
    end select

end function

sub getBoolArray( byref name_ as string, byref subname as string, array() as ext.bool )

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        ret = __tree->root->child(__appname)->appendChild(name_)
    end if

    var chc = ret->children(subname)
    if chc-1 > ubound(array) then
        redim preserve array(chc-1)
    end if

    for n as integer = lbound(array) to ubound(array)

        var ch = ret->child(subname,n)

        if ch = ext.null then
            ch = ret->appendChild(subname)

            select case array(n)
            case ext.bool.true, ext.bool.ctrue
                ch->attribute("enable") = "true"
            case ext.bool.false
                ch->attribute("enable") = "false"
            case else
                ch->attribute("enable") = "invalid"
            end select

        else
            var ts = ch->attribute("enable")
            select case ts
            case "true"
                array(n) = ext.bool.true
            case "false"
                array(n) = ext.bool.false
            case else
                array(n) = ext.bool.invalid
            end select
        end if

    next

end sub

function getString( byref name_ as string, byref default as string = "" ) as string

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        var create = __tree->root->child(__appname)->appendChild(name_,ext.xml.node_type_e.text)
        create->setText = default
        return default
    end if

    var ret2 = trim(ret->getText)
    select case len(ret2)
    case is > 0
        return ret2
    case else
        return default
    end select

end function

sub getStringArray( byref name_ as string, byref subname as string, array() as string )

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        ret = __tree->root->child(__appname)->appendChild(name_)
    end if

    var chc = ret->children(subname)
    if chc-1 > ubound(array) then
        redim preserve array(chc-1)
    end if

    for n as integer = lbound(array) to ubound(array)

        var ch = ret->child(subname,n)

        if ch = ext.null then
            ch = ret->appendChild(subname,ext.xml.node_type_e.text)
            ch->setText = array(n)
        else
            array(n) = ch->getText
        end if

    next

end sub

function getInteger( byref name_ as string, byval default as integer = 0 ) as integer

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        var create = __tree->root->child(__appname)->appendChild(name_)
        create->attribute("value") = str(default)
        return default
    end if

    var ret2 = trim(ret->attribute("value"))
    select case len(ret2)
    case is > 0
        return valint(ret2)
    case else
        return default
    end select

end function

sub getIntegerArray( byref name_ as string, byref subname as string, array() as integer )

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        ret = __tree->root->child(__appname)->appendChild(name_)
    end if

    var chc = ret->children(subname)
    if chc-1 > ubound(array) then
        redim preserve array(chc-1)
    end if

    for n as integer = lbound(array) to ubound(array)

        var ch = ret->child(subname,n)

        if ch = ext.null then
            ch = ret->appendChild(subname)
            ch->attribute("value") = str(array(n))
        else
            array(n) = valint(ch->attribute("value"))
        end if

    next

end sub

function getDouble( byref name_ as string, byval default as double = 0.0 ) as double

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        var create = __tree->root->child(__appname)->appendChild(name_)
        create->attribute("value") = str(default)
        return default
    end if

    var ret2 = trim(ret->attribute("value"))
    select case len(ret2)
    case is > 0
        return val(ret2)
    case else
        return default
    end select

end function

sub getDoubleArray( byref name_ as string, byref subname as string, array() as double )

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        ret = __tree->root->child(__appname)->appendChild(name_)
    end if

    var chc = ret->children(subname)
    if chc-1 > ubound(array) then
        redim preserve array(chc-1)
    end if

    for n as integer = lbound(array) to ubound(array)

        var ch = ret->child(subname,n)

        if ch = ext.null then
            ch = ret->appendChild(subname)
            ch->attribute("value") = str(array(n))
        else
            array(n) = val(ch->attribute("value"))
        end if

    next

end sub

function get_rawxml( byref name_ as string ) as ext.xml.node ptr

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        var ret2 = __tree->root->child(__appname)->appendChild(name_)
        return ret2
    else
        return ret
    end if

end function

sub setBool( byref name_ as string, byval v as ext.bool )

    var ret = __tree->root->child(__appname)->child(name_)
    dim create as ext.xml.node ptr

    if ret = ext.null then
        create = __tree->root->child(__appname)->appendChild(name_)
    else
        create = ret
    end if

    select case v
    case ext.bool.true, ext.bool.ctrue
        create->attribute("enable") = "true"
    case ext.bool.false
        create->attribute("enable") = "false"
    case else
        create->attribute("enable") = "invalid"
    end select

end sub

sub setBoolArray( byref name_ as string, byref subname as string, array() as ext.bool )

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        ret = __tree->root->child(__appname)->appendChild(name_)
    end if

    for n as integer = lbound(array) to ubound(array)

        var ch = ret->child(subname,n)

        if ch = ext.null then
            ch = ret->appendChild(subname)
        end if

        select case array(n)
        case ext.bool.true, ext.bool.ctrue
            ch->attribute("enable") = "true"
        case ext.bool.false
            ch->attribute("enable") = "false"
        case else
            ch->attribute("enable") = "invalid"
        end select

    next

end sub

sub setString( byref name_ as string, byref v as string )

    var ret = __tree->root->child(__appname)->child(name_)
    dim create as ext.xml.node ptr

    if ret = ext.null then
        create = __tree->root->child(__appname)->appendChild(name_,ext.xml.node_type_e.text)
    else
        create = ret
    end if

    create->setText = v

end sub

sub setStringArray( byref name_ as string, byref subname as string, array() as string )

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        ret = __tree->root->child(__appname)->appendChild(name_)
    end if

    for n as integer = lbound(array) to ubound(array)

        var ch = ret->child(subname,n)

        if ch = ext.null then
            ch = ret->appendChild(subname,ext.xml.node_type_e.text)
        end if

        ch->setText = array(n)

    next

end sub

sub setInteger( byref name_ as string, byval v as integer )

    var ret = __tree->root->child(__appname)->child(name_)
    dim create as ext.xml.node ptr

    if ret = ext.null then
        create = __tree->root->child(__appname)->appendChild(name_)
    else
        create = ret
    end if

    create->attribute("value") = str(v)

end sub

sub setIntegerArray( byref name_ as string, byref subname as string, array() as integer )

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        ret = __tree->root->child(__appname)->appendChild(name_)
    end if

    for n as integer = lbound(array) to ubound(array)

        var ch = ret->child(subname,n)

        if ch = ext.null then
            ch = ret->appendChild(subname)
        end if

        ch->attribute("value") = str(array(n))

    next

end sub

sub setDouble( byref name_ as string, byval v as double )

    var ret = __tree->root->child(__appname)->child(name_)
    dim create as ext.xml.node ptr

    if ret = ext.null then
        create = __tree->root->child(__appname)->appendChild(name_)
    else
        create = ret
    end if

    create->attribute("value") = str(v)

end sub

sub setDoubleArray( byref name_ as string, byref subname as string, array() as double )

    var ret = __tree->root->child(__appname)->child(name_)

    if ret = ext.null then
        ret = __tree->root->child(__appname)->appendChild(name_)
    end if

    for n as integer = lbound(array) to ubound(array)

        var ch = ret->child(subname,n)

        if ch = ext.null then
            ch = ret->appendChild(subname)
        end if

        ch->attribute("value") = str(array(n))

    next

end sub

end namespace
