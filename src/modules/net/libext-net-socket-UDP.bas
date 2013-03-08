''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
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

    function socket.UDPclient _
        ( _
        ) as integer

        dim as uinteger sock_back, result = UDP_client( sock_back )
        if( result <> 0 ) then
            return result
        end if

        p_kind = SOCK_UDP_CONNECTIONLESS
        swap p_socket, sock_back

    end function

    function socket.UDPclient _
        ( _
        byval ip as integer, _
        byval port as integer _
        ) as integer

        dim as uinteger sock_back, result = UDP_client( sock_back, cnx_info, ip, port )
        if( result <> 0 ) then
            return result
        end if

        p_kind = SOCK_UDP
        swap p_socket, sock_back

    end function

    function socket.UDPclient _
        ( _
        byref server_ as string, _
        byval port as integer _
        ) as integer

        dim as uinteger sock_back, result = UDP_client( sock_back, cnx_info, server_, port )
        if( result <> 0 ) then
            return result
        end if

        p_kind = SOCK_UDP
        swap p_socket, sock_back

    end function

    function socket.UDPserver _
        ( _
        byval port as integer, _
        byval ip as integer _
        ) as integer

        dim as uinteger sock_back, result = UDP_server( sock_back, cnx_info, port, ip )
        if( result <> 0 ) then
            return result
        end if

        p_kind = SOCK_UDP
        swap p_socket, sock_back

    end function

    function socket.UDPconnectionlessserver _
        ( _
        byval port as integer _
        ) as integer

        dim as socket_info info
        dim as uinteger sock_back, result = UDP_server( sock_back, info, port, INADDR_ANY )
        if( result <> 0 ) then
            return result
        end if

        p_kind = SOCK_UDP_CONNECTIONLESS
        swap p_socket, sock_back

    end function

    function socket.setdestination _
        ( _
        byval info as socket_info ptr _
        ) as integer

        if( p_kind <> SOCK_UDP_CONNECTIONLESS ) then
            exit function
        end if

        if( p_send_info ) then
            delete p_send_info
        end if

        p_send_info = new socket_info
        if( info ) then
            *p_send_info = *info
        else
            *p_send_info = p_recv_info
        end if

        function = TRUE

    end function

end namespace
