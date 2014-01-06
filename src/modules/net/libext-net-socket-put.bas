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

function socket.putdata _
    ( _
    byval data_ as any ptr, _
    byval size as sizetype _
    ) as integer

    if( size <= 0 ) then
        exit function
    end if

    dim as socket_lock lock_ = p_send_lock

    '' need more space?
    dim as integer max_size = p_send_buff_size-p_send_size
    if( size > max_size ) then

        while size > max_size
            p_send_buff_size += SEND_BUFF_SIZE
            max_size += SEND_BUFF_SIZE
        wend

        p_send_data = reallocate( p_send_data, p_send_buff_size )

    end if

    '' add data to buffer
    memcpy( @p_send_data[p_send_size], data_, size )
    p_send_size += size

    function = size

end function

function socket.putline _
    ( _
    byref text as string _
    ) as integer

    dim as integer lt = cast(integer ptr, @text)[1]
    if( lt ) then
        putdata( strptr(text), lt )
    end if
    putdata( strptr(CR_LF), 2 )

    function = TRUE

end function

function socket.putstring _
    ( _
    byref text as string _
    ) as integer

    if( quick_len(text) = 0 ) then
        return TRUE
    end if

    put( text[0], quick_len(text) )

    function = TRUE

end function

function socket.puthttprequest _
( _
byref server_name as string, _
byref method as string, _
byref post_data as string _
) as integer

/' does an HTTP request as specified '/

/' Not a get or put request? '/
if ucase( method ) <> "GET" then
    if ucase( method ) <> "POST" then
        return FALSE
    end if
end if

dim as string temp_server = server_name, URI = "/"



        if left(temp_server,7) = "http://" then
            temp_server = right(temp_server,len(temp_server)-7)
        end if

        /' get first slash, everything past that is a path '/
        dim as integer first_slash = instr( temp_server, "/" )

        /' there's a path. '/
        if first_slash > 0 then

            /' take everything past first slash '/
            URI += mid( temp_server, first_slash + 1 )

            /' cut off path from server name '/
            temp_server = left( temp_server, first_slash - 1 )

        end if

        dim as string HTTPRequest
        HTTPRequest += method + " " + URI + " HTTP/1.0"                             + CR_LF + _
                       "Host: " + base_HTTP_path( temp_server ) + CR_LF + _
                       "User-Agent: libext-net/0.3.1. (+http://ext.freebasic.net)"  + CR_LF + _
                       "Connection: Close"                                          + CR_LF + _
                       "Accept-Charset: ISO-8859-1,UTF-8;q=0.7,*;q=0.7"             + CR_LF

        /' POST? Parse variables? '/
        if( method = "POST" ) then

            HTTPRequest += "Content-Type: application/x-www-form-urlencoded" + CR_LF

            dim as integer iLoc = ANY
            dim as string buffString

            do

                /' parse URI variables '/
                iLoc = instr( post_data, "&" )

                /' is there another variable? '/
                if iLoc > 0 then
                    buffString += left( post_data, iLoc - 1 ) + "&"
                    post_data = mid( post_data, iLoc + 1, len( post_data ) )
                else
                    exit do
                end if

            loop

            /' Add the last variable '/
            buffString += post_data

            /' Tell the server how much we'll send it. '/
            HTTPRequest += "Content-Length: " & len( buffString ) & CR_LF
            HTTPRequest += CR_LF

            /' Add the POST variables to the request '/
            HTTPRequest += buffString

        end if

        /' Add a final CRLF '/
        HTTPRequest += CR_LF

        /' Send our request '/
        put( HTTPRequest[0], len(HTTPRequest) )

        return TRUE

    end function

    function socket.putIRCauth _
        ( _
            byref nick as string, _
            byref realname as string, _
            byref pass as string _
        ) as integer

        /' Password given? '/
        if pass <> "" then
            putline( "PASS " & pass )
        end if

        putline( "USER " & realname & " * * *" )
        putline( "NICK " & nick )

        function = TRUE

    end function

end namespace
