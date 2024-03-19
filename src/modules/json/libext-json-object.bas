''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
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

#define fbext_NoBuiltinInstanciations() 1
#include once "ext/json.bi"
#include once "ext/containers/stack.bi"
#include once "ext/misc.bi"
#include once "ext/conversion/base64.bi"

fbext_Instanciate( fbExt_Stack, ((integer)) )

namespace ext.json

private function get_ename_len( byval b as const ubyte ptr ) as uinteger
    var i = 0u
    while b[i] <> 0
        i += 1
    wend
    return i + 1
end function

function get_ename( byval bson as const ubyte ptr, byref i as uinteger ) as string
    var nlen = get_ename_len(@(bson[i]))
    var tmp_k = space(nlen-1)
    memcpy(@(tmp_k[0]),@(bson[i]),nlen-1)
    i += nlen
    return tmp_k
end function

sub JSONobject.fromBSON( byval bson as const ubyte ptr, byval plen as ulong )

var index = 4u
dim as ubyte cur_obj = 0

var blen = *(cast(const ulong ptr, bson))

assert(blen = plen)

while index < plen
    select case cur_obj
    case 0: 'invalid obj, means we need to read a new one
        cur_obj = bson[index]
        index += 1

    case &h01: '"\x01" e_name double    Floating point
        var tmp_k = get_ename(bson,index)
        dim as double tmp_d
        memcpy(@tmp_d,@(bson[index]),sizeof(double))
        index += sizeof(double)
        this.addChild(tmp_k,new JSONvalue(tmp_d))
        cur_obj = 0

    case &h02, &h0d, &h0e: '"\x02" e_name string    UTF-8 string
        var tmp_k = get_ename(bson,index)
        index += 4
        var tmp_v = get_ename(bson,index)
        this.addChild(tmp_k,new JSONvalue(tmp_v))
        cur_obj = 0

    case &h03: '"\x03" e_name document  Embedded document
        var tmp_k = get_ename(bson,index)
        var dlen = *(cast(const ulong ptr,@(bson[index])))
        var edoc = new JSONobject
        edoc->fromBSON(@(bson[index]),dlen)
        index += dlen
        this.addChild(tmp_k,new JSONvalue(edoc))
        cur_obj = 0

    case &h04: '"\x04" e_name document  Array
        var tmp_k = get_ename(bson,index)
        var dlen = *(cast(const ulong ptr,@(bson[index])))
        var edoc = new JSONobject
        edoc->fromBSON(@(bson[index]),dlen)
        index += dlen
        var earr = new JSONarray(edoc->children())
        for n as integer = 0 to edoc->children()-1
            earr->at(n) = edoc->child(n)->value
        next
        delete edoc
        this.addChild(tmp_k,new JSONvalue(earr))
        cur_obj = 0

    case &h05: '"\x05" e_name binary    Binary data
        var tmp_k = get_ename(bson,index)
        var blen = *(cast(const ulong ptr,@(bson[index])))
        index += 4
        var subtype = bson[index]
        index += 1
        var tmp_r = ""
        select case subtype
        case 0,1,2,&h80:
            tmp_r = ext.conversion.base64.encode(@(bson[index]),blen)

        case 3,4: 'uuid
            dim tmp_u as ext.misc.UUID
            for n as integer = 0 to 15
                tmp_u.d(n) = bson[index+n]
            next
            tmp_r = str(tmp_u)

        case 5: '16 byte md5
            for n as integer = 0 to 15
                var x = bson[index+n]
                var xh = hex(x)
                if len(xh) < 2 then
                    tmp_r = tmp_r & "0" & xh
                else
                    tmp_r = tmp_r & xh
                end if
            next

        end select
        cur_obj = 0
        this.addChild(tmp_k,new JSONvalue(tmp_r))
        index += blen

    case &h07: '"\x07" e_name (byte*12)     ObjectId
        var tmp_k = get_ename(bson,index)
        var tmp_v = ""
        for n as integer = 0 to 11
            var x = bson[index + n]
            var xh = hex(x)
            if len(xh) < 2 then xh = "0" & xh
            tmp_v = tmp_v & xh
        next
        index += 12
        this.addChild(tmp_k,new JSONvalue(tmp_v))
        cur_obj = 0

    case &h08: '"\x08" e_name "\x00"    Boolean "false"
               '"\x08" e_name "\x01"    Boolean "true"
        var tmp_k = get_ename(bson,index)
        var tb = bson[index]
        if tb = 0 then
            this.addChild(tmp_k,new JSONvalue(false))
        elseif tb = 1 then
            this.addChild(tmp_k,new JSONvalue(true))
        end if
        cur_obj = 0
        index += 1

    case &h06, &h0a: '"\x0A" e_name   Null value
        var tmp_k = get_ename(bson,index)
        cur_obj = 0
        index += 1
        this.addChild(tmp_k,new JSONvalue())

    case &h0b: '"\x0B" e_name cstring cstring   Regular expression
        var tmp_k = get_ename(bson,index)
        var tmp_r = get_ename(bson,index)
        var tmp_p = get_ename(bson,index)
        cur_obj = 0
        this.addChild(tmp_k,new JSONvalue(tmp_r & chr(7) & tmp_p))

    case &h0c:
        var tmp_k = get_ename(bson,index)
        index += 4
        var tmp_b = get_ename(bson,index)
        var tmp_v = ""
        for n as integer = 0 to 11
            var x = bson[index + n]
            var xh = hex(x)
            if len(xh) < 2 then xh = "0" & xh
            tmp_v = tmp_v & xh
        next
        index += 12
        cur_obj = 0
        this.addChild(tmp_k,new JSONvalue(tmp_b & chr(7) & tmp_v))

    case &h0f: '"\x0F" e_name code_w_s  JavaScript code w/ scope
        var tmp_k = get_ename(bson,index)
        var dlen = *(cast(const ulong ptr,@(bson[index])))
        index += dlen
        cur_obj = 0
        this.addChild(tmp_k,new JSONvalue("Not Implemented"))

    case &h10: '"\x10" e_name int32     32-bit Integer
        var tmp_k = get_ename(bson,index)
        var tmp_v = *(cast(const long ptr,@(bson[index])))
        index += 4
        cur_obj = 0
        this.addChild(tmp_k,new JSONvalue(cdbl(tmp_v)))

    case &h09, &h11, &h12: '"\x11" e_name int64     Timestamp
        var tmp_k = get_ename(bson,index)
        var tmp_v = *(cast(const ulongint ptr,@(bson[index])))
        index += 8
        cur_obj = 0
        this.addChild(tmp_k,new JSONvalue(str(tmp_v)))

    end select
wend

end sub

function JSONobject.toBSON( byref buf_len as ulong ) as ubyte ptr
    dim ret as ubyte ptr
    var total_len = 0u
    if m_children = 0 then
        buf_len = sizeof(ulong)+1
        ret = new ubyte[buf_len]
        *cast(ulong ptr,ret) = buf_len
        ret[buf_len-1] = 0

    else
        dim vret_len as ulong
        dim vret as ubyte ptr
        for n as uinteger = 0 to m_children -1
            vret = m_child[n]->toBSON(vret_len)
            total_len += vret_len
            var t_ret = new ubyte[total_len]
            memcpy(t_ret,ret,total_len-vret_len)
            memcpy(@(t_ret[total_len-vret_len]),vret,vret_len)
            delete[] ret
            ret = t_ret
            delete[] vret
        next
        buf_len = total_len + sizeof(ulong) + 1
        var t_ret = new ubyte[buf_len]
        *(cast(ulong ptr, t_ret)) = buf_len
        memcpy(@(t_ret[sizeof(ulong)]),ret,total_len)
        delete[] ret
        ret = t_ret
        ret[buf_len-1] = 0

    end if

    return ret

end function

function JSONobject.addChild( byref k as const string, byval v as JSONvalue ptr ) as JSONvalue ptr

    if m_children > 0 then
        dim new_c as JSONpair ptr ptr
        m_children += 1
        new_c = callocate( sizeof(JSONpair ptr) * m_children )

        memcpy(new_c,m_child,sizeof(JSONpair ptr)*(m_children-1))
        deallocate m_child
        m_child = new_c
    else
        m_children = 1
        m_child = callocate( sizeof(JSONpair ptr) * 1 )
    end if

    m_child[m_children-1] = new JSONpair(k,v)
    return v

end function

function JSONobject.hasChild( byref k as const string, byref child_index as uinteger = 0 ) as bool
    if m_children > 0 then
        for n as uinteger = 0 to m_children - 1
            if m_child[n]->key = k then
                child_index = n
                return true
            end if
        next n
    end if
    
    return false
end function

sub JSONobject.removeChild( byref k as const string )

    if m_children > 0 then
        var rem_id = -1u

        if hasChild(k, rem_id) then

            dim new_child as JSONpair ptr ptr
            new_child = callocate( sizeof(JSONpair ptr) * m_children - 1 )
            if new_child = 0 then return
            var cnt = 0u
            for n as uinteger = 0 to m_children-2
                if cnt <> rem_id then
                    new_child[n] = m_child[cnt]
                end if
                cnt += 1
            next
            deallocate(m_child)
            m_child = new_child
            m_children = m_children -1

        end if

    end if

end sub

operator JSONobject.cast() as string

    if m_children = 0 then return "{}"

    if m_children = 1 then
        if m_child[0]->key = "" then 'hack to allow in and out of top-level arrays
            return cast(string,*(m_child[0]->value))
        end if
    end if

    var ret = "{ "
    for n as uinteger = 0 to m_children -1
        ret = ret & *(m_child[n])
        if n < m_children-1 then
            ret = ret & ", "
        end if
    next

    return ret & " }"
end operator

#define FBEXT_CHAR_IS_WHITESPACE(c) ((c) = &h09 or (c) = &h0a or (c) = &h0d or (c) = &h20)
#define JSON_QUOTE ASC(!"\"")
#define JSON_OPEN_B ASC("{")
#define JSON_CLOS_B ASC("}")
#define JSON_OPEN_A ASC("[")
#define JSON_CLOS_A ASC("]")

enum parser_state
    begin_object
    begin_pair
    begin_string
    end_string
    pair_mid
    begin_array
    array_sep
    end_array
    end_pair
    end_object
end enum

private function parse_string( byref j as const ubyte ptr, byval i as uinteger, byref end_ as uinteger ) as string
    var ret = ""
    var n = i
    while j[n] <> JSON_QUOTE andalso j[n] <> 0
        ret = ret & chr(j[n])
        n += 1
    wend
    end_ = n + 1
    return ret
end function

declare function parse_array( byref j as const ubyte ptr, byval i as uinteger, byref end_ as uinteger ) as JSONarray ptr

private function parse_object( byval t as JSONobject ptr, byref j as const ubyte ptr, byval i as uinteger, byref end_ as uinteger = 0 ) as JSONobject ptr

    dim pstate as fbext_Stack( ((integer)) )
    pstate.Push(begin_object)
    pstate.Push(begin_pair)

    dim as string str1, str2
    dim as JSONobject ptr obj
    dim as JSONarray ptr arr
    dim as double numbe

    var n = i

    while j[n] <> 0

    'if n > len(j)-1 then exit while
        if j[n] = JSON_CLOS_B then exit while
        if j[n] = JSON_QUOTE then
            if str1 = "" then

                str1 = parse_string(j,n+1,n)
                continue while
            else

                str2 = parse_string(j,n+1,n)
                t->addChild(str1,new JSONvalue(str2))
                continue while
            end if
        end if
        if j[n] = asc(",") then
            if str1 <> "" andalso str2 <> "" then

                    select case lcase(str2)
                    case "true"
                        t->addChild(str1,new JSONvalue(true))
                    case "false"
                        t->addChild(str1,new JSONvalue(false))
                    case "null"
                        t->addChild(str1,new JSONvalue())
                    case else
                        numbe = val(str2)
                        t->addChild(str1,new JSONvalue(numbe))
                    end select
            end if
            pstate.Push(end_pair)
            pstate.Push(begin_pair)
            str1 = ""
            str2 = ""
            obj = 0
            arr = 0
            n += 1
            continue while
        end if
        if j[n] = asc(":") then

            n += 1
            continue while
        end if
        if j[n] = JSON_OPEN_B then

            if str1 = "" then return 0
            obj = parse_object(new JSONobject,j,n+1,n)
            t->addChild(str1,new JSONvalue(obj))
            obj = 0
            str1 = ""
            continue while
        end if
        if j[n] = JSON_OPEN_A then

            if str1 = "" then return 0
            arr = parse_array(j,n+1,n)
            t->addChild(str1,new JSONvalue(arr))
            n+=1
            str1 = ""
            str2 = ""
            arr = 0
            continue while
        end if

        if j[n] = JSON_CLOS_A then

            n += 1
            continue while
        end if

        if str1 <> "" then
            if not FBEXT_CHAR_IS_WHITESPACE(j[n]) then

                str2 = str2 & chr(j[n])
            else
                if str2 <> "" then

                    select case lcase(str2)
                    case "true"
                        t->addChild(str1,new JSONvalue(true))
                    case "false"
                        t->addChild(str1,new JSONvalue(false))
                    case "null"
                        t->addChild(str1,new JSONvalue())
                    case else
                        numbe = val(str2)
                        t->addChild(str1,new JSONvalue(numbe))
                    end select
                    n += 1
                    str1 = ""
                    str2 = ""
                    continue while
                end if
            end if
        end if

    n += 1
    wend

    end_ = n
    return t

end function

private function parse_array( byref j as const ubyte ptr, byval i as uinteger, byref end_ as uinteger ) as JSONarray ptr

    dim arr() as JSONvalue ptr

    var n = i
    var c = 0
    var c_l = -1

    var str1 = ""

    while j[n] <> 0

        if j[n] = JSON_CLOS_A then exit while
        if j[n] = JSON_QUOTE then
            str1 = parse_string(j,n+1,n)
            c_l += 1
            c += 1
            redim preserve arr( c )
            arr(c_l) = new JSONvalue(str1)
            str1 = ""
            n+=1
            continue while
        end if
        if j[n] = asc(",") then
            if str1 <> "" then
                c_l += 1
                c += 1

                redim preserve arr( c )
                    select case lcase(str1)
                    case "true"
                        arr(c_l) = new JSONvalue(true)
                    case "false"
                        arr(c_l) = new JSONvalue(false)
                    case "null"
                        arr(c_l) = new JSONvalue()
                    case else
                        var numbe = val(str1)
                        arr(c_l) = new JSONvalue(numbe)
                    end select
                str1 = ""
                n+=1
                continue while
            end if
        end if
        if j[n] = JSON_OPEN_B then
            var obj = parse_object(new JSONobject,j,n+1,n)
            c_l += 1
            c += 1
            redim preserve arr( c )
            arr(c_l) = new JSONvalue(obj)
            str1 = ""
            n+=1
            continue while
        end if
        if j[n] = JSON_OPEN_A then
            var ar = parse_array(j,n+1,n)
            c_l += 1
            c += 1
            redim preserve arr( c )
            arr(c_l) = new JSONvalue(ar)
            n+=1
            str1 = ""
            continue while
        end if
            if not FBEXT_CHAR_IS_WHITESPACE(j[n]) then
                str1 = str1 & chr(j[n])
                n += 1
                continue while
            else
                if str1 <> "" then
                    c_l += 1
                    c += 1

                    redim preserve arr( c )
                    select case lcase(str1)
                    case "true"
                        arr(c_l) = new JSONvalue(true)
                    case "false"
                        arr(c_l) = new JSONvalue(false)
                    case "null"
                        arr(c_l) = new JSONvalue()
                    case else
                        var numbe = val(str1)
                        arr(c_l) = new JSONvalue(numbe)
                    end select
                    n+=1
                    str1 = ""
                    continue while
                end if
            end if

    n += 1

    wend

    end_ = n + 1
    dim as JSONvalue ptr ptr x
    x = callocate(sizeof(JSONvalue ptr)*(ubound(arr)-lbound(arr))+1)

    for m as uinteger = 0 to ubound(arr)
        x[m] = arr(m)
    next

    return new JSONarray(x,ubound(arr))

end function

function JSONobject.loadFile( byref f as File ) as JSONobject ptr

    var unused = 0u
    dim as ubyte ptr fbuf
    if f.open() = true then return null
    var fbuf_len = f.toBuffer(fbuf)

    for n as uinteger = 0 to fbuf_len-1

        if not FBEXT_CHAR_IS_WHITESPACE(fbuf[n]) then
            if fbuf[n] = JSON_OPEN_B then
                parse_object(@this,fbuf,n+1,unused)
                return @this
            end if
            if fbuf[n] = JSON_OPEN_A then
                var arr = parse_array(fbuf,n+1,unused)
                addChild("",new JSONvalue(arr))
                return @this
            end if
        end if

    next

    delete[] fbuf

    return @this

end function

function JSONobject.loadString( byref jstr as const string ) as JSONobject ptr
    var unused = 0u
    for n as uinteger = 0 to len(jstr)-1

        if not FBEXT_CHAR_IS_WHITESPACE(jstr[n]) then
            if jstr[n] = JSON_OPEN_B then
                parse_object(@this,cast(ubyte ptr,@(jstr[0])),n+1,unused)
                return @this
            end if
            if jstr[n] = JSON_OPEN_A then
                var arr = parse_array(cast(ubyte ptr,@(jstr[0])),n+1,unused)
                addChild("",new JSONvalue(arr))
                return @this
            end if
        end if

    next

    return @this
end function

function JSONobject.child overload ( byref c as const string ) as JSONvalue ptr
    dim as uinteger index
    if (hasChild(c, index)) then
        return m_child[index]->value
    end if

    return null
end function

function JSONobject.child overload ( byval c as uinteger ) as JSONpair ptr
    if c > m_children-1 then return 0
    return m_child[c]
end function

function JSONobject.children() as uinteger
    return m_children
end function

destructor JSONobject
    if m_children > 0 then
        for n as uinteger = 0 to m_children -1
            delete m_child[n]
        next
        deallocate m_child
    end if
end destructor

end namespace
