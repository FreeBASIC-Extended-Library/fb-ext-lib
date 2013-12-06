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

#include once "ext/json.bi"

namespace ext.json

operator JSONvalue.Let ( byref rhs as const JSONvalue )

    select case rhs.m_type
    case jvalue_type.number
        m_number = rhs.m_number
    case jvalue_type.jstring
        m_string = rhs.m_string
    case jvalue_type.boolean
        m_bool = rhs.m_bool
    case jvalue_type.jobject
        if m_child <> 0 then
            if m_type = jvalue_type.jobject then
                delete cast(JSONobject ptr, m_child)
            else
                delete cast(JSONarray ptr, m_child)
            end if
        end if
        m_child = new JSONobject
        cast(JSONobject ptr, m_child)->loadString(*cast(JSONobject ptr,rhs.m_child))
    case jvalue_type.array
        if m_child <> 0 then
            if m_type = jvalue_type.jobject then
                delete cast(JSONobject ptr, m_child)
            else
                delete cast(JSONarray ptr, m_child)
            end if
        end if
        var mar = cast(JSONarray ptr, rhs.m_child)
        var marl = mar->length
        var x = new JSONvalue ptr[marl]
        for n as integer = 0 to marl -1
            x[n] = new JSONvalue(*(mar->at(n)))
        next
        m_child = new JSONarray(x,marl)
    end select
    m_type = rhs.m_type

end operator

constructor JSONvalue ( byref rhs as const JSONvalue )
    this = rhs
end constructor

constructor JSONvalue ( byval n as double )
    m_number = n
    m_type = jvalue_type.number
end constructor

constructor JSONvalue ( byref s as const string )
    m_string = s
    m_type = jvalue_type.jstring
end constructor

constructor JSONvalue ( byval b as bool )
    m_bool = b
    m_type = jvalue_type.boolean
end constructor

constructor JSONvalue ( byval o as JSONobject ptr )
    m_child = o
    m_type = jvalue_type.jobject
end constructor

constructor JSONvalue ( byval a as JSONarray ptr )
    m_child = a
    m_type = jvalue_type.array
end constructor

constructor JSONvalue
    m_type = jvalue_type.jnull
end constructor

operator JSONvalue.cast() as string
    var ret = ""
    select case m_type
    case jvalue_type.jobject
        ret = *(cast(JSONobject ptr,m_child))
    case jvalue_type.array
        ret = *(cast(JSONarray ptr,m_child))
    case jvalue_type.jstring
        ret = !"\"" & m_string & !"\""
    case jvalue_type.number
        ret = str(m_number)
    case jvalue_type.boolean
        if m_bool then
            ret = "true"
        else
            ret = "false"
        end if
    case else
        ret = "null"
    end select
    return ret
end operator

function JSONvalue.valueType() as jvalue_type
    return m_type
end function

function JSONvalue.getArray() as JSONarray ptr
    if m_type = jvalue_type.array then
        return m_child
    else
        return null
    end if
end function

function JSONvalue.getObject() as JSONobject ptr
    if m_type = jvalue_type.jobject then
        return m_child
    else
        return null
    end if
end function

function JSONvalue.getString() as string
    if m_type = jvalue_type.jstring then
        return m_string
    else
        return ""
    end if
end function

function JSONvalue.getNumber() as double
    if m_type = jvalue_type.number then
        return m_number
    else
        return 0
    end if
end function

function JSONvalue.getBool() as bool
    if m_type = jvalue_type.boolean then
        return m_bool
    else
        return bool.invalid
    end if
end function

destructor JSONvalue
    select case m_type
    case jvalue_type.jstring
        m_string = ""
    case jvalue_type.jobject
        delete cast(JSONobject ptr,m_child)
    case jvalue_type.array
        delete cast(JSONarray ptr,m_child)
    end select
end destructor

end namespace
