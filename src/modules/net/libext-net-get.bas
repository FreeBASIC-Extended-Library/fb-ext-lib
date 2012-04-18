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

    function socket.getdata _
        ( _
        byval data_ as any ptr, _
        byval size as integer, _
        byval peek_only as integer _
        ) as integer

        if( size <= 0 ) then
            exit function
        end if

        dim as socket_lock lock_ = p_recv_lock

        '' handle speed limits
        if( p_recv_limit > 0 ) then

            if( abs(timer-p_recv_timer) >= (1 / BUFF_RATE) ) then
                p_recv_timer = timer

                p_recv_accum -= (p_recv_limit / BUFF_RATE)

                if( p_recv_accum < 0 ) then p_recv_accum = 0

            end if

            if( p_recv_accum + size > p_recv_limit ) then

                size = p_recv_limit - p_recv_accum

                if ( p_recv_accum = p_recv_limit ) or ( size <= 0 ) then
                    exit function
                EndIf

            end if

        end if

        '' update bytes/sec calc... reset counter
        if( abs(timer-p_recv_disp_timer) >= 1 ) then

            p_recv_rate = p_recv_accum
            p_recv_disp_timer = timer

            if( p_recv_limit = 0 ) then p_recv_accum = 0

        end if

        dim as integer available_data = length( )

        '' read data?
        if( size <= available_data ) then

            '' write to user pointer
            memcpy( data_, @p_recv_data[p_recv_caret], size )

            '' not peeking? update caret
            if( peek_only = FALSE ) then
                p_recv_caret += size
                p_recv_accum += size
            end if

            '' return bytes read
            function = size

        end if

    end function

    function socket.getuntil _
        ( _
        byref target as string _
        ) as string

        dim as integer ins, l, r_len, gotten
        var tl = quick_len(target)
        var start = 1
        var in_buffer = space(512)
        var res = space(512)
        quick_len( res ) = 0

        do

            l = length( )
            if( l ) then

                r_len = quick_len( res )
                if l > 512 then l = 512

                gotten = get( in_buffer[0], l, , TRUE )
                quick_len( in_buffer ) = gotten

                res += in_buffer

                if( gotten > 0 ) then

                    'ins = instr( /'iif( tl >= r_len, 1, r_len - tl-1 ),'/ res, target )
                    ins = instr( start, res, chr(target[ tl - 1 ] ))
                    start = quick_len( res ) + 1

                    if ( ins <> 0 ) and ( tl = 2 ) then

                        if ins = 1 then
                            ins = 0
                        elseif res[ ins - 2 ] = target[ 0 ] then
                            ins -= 1
                        else
                            ins = 0
                        EndIf

                    EndIf

                    if( ins ) then
                        quick_len( res ) = ins + tl - 1
                        gotten = ins + tl - 1 - r_len
                    end if

                    dumpdata( gotten )
                end if

                if( ins ) then exit do

            else

                sleep 1, 1

            end if

            if( isclosed( ) ) then
                if( length( ) = 0 ) then
                    exit do
                end if
            end if

        loop

        function = res

    end function

    function socket.getline _
        ( _
        ) as string

        var res = getuntil( chr(13, 10) )
        function = left(res, len(res)-2)

    end function

    function socket.dumpdata _
        ( _
        byval size as integer _
        ) as integer

        dim as socket_lock lock_ = p_recv_lock

        dim as integer available_data = length( )
        if( size <= available_data ) then
            p_recv_caret += size
            function = TRUE
        end if

    end function

end namespace
