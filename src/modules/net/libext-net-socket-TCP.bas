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

#include once "ext/net/socket.bi"
#include once "libext-net-system.bi"

namespace ext.net

    function socket.client _
        ( _
        byval ip as integer, _
        byval port as integer _
        ) as integer

        dim as integer sock_back, result = TCP_client( sock_back, cnx_info, ip, port )
        if( result = SOCKET_OK ) then
            p_kind = SOCK_TCP
            swap p_socket, sock_back
        end if
        function = result

    end function

    function socket.client _
        ( _
        byref server_ as string, _
        byval port as integer _
        ) as integer

        dim as integer sock_back, result = TCP_client( sock_back, cnx_info, server_, port )
        if( result = SOCKET_OK ) then
            p_kind = SOCK_TCP
            swap p_socket, sock_back
        end if
        function = result

    end function

    function socket.server _
        ( _
        byval port as integer, _
        byval max_queue as integer = 4 _
        ) as integer

        dim as integer sock_back, result = TCP_server( sock_back, cnx_info, port, max_queue )
        if( result = SOCKET_OK ) then
            p_kind = SOCK_TCP
            swap p_listener, sock_back
        end if
        function = result

    end function

    function socket.listen _
        ( _
        byref timeout as double _
        ) as bool
        function = TCP_server_accept( p_socket, timeout, cast(sockaddr_in ptr, @cnx_info), p_listener )
    end function

    function socket.listentonew _
        ( _
        byref listener as socket, _
        byval timeout as double _
        ) as bool
        function = TCP_server_accept( p_socket, timeout, cast(sockaddr_in ptr, @cnx_info), listener.p_listener )
    end function

end namespace
