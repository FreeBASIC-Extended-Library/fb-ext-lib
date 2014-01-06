''Title: database/database.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#include once "ext/database/driver.bi"
#include once "ext/detail/common.bi"
#if not __FB_MT__
    #inclib "ext-database"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-database.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

''Namespace: ext.database
namespace ext.database

''Class: Statement
''Represents a prepared statement and allows access to the results of a statement passed to the database.
''This class is not meant to be created manually, only returned from
''the <Connection.prepare> function.
type Statement
    declare constructor( byref zzsql as string, byval d as DatabaseDriver ptr )
    declare destructor()

    ''Function: bind
    ''Attaches a value to anonymous parameters in the Query string.
    ''
    ''Supported types are integer, double, string and blob (pointer)
    ''
    ''Anonymous parameters in a query string are the ? symbol.
    ''Example:
    '' INSERT INTO 'db' (?,?,?) WHERE 'username' = ?
    ''Has 4 anonymous parameters numbered 1 to 4.
    declare function bind overload ( byval coli as integer, byval value as integer ) as StatusCode
    declare function bind ( byval coli as integer, byval value as double ) as StatusCode
    declare function bind ( byval coli as integer, byref value as string ) as StatusCode
    declare function bind ( byval coli as integer, byval value as any ptr, byval lenv as integer ) as StatusCode
    declare function bind ( byval coli as integer ) as StatusCode


    ''Function: execute
    ''Executes the prepared statement on the database and steps through
    ''the resulting rows (if any).
    ''
    ''Returns:
    ''Database dependant error code.
    declare function execute( ) as StatusCode

    ''Function: numColumns
    ''Returns the number of columns in the result set.
    declare function numColumns( ) as integer

    ''Function: columnName
    ''
    ''Parameters:
    ''iCol - integer number of column
    ''
    ''Returns:
    ''The name of the column passed.
    declare function columnName( byval iCol as integer ) as string

    ''Function: columnValue
    ''
    ''Parameters:
    ''iCol - integer number of column
    ''
    ''Returns:
    ''The value in the column passed.
    declare function columnValue( byval iCol as integer ) as string

    ''Function: finalize
    ''Releases memory held by the statement.
    ''
    ''Returns:
    ''Database dependant error code.
    declare function finalize( ) as StatusCode

    ''Function: handle
    ''
    ''Returns:
    ''Database dependant handle to this prepared statement.
    declare function handle() as any ptr

    private:
        m_db_driver as DatabaseDriver ptr
        m_sql as string
        m_prepared as bool
end type

''Class: Connection
''Represents a connection to a database and provides a facility for
''prepared statements.
type Connection

    ''Sub: Component Constructor
    ''Initializes a database connection with only a <ext.database.DatabaseDriver>.
    ''
    ''Parameters:
    ''d - a pointer to a <ext.database.DatabaseDriver>
    declare constructor( byval d as DatabaseDriver ptr )

    ''Sub: Copy Constructor
    ''Copies the <ext.database.DatabaseDriver> and connect string from another <Connection>
    declare constructor( byref rhs as Connection )

    ''Function: connect
    ''Connects to the database.
    ''
    ''Returns:
    ''Database dependant error code.
    declare function connect( ) as StatusCode
    'declare function execute( byref sql as const string, byval callback as dbcallback ) as integer

    ''Function: prepare
    ''Factory method to create <Statement>s
    ''
    ''Parameters:
    ''sql - the SQL statement you want to pass to the database.
    ''
    ''Returns:
    ''Pointer to a <Statement>. You must delete this when you are done.
    declare function prepare( byref sql as string ) as Statement ptr


    ''Function: query
    ''Execute a no results one-off statement.
    ''
    ''Returns:
    ''Database dependant error code.
    declare function query( byref sql as const string ) as StatusCode
    ''Function: close
    ''Closes the connection to the database.
    ''This invalidates any remaining <Statment> objects.
    ''
    ''Returns:
    ''Database dependant error code
    declare function close() as StatusCode

    ''Function: getError
    ''Returns a string containing the current error message from the database.
    declare function getError () as string

    ''Function: handle
    ''Returns a pointer to the database dependant handle for this connection.
    declare function handle() as any ptr

    declare destructor()

    private:
        m_db_driver as DatabaseDriver ptr
end type



end namespace
