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

#macro fbext_SocketPut_Define(linkage, t)
function socket.put _
    ( _
    byref data_ as fbext_TypeName(t), _
    byref elems as integer, _
    byval time_out as integer _
    ) as bool

    if( isclosed( ) ) then
        return false
    end if

    dim as integer chunk_ = elems*len(fbext_TypeName(t)), piece
    piece = this.putdata( @data_, chunk_ )

    function = TRUE

end function
#endmacro

namespace ext.net

    fbext_InstanciateMulti(fbext_SocketPut, fbext_NumericTypes())

    function socket.put _
        ( _
        byref data_ as string, _
        byref elems as integer, _
        byval time_out as integer _
        ) as bool

        if( isclosed( ) ) then
            return false
        end if

        dim as double delay, t
        dim as integer hdr, no_block = (time_out = ONLY_ONCE), ok_time = (time_out > 0)
        dim as string ptr current = cast(string ptr, @data_)

        for i as integer = 0 to elems-1
            delay = time_out/1000

            t = timer
            this.put( len(*current), 1, iif(no_block, ONLY_ONCE, iif(ok_time, cint(delay * 1000), 0)) )
            delay -= timer-t
            if( (delay < 0) and ok_time ) then
                return false
            end if

            t = timer
            this.put( (*current)[0], len(*current), iif(no_block, ONLY_ONCE, iif(ok_time, cint(delay * 1000), 0)) )
            delay -= timer-t
            if( (delay < 0) and ok_time ) then
                return false
            end if

            current += 1
        next

        function = TRUE
    end function

end namespace
