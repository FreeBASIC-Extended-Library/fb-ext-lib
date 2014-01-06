''Title: net/ports.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_NET_PORTS_BI__
#define FBEXT_NET_PORTS_BI__ -1
''namespace: ext.net
namespace ext.net

    ''Enum: PORT
    ''Defines common ports for different protocols.
    ''See http://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers for a
    ''more comprehensive list.
    ''
    enum PORT

    FTP_DATA    = 20
    FTP_CONTROL = 21
    SSH         = 22
    TELNET      = 23
    SMTP        = 25
    WHOIS       = 43
    DHCP_SERVER   = 67
    DHCP_CLIENT = 68
    TFTP        = 69
    GOPHER      = 70
    FINGER      = 79
    HTTP        = 80
    ONION_RT    = 81
    ONION_CTRL  = 82
    POP3        = 110
    IDENT       = 113
    SFTP        = 115
    NNTP        = 119
    NTP         = 123
    NB_NAME     = 137
    NB_DGRAM    = 138
    NB_SESSION  = 139
    IMAP        = 143
    SNMP        = 161
    SNMPTRAP    = 162
    IMAP3       = 220
    LDAP        = 389
    HTTPS       = 443
    SMB         = 445
    RPC         = 530
    AIM         = 531
    RTSP        = 554
    IPP         = 631
    LDAPS       = 636
    FTPS_DATA   = 989
    FTPS_CTRL   = 990
    IMAPS       = 993
    POP3S       = 995
    WINS        = 1512
    IRC         = 6667
    end enum

end namespace

#endif 'FBEXT_NET_PORTS_BI__
