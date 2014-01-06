''Title: database/drivers/mysql.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#include once "ext/database/driver.bi"
#if not __FB_MT__
    #inclib "ext-database-driver-mysql"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-database-driver-mysql.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif


''Namespace: ext.database.driver
namespace ext.database.driver

''Function: _MySQL
''Returns a pointer to a <DatabaseDriver> populated to allow access to a MySQL database.
''Connect string is in the format: username:passwd@host:port/dbname
''passwd, port and dbname are all optional, string without would be username@host
declare function _MySQL( byref conn as const string ) as DatabaseDriver ptr


end namespace
