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

#define fbext_NoBuiltinInstanciations() -1
#include once "ext/net/http.bi"

fbext_Instanciate(fbext_HashTable, ((string)))

namespace ext.net

private function StatusToString( byval s as HTTP_STATUS ) as string

    select case s
    case CONT
        return "100 Continue"
    case SWITCHING_PROTOCOLS
        return "101 Switching Protocols"
    case OK
        return "200 OK"
    case CREATED
        return "201 Created"
    case ACCEPTED
        return "202 Accepted"
    case NONAUTH_INFO
        return "203 Non-Authoritative Information"
    case NO_CONTENT
        return "204 No Content"
    case RESET_CONTENT
        return "205 Reset Content"
    case PARTIAL_CONENT
        return "206 Partial Content"
    case MULT_CHOICES
        return "300 Multiple Choices"
    case MOVED_PERM
        return "301 Moved Permanently"
    case MOVED_TEMP
        return "302 Found"
    case SEE_OTHER
        return "303 See Other"
    case NOT_MODIFIED
        return "304 Not Modified"
    case USE_PROXY
        return "305 Use Proxy"
    case TEMP_REDIR
        return "307 Temporary Redirect"
    case BAD_REQUEST
        return "400 Bad Request"
    case UNAUTHORIZED
        return "401 Unauthorized"
    case FORBIDDEN
        return "403 Forbidden"
    case NOT_FOUND
        return "404 Not Found"
    case METHOD_NOT_ALLOWED
        return "405 Method Not Allowed"
    case NOT_ACCEPTABLE
        return "406 Not Acceptable"
    case PROXY_AUTH_REQ
        return "407 Proxy Authentication Required"
    case REQ_TIMEOUT
        return "408 Request Timeout"
    case CONFLICT
        return "409 Conflict"
    case GONE
        return "410 Gone"
    case LEN_REQ
        return "411 Length Required"
    case PRECON_FAILED
        return "412 Precondition Failed"
    case REQ_ENTITY_TOO_LARGE
        return "413 Request Entity Too Large"
    case REQ_URI_TOO_LONG
        return "414 Request-URI Too Long"
    case UNSUPPORTED_MEDIA_TYPE
        return "415 Unsupported Media Type"
    case REQ_RANGE_NOT_SATISFIABLE
        return "416 Requested Range Not Satisfiable"
    case EXPECTATION_FAILED
        return "417 Expectation Failed"
    case INT_SERVER_ERROR
        return "500 Internal Server Error"
    case NOT_IMPLEMENTED
        return "501 Not Implemented"
    case BAD_GATEWAY
        return "502 Bad Gateway"
    case SERVICE_UNAVAILABLE
        return "503 Service Unavailable"
    case GATEWAY_TIMEOUT
        return "504 Gateway Timeout"
    case HTTP_VERSION_NOT_SUPPORTED
        return "505 HTTP Version Not Supported"
    case else
        return ""
    end select

end function

function readHTTPheaders( byref s as TCPsocket, byref retcode as HTTP_STATUS = HTTP_STATUS.NONE ) as fbext_HashTable(string)

    var ret = fbext_HashTable(string)
    if s.isClosed = true then return ret

    var resp = trim(s.getLine())
    var first_space = instr(resp," ")
    retcode = cast(HTTP_STATUS,valint(mid( resp, first_space + 1 )))

    while resp <> ""
        resp = trim(s.getLine())
        if resp <> "" then
            var colon = instr(resp,":")
            var hdr = left(resp,colon-1)
            var valu = trim(mid(resp,colon+1))
            if ret.Find(hdr) = null then 'not in table
                ret.Insert(hdr,valu)
            else 'in table
                var existing = ret.Find(hdr)
                var tlist = *existing & "`" & valu
                ret.Remove(hdr)
                ret.Insert(hrd,tlist)
            end if
        end if
    wend

    return ret

end function

dim shared m_hdr as string

private sub htIter( byref k as const string, byval v as string ptr )

    if k <> "" andalso *v <> "" then
        m_hdr = m_hdr & k & ": " & *v & CR_LF
    end if

end sub

sub sendHTTPheaders( byref s as TCPsocket, byref m as method = method.get, byval version as integer = 11, _
                            byref uri as string = "", byval st as HTTP_STATUS = HTTP_STATUS.NONE, _
                            byref h as fbext_HashTable(string) )

    var toSend = ""
    if uri = "" and st <> NONE then 'not sending to a specific location, like a server response
        if version = 1 then
            toSend &= "HTTP/1.0 "
        else
            toSend &= "HTTP/1.1 "
        end if
        toSend = toSend & StatusToString(st) & CR_LF

        if h.Find("Server") = null then
            'put us as the server since none was passed.
            h.Insert("Server","FBEXT::NET/" & FBEXT_VERSION)
        end if

    end if
    if uri <> "" then
        select case m
        case method.get
            toSend &= "GET "
        case method.put
            toSend &= "PUT "
        case method.head
            toSend &= "HEAD "
        case method.post
            toSend &= "POST "
        case method.delete
            toSend &= "DELETE "
        end select

        toSend &= uri & " "

        if version = 1 then
            toSend &= "HTTP/1.0"
        else
            toSend &= "HTTP/1.1"
        end if

        toSend &= CR_LF

        if h.Find("User-Agent") = null then 'no user agent passed, docs say one should be sent so here's the default
            h.Insert("User-Agent","FBEXT::NET/" & FBEXT_VERSION)
        end if

    end if

    h.ForEach( @htIter )

    toSend &= CR_LF & CR_LF

    s.putString( toSend )

end sub

function getFiletoMemory( byref s as TCPsocket, byref url as string, byref ret_len as SizeType, byref st as HTTP_STATUS = HTTP_STATUS.NONE ) as ubyte ptr

end function

function getFile( byref s as TCPsocket, byref url as string, byref filetosave as string ) as HTTP_STATUS

end function

end namespace
