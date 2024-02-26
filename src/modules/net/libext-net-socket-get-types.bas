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

#macro fbext_SocketGet_Define(linkage, t)
function socket.get _
    ( _
    byref data_ as fbext_TypeName(t), _
    byref elems as integer, _
    byval time_out as integer, _
    byval peek_only as integer _
    ) as integer

    var current = cast(ubyte ptr, @data_)
    dim as double then_, now_ = timer

    then_ = time_out/1000

    dim as integer chunk_ = elems*len(fbext_TypeName(t)), piece
    if( chunk_ ) then
        do
            dim as integer available_data = length( )
            if( chunk_ <= available_data ) then
                piece = chunk_
            else
                piece = available_data
            end if
            if( piece > 0 ) then
                assert(current < @data_ + elems)
                var gotten = this.getdata( current, piece, peek_only )
                if( gotten > 0 ) then
                    current += gotten
                    chunk_  -= gotten
                    if( chunk_ = 0 ) then
                        function = len(fbext_TypeName(t)) * elems
                        exit do
                    end if
                end if
            end if

            if( time_out = ONLY_ONCE ) then
                exit do
            end if
            if( then_ ) then
                if( abs(timer-now_) >= then_ ) then
                    exit do
                end if
            end if
            if( isclosed( ) ) then
                if( length( ) = 0 ) then
                    exit do
                end if
            end if

            sleep 1, 1
        loop
    end if

    elems = ((elems*len(fbext_TypeName(t)))-chunk_)/len(fbext_TypeName(t))

end function
#endmacro

namespace ext.net

    fbext_InstanciateMulti(fbext_SocketGet, fbext_NumericTypes())

    function socket.get _
        ( _
        byref data_ as string, _
        byref elems as integer, _
        byval time_out as integer, _
        byval peek_only as integer _
        ) as integer

        dim as double delay, t
        dim as integer hdr, no_block = (time_out = ONLY_ONCE), ok_time = (time_out > 0)
        dim as string ptr current = cast(string ptr, @data_)

        for i as integer = 0 to elems-1
            delay = time_out/1000

            t = timer
            if( this.get( hdr, 1, iif(no_block, ONLY_ONCE, iif(ok_time, cint(delay * 1000), 0)), peek_only ) = FALSE ) then
                exit function
            end if

            delay -= timer-t
            if( (delay < 0) and ok_time ) then
                exit function
            end if

            if( hdr = 0 ) then
                continue for
            end if

            *current = space(hdr)
            t = timer
            if( this.get( (*current)[0], hdr, block, peek_only ) = FALSE ) then
                exit function
            end if

            delay -= timer-t
            if( (delay < 0) and ok_time ) then
                exit function
            end if

            current += 1
        next

        function = TRUE
    end function

end namespace
