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

#include once "ext/net/udp.bi"

namespace ext.net

constructor udpSocket()
    m_sock = new socket()
end constructor

destructor udpSocket()
    if m_sock <> null then delete m_sock
end destructor

operator udpSocket.cast() as socket ptr
    return m_sock
end operator

function udpSocket.close() as socket_errors
    return cast(socket_errors,m_sock->close())
end function

function udpSocket.isClosed() as bool
    return m_sock->isClosed()
end function

function udpSocket.length() as SizeType
    return m_sock->length()
end function

function udpSocket.dumpData( byval x as integer ) as bool
    return cast(bool,m_sock->dumpData(x))
end function

function udpSocket.listenToNew _
        ( _
        byref listener as udpsocket, _
        byval timeout as double = 0 _
        ) as bool

    return cast(bool,m_sock->listentonew(*listener.m_sock,timeout))
end function

function udpSocket.server _
        ( _
        byval port as integer, _
        byval ip as integer _
        ) as socket_errors

    return cast(socket_errors,m_sock->udpserver(port,ip))
end function

function udpsocket.client _
        ( _
        byref serve as string, _
        byval port as integer _
        ) as socket_errors

    return cast(socket_errors,m_sock->udpclient(serve,port))
end function

function udpSocket.client _
        ( _
        byval ip as integer, _
        byval port as integer _
        ) as socket_errors

    return cast(socket_errors,m_sock->udpclient(ip,port))
end function

end namespace
