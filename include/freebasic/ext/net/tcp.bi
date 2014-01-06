''Title: net/tcp.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2012, Ruben Rodriguez (cha0s) therealcha0s.net
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_NET_TCP_BI__
#define FBEXT_NET_TCP_BI__ -1

#include once "ext/net/socket.bi"

''Namespace: ext.net
namespace ext.net

''Class: TCPSocket
''Provides an abstraction around the native low level socket API for
''the Transmission Control Protocol. Allows creation of both server
''and client sockets.
''
type TCPSocket

        public:
        declare constructor( )
        declare destructor( )
        declare operator cast() as socket ptr

        ''Function: client
        ''Create a TCP client with the 32-bit IP address "ip" on port "port".
        ''
        ''Returns:
        ''<SOCKET_ERRORS>
        ''
        declare function client _
        ( _
        byval ip as integer, _
        byval port as integer _
        ) as socket_errors

        ''Function: client
        ''Create a TCP client with the hostname "server" on the port "port"
        ''
        ''Returns:
        ''<SOCKET_ERRORS>
        ''
        declare function client _
        ( _
        byref server as string, _
        byval port as integer _
        ) as socket_errors

        ''Function: server
        ''Create a TCP server that listens on port "port". It can queue up to "max_queue"
        ''incoming connections. When a socket connects, it is added to the queue. When
        ''listen() is used with the listening socket, it removes a socket from the queue
        ''if one exists. The default queue size is 4 pending connections.
        ''
        ''Returns:
        ''<SOCKET_ERRORS>
        ''
        declare function server _
        ( _
        byval port as integer, _
        byval max_queue as integer = 4 _
        ) as socket_errors

        ''Function: listenToNew
        ''Listen on the "listener" socket for incoming connections. If "timeout" is 0,
        ''then the socket blocks indefinitely until a connection is recieved.
        ''Otherwise, the socket blocks for "timeout" seconds. If "info" is NULL,
        ''the peer info is discarded, otherwise it is returned through info.
        ''The socket that calls listen_to_new() recieves the new connection.
        ''
        ''Returns:
        ''Returns TRUE if a connection was recieved, else FALSE.
        ''
        declare function listenToNew _
        ( _
        byref listener as TCPsocket, _
        byval timeout as double = 0 _
        ) as bool

        ''Function: getLine
        ''Get the next line from the input stream, seperated by CRLF (HTTP and other protocols).
        ''
        declare function getLine _
        ( _
        ) as string

        ''Function: getUntil
        ''Fills the return string until the specified string is found in the input.
        ''
        ''Parameters:
        ''target - when found in string the function will return everything up to that point.
        ''
        declare function getUntil _
        ( _
        byref target as string _
        ) as string

        ''Function: get
        ''
        ''Parameters:
        ''t - any built-in type.
        ''elems - specifies how many "t"s to retrieve (default 1).
        ''time_out - can be ext.net.socket.ONLY_ONCE (only tries retriving one time before giving up), ext.net.socket.BLOCK (blocks forever until enough data is there to retrieve) or, any other number specifies the number of milliseconds to try before giving up.
        ''peek_only - If false (default), the data is removed from the socket stream
        ''
        ''Returns:
        ''Upon return "elems" contains the amount of "t"s that were
        ''successfully recieved. Return value is the number of bytes returned in total.
        ''
        #macro fbext_TCPSocketGet_Declare(T_)
        declare function get overload _
            ( _
                byref data_ as fbext_TypeName(T_), _
                byref elems as integer = 1, _
                byval time_out as integer = ONLY_ONCE, _
                byval peek_only as integer = FALSE _
            ) as integer
        #endmacro

        fbext_InstanciateMulti(fbext_TCPSocketGet, fbext_BuiltinTypes())

        ''Function: put
        ''Overloaded for all built-in types.
        ''"elems" specifies how many "t"s to put in the stream. "time_out" can be
        ''"ext.net.socket.ONLY_ONCE" (only tries putting one time before giving up)
        ''"ext.net.socket.BLOCK" (blocks forever until enough data can be put)
        ''or, any other number specifies the number of milliseconds to try before
        ''giving up. Upon return "elems" contains the amount of "t"s that were
        ''successfully sent.
        ''
        ''Returns:
        ''True if succesful
        ''
        #macro fbext_TCPSocketPut_Declare(T_)
        declare function put overload _
            ( _
                byref data_ as fbext_TypeName(T_), _
                byref elems as integer = 1, _
                byval time_out as integer = 0 _
            ) as bool
        #endmacro

        fbext_InstanciateMulti(fbext_TCPSocketPut, fbext_BuiltinTypes())

        ''Function: putLine
        ''Similiar to the FreeBASIC print function, place a line in the output stream
        ''ending with the CRLF line ending. (Used by HTTP and other protocols.)
        ''
        ''Returns:
        ''True if successful.
        ''
        declare function putLine _
        ( _
        byref text as string _
        ) as bool

        ''Function: putString
        ''Similiar to the FreeBASIC print function with the ; line ending,
        ''place the string in the output stream without adding the line
        ''ending character sequence. Does not add leading length of string
        ''like the put(string) function does.
        ''
        ''Returns:
        ''True if successful.
        ''
        declare function putString _
        ( _
        byref text as string _
        ) as bool

        ''Function: dumpData
        ''Discard "size" bytes of data from the socket stream.
        ''
        ''Returns:
        ''Returns true on success.
        ''
        declare function dumpData _
        ( _
        byval size as integer _
        ) as bool

        ''Function: length
        ''Retrieve the length of waiting data in the receive buffer.
        ''
        declare function length _
        ( _
        ) as SizeType

        ''Function: isClosed
        ''Poll the socket to see if its connection is still alive.
        ''
        ''Returns:
        ''Boolean
        ''
        declare function isClosed _
        ( _
        ) as bool

        ''Function: close
        ''Close the specified socket, and shut it down.
        ''
        ''Returns:
        ''<SOCKET_ERRORS>
        ''
        declare function close _
        ( _
        ) as SOCKET_ERRORS

        private:
        m_sock as socket ptr

end type

end namespace

#endif 'FBEXT_NET_TCP_BI__
