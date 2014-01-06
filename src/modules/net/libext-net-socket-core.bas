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

    constructor socket( )

    p_recv_lock   = mutexcreate( )
    p_send_lock   = mutexcreate( )
    p_go_lock     = mutexcreate( )
    p_hold_lock   = mutexcreate( )

    p_go_signal   = condcreate( )
    p_hold_signal = condcreate( )

    p_socket   = SOCKET_ERROR
    p_listener = SOCKET_ERROR

    p_recv_thread = threadcreate( @recv_proc, @this, 10140 )
    p_send_thread = threadcreate( @send_proc, @this, 10140 )

    p_recv_data = allocate( RECV_BUFF_SIZE )
    p_send_data = allocate( SEND_BUFF_SIZE )

    end constructor

    destructor socket( )

    hold = FALSE

    mutexlock( p_send_lock )
    mutexlock( p_recv_lock )

    p_send_size = 0
    p_send_caret = 0

    this.close( )

    p_dead = TRUE

    mutexunlock( p_send_lock )
    mutexunlock( p_recv_lock )

    threadwait( p_recv_thread )
    threadwait( p_send_thread )

    conddestroy( p_go_signal )
    conddestroy( p_hold_signal )

    mutexdestroy( p_recv_lock )
    mutexdestroy( p_send_lock )
    mutexdestroy( p_go_lock )
    mutexdestroy( p_hold_lock )

    deallocate( p_recv_data )
    deallocate( p_send_data )

    end destructor

    '' ghetto-sync
    property socket.hold( byval state as bool )

    select case state
        case TRUE

            mutexlock( p_hold_lock )

            p_hold = TRUE

            condwait( p_hold_signal, p_hold_lock )

            mutexunlock( p_hold_lock )

            mutexlock( p_go_lock )
            mutexunlock( p_go_lock )

        case FALSE

            p_hold = FALSE

            condsignal( p_go_signal )

    end select

    end property

    function socket.length () as sizetype

        function = p_recv_size-p_recv_caret

    end Function

    function socket.close _
        ( _
        ) as SOCKET_ERRORS

        if( ( p_socket = SOCKET_ERROR ) and ( p_listener = SOCKET_ERROR ) ) then exit function

        do while (p_send_size or p_send_caret)
            sleep 26, 1
        loop

        dim as socket_lock r_lock = p_recv_lock, s_lock = p_send_lock
        dim as integer s=any
        var res=SOCKET_OK

        if( p_socket <> SOCKET_ERROR ) then
            s = SOCKET_ERROR
            swap p_socket, s
            res = ext.net.close( s )
        end if

        if( res = SOCKET_OK ) then
            if( p_listener <> SOCKET_ERROR ) then
                s = SOCKET_ERROR
                swap p_listener, s
                res = ext.net.close( s )
            end if
        end if

        function = res

    end function

    function socket.isClosed _
        ( _
        ) as bool

        if ((p_socket = SOCKET_ERROR) andalso (p_listener = SOCKET_ERROR)) = true then
            return true
        else
            return false
        end if

    end function

    property socket.recvlimit _
    ( _
    byref limit as integer _
    )

    mutexlock( p_recv_lock )
    p_recv_limit = limit
    mutexunlock( p_recv_lock )

    end property

    property socket.sendlimit _
    ( _
    byref limit as integer _
    )

    mutexlock( p_send_lock )
    p_send_limit = limit
    mutexunlock( p_send_lock )

    end property

    property socket.recvlimit _
    ( _
    ) as integer

    mutexlock( p_recv_lock )
    property = p_recv_limit
    mutexlock( p_recv_lock )

    end property

    property socket.sendlimit _
    ( _
    ) as integer

    mutexlock( p_send_lock )
    property = p_send_limit
    mutexunlock( p_send_lock )

    end property

    function socket.sendrate _
        ( _
        ) as integer

        mutexlock( p_send_lock )
        function = p_send_rate
        mutexunlock( p_send_lock )

    end function

    function socket.recvrate _
        ( _
        ) as integer

        mutexlock( p_recv_lock )
        function = p_recv_rate
        mutexunlock( p_recv_lock )

    end function

    function socket.connectioninfo _
        ( _
        ) as socket_info ptr

        function = @cnx_info

    end function

end namespace
