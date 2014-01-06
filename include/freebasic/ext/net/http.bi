''Title: net/http.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2012, Ruben Rodriguez (cha0s) therealcha0s.net
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_NET_HTTP_BI__
#define FBEXT_NET_HTTP_BI__

#include once "ext/net/tcp.bi"
#include once "ext/containers/hashtable.bi"

namespace ext.net

enum method explicit
    get
    put
    post
    head
    delete_
end enum

enum HTTP_STATUS
    NONE = 0
    CONT = 100
    SWITCHING_PROTOCOLS = 101
    OK = 200
    CREATED = 201
    ACCEPTED = 202
    NONAUTH_INFO = 203
    NO_CONTENT = 204
    RESET_CONTENT = 205
    PARTIAL_CONTENT = 206
    MULT_CHOICES = 300
    MOVED_PERM = 301
    MOVED_TEMP = 302
    SEE_OTHER = 303
    NOT_MODIFIED = 304
    USE_PROXY = 305
    TEMP_REDIR = 307
    BAD_REQUEST = 400
    UNAUTHORIZED = 401
    FORBIDDEN = 403
    NOT_FOUND = 404
    METHOD_NOT_ALLOWED = 405
    NOT_ACCEPTABLE = 406
    PROXY_AUTH_REQ = 407
    REQUEST_TIMEOUT = 408
    CONFLICT = 409
    GONE = 410
    LEN_REQ = 411
    PRECON_FAILED = 412
    REQ_ENTITY_TOO_LARGE = 413
    REQ_URI_TOO_LONG = 414
    UNSUP_MEDIA_TYPE = 415
    REQ_RANGE_NOT_SATISFIABLE = 416
    EXPECTATION_FAILED = 417
    INT_SERVER_ERR = 500
    NOT_IMPLEMENTED = 501
    BAD_GATEWAY = 502
    SERVICE_UNAVAILABLE = 503
    GATEWAY_TIMEOUT = 504
    HTTP_VERSION_NOT_SUPPORTED = 505
end enum

''Function: readHTTPheaders
''Reads from the socket processing it as the beginning of an HTTP stream.
''
''Parameters:
''s - open TCPsocket that the headers will be read from.
''retcode - the <HTTP_STATUS> of the request.
''
''Returns:
''HashTable of headers. In the case of multiple headers with the same
''name, they will be in a `(tilde) seperated list.
''
declare function readHTTPheaders( byref s as TCPsocket, byref retcode as HTTP_STATUS = HTTP_STATUS.NONE ) as fbext_HashTable((string)) ptr

''Sub: sendHTTPheaders
''Sends the passed headers to the passed socket.
''
''Parameters:
''s - open TCPsocket the headers will be sent to.
''m - the <method> to use, default is GET, not relevant for servers.
''version - specify the HTTP protocol version to say is supported. Acceptable values: 1 for http1.0, 11 for http1.1, default is 11.
''uri - the URL to do method on, default is blank, not typically relevant for servers.
''st - the <HTTP_STATUS> code to send, default is none, only relevant for servers.
''h - HashTable(string) containing the headers to send. Multiple headers with the same name may be sent by placing them in a `(tilde) seperated list.
''
declare sub sendHTTPheaders( byref s as TCPsocket, byref m as method = method.get, byval version as integer = 11, _
                            byref uri as string = "", byval st as HTTP_STATUS = HTTP_STATUS.NONE, _
                            byref h as fbext_HashTable((string)) )

''Function: getRemoteFiletoMemory
''Attempts to load the specified url into memory.
''
''Parameters:
''url - the full url of the file to retrieve, only supports HTTP not HTTPS
''ret_len - will hold the size of the file after retrieval
''st - return parameter that will hold the <HTTP_STATUS> of the request.
''
''Returns:
''Ubyte pointer to the file or null on error.
''This pointer should be deallocated using delete[].
''For convienience the memory is allocated ret_len +1 and the final byte is set to null so it may be cast to a zstring ptr if appropriate.
declare function getRemoteFiletoMemory( byref url as string, byref ret_len as SizeType, byref st as HTTP_STATUS = HTTP_STATUS.NONE ) as ubyte ptr

''Function: getRemoteFileToDisk
''Attempts to download the specified url to a file.
''
''Parameters:
''url - the full url of the file to retrieve, only supports HTTP not HTTPS
''filetosave - the name of the file to save under.
''
''Returns:
''<HTTP_STATUS>
''
declare function getRemoteFileToDisk( byref url as string, byref filetosave as string ) as HTTP_STATUS

end namespace

#endif 'FBEXT_NET_HTTP_BI__
