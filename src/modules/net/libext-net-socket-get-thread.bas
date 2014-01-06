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

    sub socket.recv_proc( byval opaque as any ptr )
        dim as socket ptr this = opaque

        dim as integer res, size
        dim as bool standby
        dim as ubyte ptr buffer_in = allocate( THREAD_BUFF_SIZE )

        do while( this->p_dead = FALSE )

            if( this->p_socket = SOCKET_ERROR ) then
                sleep 100, 1
                continue do
            end if

            scope
            dim as socket_lock lock_ = this->p_recv_lock

            '' reset caret?
            if ( this->p_recv_size > 0 ) and ( this->p_recv_size = this->p_recv_caret ) then
                this->p_recv_size = 0
                this->p_recv_caret = 0
            end if

            size = this->p_recv_buff_size - this->p_recv_size
            if size > THREAD_BUFF_SIZE then size = THREAD_BUFF_SIZE

            '' maxed out?
            if ( this->p_recv_size = this->p_recv_buff_size ) or ( size <= 0 ) then

                '' compact the buffer
                if( this->p_recv_caret >= cint( RECV_BUFF_SIZE * 0.75 ) ) then

                    size = this->p_recv_size - this->p_recv_caret
                    memmove( this->p_recv_data, @this->p_recv_data[this->p_recv_caret], size )
                    this->p_recv_caret = 0
                    this->p_recv_size = size
                    continue do

                endif

                mutexunlock( this->p_recv_lock )
                sleep 1, 1
                mutexlock( this->p_recv_lock )
                continue do

            endif

            end scope

            standby = FALSE

            '' select read method
            select case as const this->p_kind
                case SOCK_TCP, SOCK_UDP

                    res = recv( this->p_socket, cast(any ptr, buffer_in), size, 0 )

                case SOCK_UDP_CONNECTIONLESS

                    var l = len(this->p_recv_info)
                    res = recvfrom( this->p_socket, cast(any ptr, buffer_in), size, 0, cast(sockaddr ptr, @this->p_recv_info), @l )

            end select

            '' close if necessary
            dim as bool do_close = FALSE
            select case as const this->p_kind
                case SOCK_TCP
                    do_close = (res <= 0)
            end select

            if( do_close ) then
                this->close( )
            end if

            '' work to do?
            if( res <= 0 ) then
                standby = TRUE
            end if

            if( standby = FALSE ) then

                dim as socket_lock lock_ = this->p_recv_lock

                ''' need more room?
                'if( res > this->p_recv_buff_size - this->p_recv_size ) then
                '
                '   while res > (this->p_recv_buff_size - this->p_recv_size)
                '      this->p_recv_buff_size += RECV_BUFF_SIZE
                '   wend
                '
                '   this->p_recv_data = reallocate( this->p_recv_data, this->p_recv_buff_size )
                '
                'end if

                '' write
                memcpy( @this->p_recv_data[this->p_recv_size], buffer_in, res )
                this->p_recv_size += res

            else 'standby = TRUE

                sleep this->p_recv_sleep, 1

            end if

        loop

        Deallocate( buffer_in )

    end sub

end namespace
