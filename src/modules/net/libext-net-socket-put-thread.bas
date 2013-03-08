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

    sub socket.send_proc( byval opaque as any ptr )
        dim as socket ptr this = opaque

        dim as integer res, standby, chunk_
        do while( this->p_dead = FALSE )

            If( this->p_hold = TRUE ) then

                mutexlock( this->p_hold_lock )
                mutexunlock( this->p_hold_lock )

                mutexlock( this->p_go_lock )

                condsignal( this->p_hold_signal )

                condwait( this->p_go_signal, this->p_go_lock )

                mutexunlock( this->p_go_lock )

            end if

            if( this->p_socket = SOCKET_ERROR ) Then
                sleep 100, 1
                continue Do
            EndIf

            standby = FALSE

            scope

            dim as socket_lock lock_ = this->p_send_lock

            '' handle speed limits
            if( this->p_send_limit > 0 ) then

                if( abs(timer - this->p_send_timer) >= (1 / BUFF_RATE) ) then
                    this->p_send_timer = timer

                    this->p_send_accum -= (this->p_send_limit / BUFF_RATE)

                    if( this->p_send_accum < 0 ) then
                        this->p_send_accum = 0
                    end if

                end if

                if( this->p_send_accum < this->p_send_limit ) then
                    chunk_ = this->p_send_limit - this->p_send_accum
                    if chunk_ > ( this->p_send_size - this->p_send_caret ) then
                        chunk_ = this->p_send_size - this->p_send_caret
                    EndIf
                else
                    chunk_ = 0
                end if

            else
                chunk_ = this->p_send_size-this->p_send_caret

            end if

            '' update bytes/sec calc... reset counter
            if( abs(timer - this->p_send_disp_timer) >= 1 ) then

                this->p_send_rate = this->p_send_accum
                this->p_send_disp_timer = timer

                if( this->p_send_limit = 0 ) then
                    this->p_send_accum = 0
                end if

            end if

            end scope

            if chunk_ > 2048 then chunk_ = 2048

            '' anything?
            if( chunk_ > 0 ) then

                '' send method
                select case as const this->p_kind
                    case SOCK_TCP, SOCK_UDP

                        res = send( this->p_socket, _
                        cast(any ptr, @this->p_send_data[this->p_send_caret]), _
                        chunk_, _
                        0 )

                    case SOCK_UDP_CONNECTIONLESS

                        '' send to destination (lock info...)
                        if( this->p_send_info ) then

                            var l = len(*(this->p_send_info))
                            res = sendto( this->p_socket, _
                            cast(any ptr, @this->p_send_data[this->p_send_caret]), _
                            chunk_, _
                            0, cast(sockaddr ptr, this->p_send_info), l )

                        end if

                end select

                dim as integer do_close = FALSE
                select case as const this->p_kind
                    case SOCK_TCP
                        do_close = (res <= 0)
                    case SOCK_UDP
                        do_close = (res = -1)
                end select

                if( do_close ) then

                    this->p_send_size = 0
                    this->p_send_caret = 0

                    this->close( )

                end if

            else

                res = 0

            end if

            if( res <= 0 ) then
                standby = TRUE
            end if

            if( standby = FALSE ) then

                dim as socket_lock lock_ = this->p_send_lock

                '' update
                this->p_send_caret += res
                this->p_send_accum += res

                '' caught up?
                if( this->p_send_caret = this->p_send_size ) then
                    this->p_send_size  = 0
                    this->p_send_caret = 0
                endif

            else '( standby = TRUE )

                Sleep this->p_send_sleep, 1

            endif

        loop

    end sub

end namespace
