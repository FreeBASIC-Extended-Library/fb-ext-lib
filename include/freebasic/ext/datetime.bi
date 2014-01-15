''Title: datetime.bi
''
''About: Code License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_MISC_DATETIME_BI__
#define FBEXT_MISC_DATETIME_BI__ -1

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

''Namespace: ext.datetime
namespace ext.datetime

    ''Function: formatAsISO
    ''Formats a datetime value as an ISO 8601 standard date/time string.
    ''
    ''Parameters:
    ''t - double representing the date/time, default = now
    ''
    ''Returns:
    ''String formatted as: yyyy-mm-ddThh:mm:ssZ with the time listed
    ''as UTC on all platforms except DOS.
    declare function formatAsISO( byval t as double = 0.0 ) as string

end namespace

#endif
