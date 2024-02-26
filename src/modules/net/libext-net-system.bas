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

#ifdef __fb_win32__
dim shared as WSAData w
if( WSAStartup( (1 shl 8) or 1, @w ) <> 0 ) then
end if
#endif

namespace ext.net

operator socket_info.cast( ) as string
operator = "{address: " & *inet_ntoa( data.sin_addr ) & ", port: " & ntohs( data.sin_port ) & "}"
end operator

operator socket_info.cast( ) as sockaddr ptr
operator = cast(sockaddr ptr, @data)
end operator

function base_HTTP_path( byref thing as string ) as string
    var res = instr( thing, "/" )
    if( res = 0 ) then
        function = thing
    else
        print left( thing, res - 1 )
        function = left( thing, res - 1 )
    end if
end function

function translate_error _
    ( _
    byval err_code as SOCKET_ERRORS _
    ) as string

    select case as const err_code
        case SOCKET_OK
            return "No error"
        case FAILED_INIT
            return "Failed initialization"
        case FAILED_RESOLVE
            return "Failed to resolve host"
        case FAILED_CONNECT
            return "Failed connection"
        case FAILED_REUSE
            return "Failed to reuse socket"
        case FAILED_BIND
            return "Failed to bind socket"
        case FAILED_LISTEN
            return "Failed listening"
    end select
end function

function resolve _
    ( _
    byref host as string _
    ) as UInteger

    dim as string host_temp = host
    dim as uinteger ip = inet_addr( host_temp )
    if( ip = NOT_AN_IP ) then
        host_temp = base_HTTP_path( ltrim( host_temp, "http://" ) )

        #Ifdef __FB_WIN32__
        'gethostbyname( ) method

        dim as hostent ptr info = gethostbyname( host_temp )
        if( info = NULL ) then
            return NOT_AN_IP
        end if
        function = *cast( uinteger ptr, info->h_addr )

        #Else
        'getaddrinfo( ) method

        Dim As addrinfo hints
        Dim As addrinfo Ptr servinfo
        Dim As sockaddr_in Ptr addr

        'hints.ai_flags = AI_NUMERICHOST
        hints.ai_family = PF_INET
        hints.ai_socktype = SOCK_STREAM

        If( getaddrinfo( host_temp, NULL, @hints, @servinfo ) <> 0 ) Then
            Return NOT_AN_IP
        End If

        While servinfo->ai_family <> AF_INET
            servinfo = servinfo->ai_next
        Wend

        addr = cast( sockaddr_in Ptr, servinfo->ai_addr )

        function = *cptr( UInteger Ptr, @( addr->sin_addr ) )
        freeaddrinfo( servinfo )

        #EndIf

    else
        function = ip
    end if

end function

function client_core _
( _
byref result as uinteger, _
byref info as socket_info, _
byval ip as integer, _
byval port as integer, _
byval from_socket as uinteger, _
byval do_connect as integer = TRUE _
) as integer

dim as integer reuse = 1

if( setsockopt( from_socket, _
SOL_SOCKET, _
SO_REUSEADDR, _
cast(any ptr, @reuse), _
len(integer) ) = SOCKET_ERROR ) then
return FAILED_REUSE
end if

if( do_connect = TRUE ) then
    info = type( AF_INET, htons( port ), ip )

    var res = connect( from_socket, cast(sockaddr ptr, @info), len(info) )
    if( res = SOCKET_ERROR ) then
        return FAILED_CONNECT
    end if
end if

result = from_socket

end function

function server_core _
( _
byref result as uinteger, _
byref info as socket_info, _
byval port as integer, _
byval ip as integer, _
byval from_socket as uinteger _
) as integer

#if 0
'don't want to reuse..
dim as integer reuse = C_TRUE
if( setsockopt( from_socket, _
SOL_SOCKET, _
SO_REUSEADDR, _
cast(any ptr, @reuse), _
len(integer) ) = SOCKET_ERROR ) then
return FAILED_REUSE
end if
#endif

info = type( AF_INET, htons( port ), ip )
if bind( from_socket, _
cast(sockaddr ptr, @info), _
len(info) ) = SOCKET_ERROR then
return FAILED_BIND
end if

result = from_socket

end function

function close _
    ( _
    byval sock_ as uinteger _
    ) as integer
    dim as integer res=any
    #ifdef __FB_Win32__
    res = closesocket( sock_ )
    #else
    res = shutdown( sock_, SHUT_RDWR )
    #endif
    function = res
end function

function is_readable _
    ( _
    byval sock_ as uinteger _
    ) as integer

    if( sock_ = SOCKET_ERROR ) then
        exit function
    end if

    dim as fd_set set
    fd_zero( @set )
    fd_set_( sock_, @set )

    dim as ulongint timeout = 1
    select_( sock_+1, @set, NULL, NULL, cast(timeval ptr, @timeout) )

    return (FD_ISSET( sock_, @set ) <> 0)

end function

function new_sockaddr overload( byval serv as integer, byval port as short ) as socket_info ptr
    function = new socket_info( AF_INET, htons( port ), serv )
end function

function new_sockaddr( byref serv as string, byval port as short ) as socket_info ptr
    var ip = resolve( serv )
    if( ip = NOT_AN_IP ) then
        exit function
    end if

    function = new_sockaddr( ip, port )
end function

end namespace
