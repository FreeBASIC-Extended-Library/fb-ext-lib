''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

    function TCP_client _
        ( _
        byref result as uinteger, _
        byref info as socket_info, _
        byref server_ as string, _
        byval port as integer _
        ) as integer

        dim as uinteger ip = resolve( server_ )
        if( ip = NOT_AN_IP ) then
            return FAILED_RESOLVE
        end if

        function = TCP_client( result, info, ip, port )

    end function

    function TCP_client _
        ( _
        byref result as uinteger, _
        byref info as socket_info, _
        byval ip as integer, _
        byval port as integer _
        ) as integer

        dim as uInteger new_sock = new_socket( AF_INET, SOCK_STREAM, IPPROTO_IP )
        if new_sock = SOCKET_ERROR then
            return FAILED_INIT
        end if

        function = client_core( result, info, ip, port, new_sock )

    end function

    function TCP_server _
        ( _
        byref result as uinteger, _
        byref info as socket_info, _
        byval port as integer, _
        byval max_queue as integer _
        ) as integer

        dim as uinteger res = new_socket( AF_INET, SOCK_STREAM, IPPROTO_IP ), func_res
        if( res = SOCKET_ERROR ) then
            return FAILED_INIT
        end if

        func_res = server_core( result, info, port, , res )
        if( func_res <> SOCKET_OK ) then
            return func_res
        end if

        if listen( result, max_queue ) = SOCKET_ERROR then
            result = SOCKET_ERROR
            return FAILED_LISTEN
        end if

    end function

    function TCP_accept _
        ( _
        byref result as uinteger, _
        byref client_info as sockaddr_in ptr, _
        byval listener as uinteger _
        ) as bool

        dim as integer size = len(sockaddr_in)
        dim as sockaddr_in discard

        result = accept( listener, _
        cast(any ptr, iif( client_info, client_info, @discard )), _
        varptr(size) )

        if( result = SOCKET_ERROR ) then
            exit function
        end if

        function = true

    end function

    function TCP_server_accept _
        ( _
        byref result as uinteger, _
        byref then_ as double, _
        byref client_info as sockaddr_in ptr, _
        byval listener as uinteger _
        ) as bool

        dim as uinteger _socket
        dim as double now_ = timer
        dim as bool func_res

        if( listener ) then
            if( then_ = 0 ) then
                func_res = TCP_accept( _socket, client_info, listener )
            else
                do
                    if( is_readable( listener ) ) then
                        func_res = TCP_accept( _socket, client_info, listener )
                        exit do
                    end if

                    if( abs(timer-now_) >= then_ ) then
                        exit do
                    end if

                    sleep 1, 1
                loop
            end if
        end if

        if( func_res = true ) then
            swap _socket, result
            function = true
        end if

    end function

end namespace
