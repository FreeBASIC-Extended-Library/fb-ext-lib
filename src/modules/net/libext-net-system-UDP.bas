''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
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

    function UDP_client _
        ( _
        byref result as uinteger _
        ) as integer

        dim as long res = new_socket( AF_INET, SOCK_DGRAM, IPPROTO_IP )
        if( res = SOCKET_ERROR ) then
            return FAILED_INIT
        end if

        dim as socket_info cnx
        function = client_core( result, cnx, INADDR_ANY, 0, res, FALSE )

    end function

    function UDP_client _
        ( _
        byref result as uinteger, _
        byref info as socket_info, _
        byref server_ as string, _
        byval port_ as integer _
        ) as integer

        dim as integer ip = resolve( server_ )
        if( ip = NOT_AN_IP ) then
            return FAILED_RESOLVE
        end if

        function = UDP_client( result, info, ip, port_ )

    end function

    function UDP_client _
        ( _
        byref result as uinteger, _
        byref info as socket_info, _
        byref ip as integer, _
        byval port_ as integer _
        ) as integer

        dim as long res = new_socket( AF_INET, SOCK_DGRAM, IPPROTO_IP )
        if( res = SOCKET_ERROR ) then
            return FAILED_INIT
        end if

        function = client_core( result, info, ip, port_, res, TRUE )

    end function

    function UDP_server _
        ( _
        byref result as uinteger, _
        byref info as socket_info, _
        byval port as integer, _
        byval ip as integer _
        ) as integer

        dim as long res = new_socket( AF_INET, SOCK_DGRAM, IPPROTO_IP )
        if( res = SOCKET_ERROR ) then
            return FAILED_INIT
        end if

        function = server_core( result, info, port, ip, res )

    end function

end namespace
