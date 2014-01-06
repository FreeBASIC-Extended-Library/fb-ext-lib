''Title: database/drivers/postgre.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#include once "ext/database/driver.bi"
#if not __FB_MT__
    #inclib "ext-database-driver-postgre"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-database-driver-postgre.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif


''Namespace: ext.database.driver
namespace ext.database.driver

''Function: _Postgre
''Returns a pointer to a <DatabaseDriver> populated to allow access to a Postgre database.
''Connect string is in the same format as would be passed to PQconnectdb
declare function _Postgre( byref conn as const string ) as DatabaseDriver ptr


end namespace
