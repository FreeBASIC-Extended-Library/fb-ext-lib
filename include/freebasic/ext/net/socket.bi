''Title: net/socket.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2012, Ruben Rodriguez (cha0s) therealcha0s.net
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#include once "crt.bi"
#include once "ext/detail/common.bi"
#include once "ext/net/detail/common.bi"
'#include once "ext/error.bi"

#ifndef FBEXT_NET_SOCKET_BI__
#define FBEXT_NET_SOCKET_BI__ -1

#ifdef socket
#undef socket
#endif

''namespace: ext.net
namespace ext.net

    ''Type: socket_info
    ''Holds advanced information about a socket
    type socket_info

        data as sockaddr_in
        declare property port( ) as ushort

        declare operator cast( ) as string
        declare operator cast( ) as sockaddr ptr

    end type

    ''Type: socket
    ''Wrapper around system specific low level socket calls.
    type socket
        public:

        declare constructor( )
        declare destructor( )

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
        ) as integer

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
        ) as integer

        ''Function: UDPClient
        ''Create a UDP client with the 32-bit IP address "ip" on port "port".
        ''
        ''Returns:
        ''<SOCKET_ERRORS>
        ''
        declare function UDPClient _
        ( _
        byval ip as integer, _
        byval port as integer _
        ) as integer

        ''Function: UDPClient
        ''Create a UDP client with the hostname "server" on the port "port"
        ''
        ''Returns:
        ''<SOCKET_ERRORS>
        ''
        declare function UDPClient _
        ( _
        byref server as string, _
        byval port as integer _
        ) as integer

        declare function UDPClient _
        ( _
        ) as integer

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
        ) as integer

        ''Function: UDPServer
        ''Create a UDP server that listens on port "port"
        ''
        ''Returns:
        ''<SOCKET_ERRORS>
        ''
        declare function UDPServer _
        ( _
        byval port as integer, _
        byval ip as integer = INADDR_ANY _
        ) as integer

        declare function UDPConnectionlessServer _
        ( _
        byval port as integer _
        ) as integer

        ''Function: listen
        ''Listen on a server socket for incoming connections. If "timeout" is 0,
        ''then the socket blocks indefinitely until a connection is recieved.
        ''Otherwise, the socket blocks for "timeout" seconds. If "info" is NULL,
        ''the peer info is discarded, otherwise it is returned through info.
        ''The connection socket is the same as the listener.
        ''Better to use listen_to_new() most of the time.
        ''
        ''Returns:
        ''Returns TRUE if a connection was recieved, else FALSE.
        ''
        declare function listen _
        ( _
        byref timeout as double = 0 _
        ) as bool

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
        byref listener as socket, _
        byval timeout as double = 0 _
        ) as bool

        ''Function: getData
        ''Attempt to retrieve "size" bytes of data from the socket stream, filling
        ''"data_". If "peek_only" is FALSE (default), then the data is removed from
        ''the socket stream as well.
        ''Note: This function is considered low-level and isn't necessary to use.
        ''
        ''Returns:
        ''Number of bytes read from stream.
        ''
        declare function getData _
        ( _
        byval data_ as any ptr, _
        byval size as SizeType, _
        byval peek_only as bool = FALSE _
        ) as sizetype

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
        #macro fbext_SocketGet_Declare(T_)
        declare function get overload _
            ( _
                byref data_ as fbext_TypeName(T_), _
                byref elems as integer = 1, _
                byval time_out as integer = ONLY_ONCE, _
                byval peek_only as integer = FALSE _
            ) as integer
        #endmacro

        fbext_InstanciateMulti(fbext_SocketGet, fbext_BuiltinTypes())

        ''Function: putData
        ''Attempt to commit "size" bytes of data at "data_" to the socket stream.
        ''Note: This function is considered low-level and isn't necessary to use.
        ''
        ''Returns:
        ''Number of bytes placed into the stream.
        ''
        declare function putData _
        ( _
        byval data_ as any ptr, _
        byval size as sizetype   _
        ) as integer

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
        #macro fbext_SocketPut_Declare(T_)
        declare function put overload _
            ( _
                byref data_ as fbext_TypeName(T_), _
                byref elems as integer = 1, _
                byval time_out as integer = 0 _
            ) as bool
        #endmacro

        fbext_InstanciateMulti(fbext_SocketPut, fbext_BuiltinTypes())

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
        ) as integer

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
        ) as integer

        declare function putHTTPRequest _
        ( _
        byref server_name as string, _
        byref method      as string = "GET", _
        byref post_data   as string = ""     _
        ) as integer

        declare function putIRCAuth _
        ( _
        byref nick as string = "undefined", _
        byref realname as string = "undefined", _
        byref pass as string = "" _
        ) as integer

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

        declare property recvLimit _
        ( _
        byref limit as integer _
        )

        declare property sendLimit _
        ( _
        byref limit as integer _
        )

        declare property recvLimit _
        ( _
        ) as integer

        declare property sendLimit _
        ( _
        ) as integer

        declare function recvRate _
        ( _
        ) as integer

        declare function sendRate _
        ( _
        ) as integer

        declare function setDestination _
        ( _
        byval info as socket_info ptr = NULL _
        ) as integer

        declare function connectionInfo _
        ( _
        ) as socket_info ptr

        declare property hold _
        ( _
        byval as bool _
        )

        private:

        const as integer THREAD_BUFF_SIZE = 1024 * 16
        const as integer RECV_BUFF_SIZE = 1024 * 64
        const as integer SEND_BUFF_SIZE = 1024 * 16

        const as integer BUFF_RATE = 10

        enum KINDS
            SOCK_TCP
            SOCK_UDP
            SOCK_UDP_CONNECTIONLESS
        end enum

        declare static sub recv_proc _
        ( _
        byval opaque as any ptr _
        )

        declare static sub send_proc _
        (  _
        byval opaque as any ptr _
        )

        as bool p_hold
        as any ptr p_hold_lock, p_hold_signal
        as any ptr p_go_lock, p_go_signal

        p_send_buff_size  as integer = SEND_BUFF_SIZE
        p_send_data       as ubyte ptr
        p_send_caret      as integer
        p_send_size       as integer
        p_send_thread     as any ptr
        p_send_lock       as any ptr
        p_send_limit      as integer
        p_send_accum      as integer
        p_send_timer      as double
        p_send_disp_timer as double
        p_send_rate       as integer
        p_send_info       as socket_info Ptr
        p_send_sleep      As UShort = 1

        p_recv_buff_size  as integer = RECV_BUFF_SIZE
        p_recv_data       as ubyte ptr
        p_recv_caret      as integer
        p_recv_size       as integer
        p_recv_thread     as any ptr
        p_recv_lock       as any ptr
        p_recv_limit      as integer
        p_recv_accum      as integer
        p_recv_timer      as double
        p_recv_disp_timer as double
        p_recv_rate       as integer
        p_recv_info       as socket_info
        p_recv_sleep      As UShort = 1

        as socket_info cnx_info

        as integer p_socket, p_listener
        p_dead as bool

        p_kind as KINDS

    end type

end namespace

#endif 'FBEXT_NET_SOCKET_BI__
