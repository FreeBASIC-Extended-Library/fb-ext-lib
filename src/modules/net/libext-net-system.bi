#include once "ext/net/socket.bi"

#undef quick_len
#define quick_len(_s) cast(integer ptr, @_s)[1]

namespace ext.net

    type socket_lock
        declare constructor( byval lock_ as any ptr )
        declare destructor( )

        lock as any ptr
    end type

    declare function translate_error _
    ( _
    byval err_code as SOCKET_ERRORS _
    ) as string

    declare function TCP_client overload _
    ( _
    byref result as uinteger, _
    byref info as socket_info, _
    byref server as string, _
    byval port as integer _
    ) as integer

    declare function TCP_client overload _
    ( _
    byref result as uinteger, _
    byref info as socket_info, _
    byval ip as integer, _
    byval port as integer _
    ) as integer

    declare function client_core _
    ( _
    byref result as uinteger, _
    byref info as socket_info, _
    byval ip as integer, _
    byval port as integer, _
    byval from_socket as uinteger, _
    byval do_connect as integer = TRUE _
    ) as integer

    declare function TCP_server _
    ( _
    byref result as uinteger, _
    byref info as socket_info, _
    byval port as integer, _
    byval max_queue as integer = 4 _
    ) as integer

    declare function TCP_server_accept _
    ( _
    byref result as uinteger, _
    byref timeout as double, _
    byref client_info as sockaddr_in ptr, _
    byval listener as uinteger _
    ) as bool

    declare function server_core _
    ( _
    byref result as uinteger, _
    byref info as socket_info, _
    byval port as integer, _
    byval ip as integer = INADDR_ANY, _
    byval from_socket as uinteger _
    ) as integer

    declare function UDP_server _
    ( _
    byref result as uinteger, _
    byref info as socket_info, _
    byval port as integer, _
    byval ip as integer = INADDR_ANY _
    ) as integer

    declare function UDP_client overload _
    ( _
    byref result as uinteger _
    ) as integer

    declare function UDP_client _
    ( _
    byref result as uinteger, _
    byref info as socket_info, _
    byref server_ as string, _
    byval port_ as integer _
    ) as integer

    declare function UDP_client _
    ( _
    byref result as uinteger, _
    byref info as socket_info, _
    byref ip as integer, _
    byval port_ as integer _
    ) as integer

    declare function is_readable _
    ( _
    byval socket_ as uinteger _
    ) as integer

    declare function close _
    ( _
    byval sock_ as uinteger _
    ) as integer

    declare function new_sockaddr overload( byval serv as integer, byval port as short ) as socket_info ptr
    declare function new_sockaddr( byref serv as string, byval port as short ) as socket_info ptr

    declare function base_HTTP_path( byref thing as string ) as string

    const as integer NOT_AN_IP = -1

    #define new_socket socket_

end namespace
