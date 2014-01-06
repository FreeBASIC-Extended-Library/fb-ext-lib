'Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
'
'Distributed under the FreeBASIC Extended Library Group license. See
'accompanying file LICENSE.txt or copy at
'http://code.google.com/p/fb-extended-lib/wiki/License
'
'Define used Sqlite3 functions if using the built-in static lib
'to avoid dependency on the dll on windows.
'

#ifndef FBEXT_DATABASE_SQLITE_INT__
#define FBEXT_DATABASE_SQLITE_INT__ 1

#ifndef EXT_USE_SQLITEDLL
    #inclib "ext-sqlite-3.6.23"
#else
    #inclib "sqlite3"
#endif

extern "c"
type sqlite3 as any
type sqlite3_stmt as any

declare function sqlite3_libversion cdecl alias "sqlite3_libversion" () as zstring ptr
declare function sqlite3_sourceid cdecl alias "sqlite3_sourceid" () as zstring ptr
declare function sqlite3_libversion_number cdecl alias "sqlite3_libversion_number" () as integer
declare function sqlite3_compileoption_used cdecl alias "sqlite3_compileoption_used" (byval zOptName as zstring ptr) as integer
declare function sqlite3_compileoption_get cdecl alias "sqlite3_compileoption_get" (byval N as integer) as zstring ptr
declare function sqlite3_threadsafe cdecl alias "sqlite3_threadsafe" () as integer

type sqlite3_destructor_type as sub cdecl( byval as any ptr )
#define SQLITE_STATIC cast(sub cdecl(byval as any ptr),0)
#define SQLITE_TRANSIENT cast(sub cdecl(byval as any ptr),-1)

#define SQLITE_OK 0
#define SQLITE_ERROR 1
#define SQLITE_INTERNAL 2
#define SQLITE_PERM 3
#define SQLITE_ABORT 4
#define SQLITE_BUSY 5
#define SQLITE_LOCKED 6
#define SQLITE_NOMEM 7
#define SQLITE_READONLY 8
#define SQLITE_INTERRUPT 9
#define SQLITE_IOERR 10
#define SQLITE_CORRUPT 11
#define SQLITE_NOTFOUND 12
#define SQLITE_FULL 13
#define SQLITE_CANTOPEN 14
#define SQLITE_PROTOCOL 15
#define SQLITE_EMPTY 16
#define SQLITE_SCHEMA 17
#define SQLITE_TOOBIG 18
#define SQLITE_CONSTRAINT 19
#define SQLITE_MISMATCH 20
#define SQLITE_MISUSE 21
#define SQLITE_NOLFS 22
#define SQLITE_AUTH 23
#define SQLITE_FORMAT 24
#define SQLITE_RANGE 25
#define SQLITE_NOTADB 26
#define SQLITE_ROW 100
#define SQLITE_DONE 101

declare function sqlite3_prepare_v2 ( byval db_ as sqlite3 ptr, byval zSql_ as const zstring ptr, byval nByte_ as integer, byval ppStmt_ as sqlite3_stmt ptr ptr, byval pzTail_ as const zstring ptr ptr ) as integer
declare function sqlite3_exec( byval db_ as sqlite3 ptr, byval zSql_ as const zstring ptr, byval callback as function( byval as any ptr, byval as integer, byval as zstring ptr ptr, byval as zstring ptr ptr ) as integer, byval arg__ as any ptr, byval errmessage as zstring ptr ptr ) as integer
declare function sqlite3_open( byval filename_ as const zstring ptr, byval ppDb as sqlite3 ptr ptr ) as integer
declare function sqlite3_close( byval db_ as sqlite3 ptr ) as integer
declare function sqlite3_step( byval stmt as sqlite3_stmt ptr ) as integer
declare function sqlite3_column_count( byval stmt as sqlite3_stmt ptr ) as integer
declare function sqlite3_column_name( byval stmt as sqlite3_stmt ptr, byval c_o_l_ as integer ) as const zstring ptr
declare function sqlite3_bind_blob( byval as sqlite3_stmt ptr, byval as integer, byval d as const any ptr, byval n as integer, byval as sub( byval as any ptr ) ) as integer
declare function sqlite3_bind_double( byval as sqlite3_stmt ptr, byval as integer, byval as double) as integer
declare function sqlite3_bind_int( byval as sqlite3_stmt ptr, byval as integer, byval as integer) as integer
declare function sqlite3_bind_null( byval as sqlite3_stmt ptr, byval as integer) as integer
declare function sqlite3_bind_text( byval as sqlite3_stmt ptr, byval as integer, byval as const zstring ptr, byval as integer, byval as sub( byval as any ptr ) ) as integer 'void(*)(void*)
declare function sqlite3_column_text( byval as sqlite3_stmt ptr, byval as integer ) as const zstring ptr
declare function sqlite3_finalize( byval as sqlite3_stmt ptr ) as integer
declare function sqlite3_errmsg( byval as sqlite3 ptr ) as const zstring ptr

end extern

#endif
