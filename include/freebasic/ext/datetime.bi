''Title: datetime.bi
''
''About: Code License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

#include once "ext/detail/common.bi"

#ifndef FBEXT_MISC_DATETIME_BI__
#define FBEXT_MISC_DATETIME_BI__ -1

#ifndef FBEXT_MISC
#if not __FB_MT__
    #inclib "ext-misc"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-misc.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif
#endif

''Namespace: ext.datetime
namespace ext.datetime

    ''Function: formatAsISO
    ''Formats a datetime value as an ISO 8601 standard date/time string.
    ''
    ''Parameters:
    ''t - double representing the date/time, default = now
    ''n - bool normalize time to UTC, default = true
    ''
    ''Returns:
    ''Normalized to UTC - String formatted as: yyyy-mm-ddThh:mm:ssZ with the time listed
    ''as UTC on all platforms except DOS.
    ''Non-normalized - String formatted as: yyyy-mm-ddThh:mm:ss(+/-)hh:mm
    declare function formatAsISO( byval t as double = 0.0, byval n as bool = true ) as string

end namespace

#endif
