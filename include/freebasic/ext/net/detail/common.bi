''Title: net/detail/common.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_NET_DETAIL_COMMON_BI__
#define FBEXT_NET_DETAIL_COMMON_BI__ -1

#inclib "ext-net"

#ifdef __fb_win32__

#define SO_SNDTIMEO &h1005

#include "ext/net/detail/winsockets.bi"
#inclib "user32"

#endif

#ifdef __fb_linux__

#include "crt/sys/select.bi"
#include "crt/arpa/inet.bi"
#include "crt/netdb.bi"
#include "crt/unistd.bi"

#define h_addr h_addr_list[0]

#endif

#undef opaque

''namespace: ext.net
namespace ext.net

    ''Enum: SOCKET_ERRORS
    ''Provides the specific error (if any) that occured.
    enum SOCKET_ERRORS
        SOCKET_OK
        FAILED_INIT
        FAILED_RESOLVE
        FAILED_CONNECT
        FAILED_REUSE
        FAILED_BIND
        FAILED_LISTEN
    end enum

    enum ACCESS_METHOD
        ONLY_ONCE = -1
        BLOCK     = 0
    end enum

    const as string CR_LF = chr(13, 10)

    ''Macro: BUILD_IP
    ''Builds an integer IP address from 4 octets.
    ''
    ''Example:
    ''BUILD_IP(10,1,1,10) = 10.1.1.10
    ''
    #define BUILD_IP( _1, _2, _3, _4 ) _
                    ( ( ( _4 and 255 ) shl 24 ) or _
                    ( ( _3 and 255 ) shl 16 ) or _
                    ( ( _2 and 255 ) shl  8 ) or _
                    ( ( _1 and 255 ) shl  0 ) )

    ''Macro: BREAK_IP
    ''Easy access to each octet of an integer IP address.
    ''
    #define BREAK_IP( _octet, _addr ) ( ( _addr shr ( 8 * _octet ) ) and 255 )

    ''Constant: LOCALHOST
    ''Represents the integer IP address of the local host or 127.0.0.1
    ''
    const as integer LOCALHOST = BUILD_IP( 127, 0, 0, 1 )

    #define SERIAL_UDT(x) *cast(ubyte ptr, @(x)), len(x)

    ''Function: resolve
    ''Performs a name lookup on the specified host to get the IP address to connect to.
    ''
    ''Returns:
    ''Integer representative of the IP address.
    ''
    declare function resolve _
    ( _
    byref host as string _
    ) as UInteger

end namespace

#endif 'FBEXT_NET_DETAIL_COMMON_BI__
