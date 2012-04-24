''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2012, Ruben Rodriguez (cha0s) therealcha0s.net
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

#include once "ext/net/tcp.bi"

namespace ext.net

function TCPSocket.getLine() as string
    return m_sock->getLine()
end function

function TCPSocket.getUntil( byref target as string ) as string
    return m_sock->getUntil(target)
end function

function TCPSocket.putString( byref x as string ) as bool
    return cast(bool,m_sock->putString(x))
end function

function TCPSocket.putLine( byref x as string ) as bool
    return cast(bool,m_sock->putLine(x))
end function

#macro fbext_TCPSocketGet_Define(linkage, t)
:
function TCPsocket.get _
    ( _
    byref data_ as fbext_TypeName(t), _
    byref elems as integer, _
    byval time_out as integer, _
    byval peek_only as integer _
    ) as integer

    return m_sock->get(data_,elems,time_out,peek_only)
end function
:
#endmacro

#macro fbext_TCPSocketPut_Define(linkage, T_)
:
function TCPsocket.put _
            ( _
                byref data_ as fbext_TypeName(T_), _
                byref elems as integer, _
                byval time_out as integer _
            ) as bool

    return m_sock->put(data_,elems,time_out)
end function
:
#endmacro

fbext_InstanciateMulti(fbext_TCPSocketGet, fbext_BuiltinTypes())

fbext_InstanciateMulti(fbext_TCPSocketPut, fbext_BuiltinTypes())


end namespace
