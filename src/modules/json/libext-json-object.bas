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

#define fbext_NoBuiltinInstanciations() 1
#include once "ext/json.bi"
#include once "ext/containers/stack.bi"

fbext_Instanciate( fbExt_Stack, ((integer)) )

namespace ext.json

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

sub JSONobject.removeChild( byref k as const string )

    if m_children > 0 then
        var rem_id = -1u
        for n as uinteger = 0 to m_children -1
            if m_child[n]->key = k then
                rem_id = n
                exit for
            end if
        next

        if rem_id <> -1u then

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

private function parse_string( byref j as const string, byval i as uinteger, byref end_ as uinteger ) as string
    var ret = ""
    var n = i
    while j[n] <> JSON_QUOTE andalso n <= len(j) -1
        ret = ret & chr(j[n])
        n += 1
    wend
    end_ = n + 1
    return ret
end function

declare function parse_array( byref j as const string, byval i as uinteger, byref end_ as uinteger ) as JSONarray ptr

private function parse_object( byval t as JSONobject ptr, byref j as const string, byval i as uinteger, byref end_ as uinteger = 0 ) as JSONobject ptr

    dim pstate as fbext_Stack( ((integer)) )
    pstate.Push(begin_object)
    pstate.Push(begin_pair)

    dim as string str1, str2
    dim as JSONobject ptr obj
    dim as JSONarray ptr arr
    dim as double numbe

    var n = i

    while n <= len(j)-1

    if n > len(j)-1 then exit while
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

private function parse_array( byref j as const string, byval i as uinteger, byref end_ as uinteger ) as JSONarray ptr

    dim arr() as JSONvalue ptr

    var n = i
    var c = 0
    var c_l = -1

    var str1 = ""

    while n <= len(j)-1

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

function JSONobject.loadString( byref jstr as const string ) as JSONobject ptr
    var unused = 0u
    for n as uinteger = 0 to len(jstr)-1

        if not FBEXT_CHAR_IS_WHITESPACE(jstr[n]) then
            if jstr[n] = JSON_OPEN_B then
                parse_object(@this,jstr,n+1,unused)
                return @this
            end if
            if jstr[n] = JSON_OPEN_A then
                var arr = parse_array(jstr,n+1,unused)
                addChild("",new JSONvalue(arr))
                return @this
            end if
        end if

    next

    return @this
end function

function JSONobject.child overload ( byref c as const string ) as JSONvalue ptr
    dim as JSONpair ptr ret = null
    for n as uinteger = 0 to m_children -1
        ret = m_child[n]
        if ret->key = c then exit for
    next
    return ret->value
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
