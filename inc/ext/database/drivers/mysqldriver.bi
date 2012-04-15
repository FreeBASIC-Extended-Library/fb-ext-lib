''Title: database/drivers/mysqldriver.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
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


''Namespace: ext.database
namespace ext.database

''Function: newMySQLDriver
''Returns a pointer to a <DatabaseDriver> populated to allow access to a MySQL database.
''Connect string is in the format: username:passwd@host:port/dbname
''passwd, port and dbname are all optional, string without would be username@host
declare function newMySQLDriver() as DatabaseDriver ptr


end namespace
