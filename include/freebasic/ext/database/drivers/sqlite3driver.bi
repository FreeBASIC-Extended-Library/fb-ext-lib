''Title: database/drivers/sqlite3driver.bi
''
''About: License
''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#include once "ext/database/drivers/sqlite3driver_int.bi"
#include once "ext/database/driver.bi"
#if not __FB_MT__
	#inclib "ext-database-driver-sqlite3"
	#ifdef FBEXT_MULTITHREADED
		#error "The multithreaded version of the library must be built using the -mt compiler option."
	#endif
#else
	#inclib "ext-database-driver-sqlite3.mt"
	#ifndef FBEXT_MULTITHREADED
		#define FBEXT_MULTITHREADED 1
	#endif
#endif


''Namespace: ext.database
namespace ext.database

''Function: newSQLite3Driver
''Returns a pointer to a <DatabaseDriver> populated to allow access to a SQLite3 database.
''Connect string is filename of database to open.
declare function newSQLite3Driver() as DatabaseDriver ptr


end namespace
