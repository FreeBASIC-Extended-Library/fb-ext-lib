''Title: database/drivers/xml.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#include once "ext/database/driver.bi"
#include once "ext/xml/dom.bi"

#if not __FB_MT__
    #inclib "ext-database-driver-xml"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-database-driver-xml.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif


''Namespace: ext.database.driver
namespace ext.database.driver

''Function: _XML
''Returns a pointer to a <DatabaseDriver> populated to allow access to a Ext XML database.
''Connect string is filename of database to open.
''This driver recognizes a subset of SQL.
''
''SQL supported:
'' * CREATE TABLE table_name ( col1name type, col2name type, ... ); type is ignored as all values are stored as text but should be included.
'' * DROP TABLE table_name;
'' * SELECT * FROM table_name WHERE colname = value; The where clause is optional. Does not support retrieving only certain columns, must be *
'' * UPDATE table_name SET col1name = value, col2name = value, ... WHERE col1name = value; The where clause is optional.
'' * INSERT INTO table_name VALUES ( val1, val2, ... ); Column specification not supported and ignored if found, number of values must match number of columns.
'' * DELETE FROM table_name WHERE colname = value; The where clause is optional.
''
''Notes:
''When using a WHERE clause at this time only one predicate is supported.
''To create an in-memory only database use the connection string ::memory::
declare function _XML( byref conn as const string ) as DatabaseDriver ptr

end namespace

namespace ext.database.drivers.xml_

enum Xderr explicit
    TABLE_ALREADY_EXISTS = -8
    MORE_RESULTS = -4
    END_OF_QUERY = -2
    INVALID = -1
    NO_ERROR = 0
end enum

type XMLdatabase
    as ext.xml.tree ptr docroot
    as ext.xml.node ptr lasttable
    as string where_clause
    as uinteger index
    as uinteger affected_rows
    as string dbfile
    #ifdef FBEXT_MULTITHREADED
    _mutex as any ptr
    #endif
    declare constructor ( byref fn as const string = "::memory::" )
    declare destructor
end type

declare function query_noresults ( byval db as XMLdatabase ptr, byref query as const string ) as Xderr
declare function query_res ( byval db as XMLdatabase ptr, byref query as const string ) as Xderr
declare function result_colname ( byval db as XMLDatabase ptr, byval i as uinteger ) as string
declare function result_column overload ( byval db as XMLdatabase ptr, byref colname as string ) as string
declare function result_column overload ( byval db as XMLdatabase ptr, byval i as uinteger ) as string
declare function result_columns ( byval db as XMLDatabase ptr ) as uinteger
declare function result_step ( byval db as XMLdatabase ptr ) as Xderr
declare function xmldb_escape( byref x as string ) as string

end namespace
