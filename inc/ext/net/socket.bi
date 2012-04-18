''Title: net/ports.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2012, Ruben Rodriguez (cha0s) therealcha0s.net
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#include once "crt.bi"
#include once "ext/detail/common.bi"
#include once "ext/net/detail/common.bi"
#include once "ext/error.bi"

#ifndef FBEXT_NET_SOCKET_BI__
#define FBEXT_NET_SOCKET_BI__ -1

#ifdef socket
#undef socket
#endif

namespace ext.net

    enum SOCKET_ERRORS
        SOCKET_OK
        FAILED_INIT
        FAILED_RESOLVE
        FAILED_CONNECT
        FAILED_REUSE
        FAILED_BIND
        FAILED_LISTEN
    end enum

    type socket_info

        data as sockaddr_in
        declare property port( ) as ushort

        declare operator cast( ) as string
        declare operator cast( ) as sockaddr ptr

    end type

    type socket
        public:
        enum ACCESS_METHOD

        ONLY_ONCE = -1
        BLOCK     = 0

        end enum

        declare constructor( )
        declare destructor( )

        declare function client _
        ( _
        byval ip as integer, _
        byval port as integer _
        ) as integer

        declare function client _
        ( _
        byref server as string, _
        byval port as integer _
        ) as integer

        declare function UDPClient _
        ( _
        byval ip as integer, _
        byval port as integer _
        ) as integer

        declare function UDPClient _
        ( _
        byref server as string, _
        byval port as integer _
        ) as integer

        declare function UDPClient _
        ( _
        ) as integer

        declare function server _
        ( _
        byval port as integer, _
        byval max_queue as integer = 4 _
        ) as integer

        declare function UDPServer _
        ( _
        byval port as integer, _
        byval ip as integer = INADDR_ANY _
        ) as integer

        declare function UDPConnectionlessServer _
        ( _
        byval port as integer _
        ) as integer

        declare function listen _
        ( _
        byref timeout as double = 0 _
        ) as integer

        declare function listenToNew _
        ( _
        byref listener as socket, _
        byval timeout as double = 0 _
        ) as integer

        declare function getData _
        ( _
        byval data_ as any ptr, _
        byval size as integer, _
        byval peek_only as integer = FALSE _
        ) as integer

        declare function getLine _
        ( _
        ) as string

        declare function getUntil _
        ( _
        byref target as string _
        ) as string

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

        declare function putData _
        ( _
        byval data_ as any ptr, _
        byval size as integer   _
        ) as integer


        #macro fbext_SocketPut_Declare(T_)
        declare function put overload _
            ( _
                byref data_ as fbext_TypeName(T_), _
                byref elems as integer = 1, _
                byval time_out as integer = 0 _
            ) as integer
        #endmacro

        fbext_InstanciateMulti(fbext_SocketPut, fbext_BuiltinTypes())

        declare function putLine _
        ( _
        byref text as string _
        ) as integer

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

        declare function dumpData _
        ( _
        byval size as integer _
        ) as integer

        declare function length _
        ( _
        ) as SizeType

        declare function isClosed _
        ( _
        ) as bool

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
