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

operator JSONobject.cast() as string
    if m_children = 0 then return "{}"

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

function JSONobject.loadString( byref jstr as const string ) as JSONobject ptr
    return 0
end function

function JSONobject.child( byref c as const string ) as JSONvalue ptr
    dim as JSONpair ptr ret = null
    for n as uinteger = 0 to m_children -1
        ret = m_child[n]
        if ret->key = c then exit for
    next
    return ret->value
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
