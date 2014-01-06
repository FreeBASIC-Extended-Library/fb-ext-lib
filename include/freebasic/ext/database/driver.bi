''Title: database/driver.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License


''Namespace: ext.database
namespace ext.database

''Enum: StatusCode
''Database dependant status codes are mapped to their logical equivalent
''in this enumeration.
enum StatusCode explicit
    Error
    Ok
    MoreResults
    Done
    Retry
    SyntaxError
    IndexOutOfRange
end enum

type DatabaseDriverF as DatabaseDriver

type DBOpenFunc as function( byval d as  DatabaseDriverF ptr ) as StatusCode
type DBCloseFunc as function( byval d as DatabaseDriverF ptr ) as StatusCode
type DBNoResultsQuery as function( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
type DBPrepareFunc as function( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
type DBStepFunc as function( byval d as DatabaseDriverF ptr ) as StatusCode
type DBColInResult as function( byval d as DatabaseDriverF ptr ) as integer
type DBColName as function( byval d as DatabaseDriverF ptr, byval col as integer ) as string
type DBColVal as function( byval d as DatabaseDriverF ptr, byval col as integer ) as string
type DBCleanup as function( byval d as DatabaseDriverF ptr ) as StatusCode
type DBError as function( byval d as DatabaseDriverF ptr ) as string
type DBHandle as function( byval d as DatabaseDriverF ptr ) as any ptr
type STMTHandle as function( byval d as DatabaseDriverF ptr ) as any ptr
type DDdestroy as sub( byval d as DatabaseDriverF ptr )
type DBbindInt as function( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as integer ) as StatusCode
type DBbindDbl as function( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as double ) as StatusCode
type DBbindStr as function( byval d as DatabaseDriverF ptr, byval coli as integer, byref vali as string ) as StatusCode
type DBbindBlob as function( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as any ptr, byval lenv as integer ) as StatusCode
type DBbindNull as function( byval d as DatabaseDriverF ptr, byval coli as integer ) as StatusCode


''Type: DatabaseDriver
''A group of function pointers to enable access to a database.
''
''To see how to write a DatabaseDriver see the file src/modules/database/drivers/sqlite3.bas.
type DatabaseDriver
    as DBOpenFunc opendb
    as DBCloseFunc closedb
    as DBNoResultsQuery noresq
    as DBPrepareFunc prepdb
    as DBbindInt bindInt
    as DBbindDbl bindDbl
    as DBbindStr bindStr
    as DBbindBlob bindBlob
    as DBbindNull bindNull
    as DBStepFunc stepfunc
    as DBColInResult numcols
    as DBColName colname
    as DBColVal colval
    as DBCleanup cleanup
    as DBError geterr
    as DBHandle gethandle
    as STMTHandle sthandle
    as DDdestroy destroy
    as any ptr driverdata
end type

end namespace
