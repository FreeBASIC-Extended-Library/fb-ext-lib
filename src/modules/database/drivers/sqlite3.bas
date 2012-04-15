''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include once "ext/database/drivers/sqlite3driver.bi"
namespace ext.database

type SQLite3DriverInfo
	as sqlite3 ptr db
	as sqlite3_stmt ptr stmt
end type

	declare function mapS2E( byval c as integer ) as StatusCode

	declare function sqlite3_opendb( byval d as DatabaseDriverF ptr, byref connect as const string ) as StatusCode
	declare function sqlite3_closedb( byval d as DatabaseDriverF ptr ) as StatusCode
	declare function sqlite3_prepareD( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
	declare function sqlite3_noresquery( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
	declare function sqlite3_stepD( byval d as DatabaseDriverF ptr ) as StatusCode
	declare function sqlite3_numcol( byval d as DatabaseDriverF ptr ) as integer
	declare function sqlite3_colname( byval d as DatabaseDriverF ptr, byval col as integer ) as string
	declare function sqlite3_colval( byval d as DatabaseDriverF ptr, byval col as integer ) as string
	declare function sqlite3_final( byval d as DatabaseDriverF ptr ) as StatusCode
	declare function sqlite3_errors( byval d as DatabaseDriverF ptr ) as string
	declare function sqlite3_dbhandle( byval d as DatabaseDriverF ptr ) as any ptr
	declare function sqlite3_stmthandle( byval d as DatabaseDriverF ptr ) as any ptr
	declare sub sqlite3_destroydd( byval d as DatabaseDriverF ptr )
	declare function sqlite3_bindint( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as integer ) as StatusCode
	declare function sqlite3_bindstr( byval d as DatabaseDriverF ptr, byval coli as integer, byref vali as string ) as StatusCode
	declare function sqlite3_binddbl( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as double ) as StatusCode
	declare function sqlite3_bindblob( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as any ptr, byval lenv as integer ) as StatusCode
	declare function sqlite3_bindnull( byval d as DatabaseDriverF ptr, byval coli as integer ) as StatusCode

function mapS2E( byval c as integer ) as StatusCode

	select case c
	case SQLITE_OK
		function = StatusCode.Ok
	case SQLITE_RANGE
		function = StatusCode.IndexOutOfRange
	case SQLITE_ROW
		function = StatusCode.MoreResults
	case SQLITE_BUSY
		function = StatusCode.Retry
	case SQLITE_DONE
		function = StatusCode.Done
	case SQLITE_SCHEMA, SQLITE_FORMAT, SQLITE_MISUSE
		function = StatusCode.SyntaxError
	case else
		function = StatusCode.Error
	end select

end function

function newSQLite3Driver() as DatabaseDriverF ptr

	var x = new DatabaseDriverF
	x->opendb = @sqlite3_opendb
	x->closedb = @sqlite3_closedb
	x->noresq = @sqlite3_noresquery
	x->prepdb = @sqlite3_prepareD
	x->stepfunc = @sqlite3_stepD
	x->numcols = @sqlite3_numcol
	x->colname = @sqlite3_colname
	x->colval = @sqlite3_colval
	x->cleanup = @sqlite3_final
	x->geterr = @sqlite3_errors
	x->gethandle = @sqlite3_dbhandle
	x->sthandle = @sqlite3_stmthandle
	x->destroy = @sqlite3_destroydd
	x->bindint = @sqlite3_bindint
	x->binddbl = @sqlite3_binddbl
	x->bindstr = @sqlite3_bindstr
	x->bindblob = @sqlite3_bindblob
	x->bindnull = @sqlite3_bindNull
	x->driverdata = new SQLite3DriverInfo

	return x

end function

function sqlite3_noresquery( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode

	return mapS2E(sqlite3_exec( cast(SQLite3DriverInfo ptr,d->driverdata)->db, sql, 0, 0, 0 ))

end function

sub sqlite3_destroydd( byval d as DatabaseDriverF ptr )

	delete cast( SQLite3DriverInfo ptr, d->driverdata )

end sub

function sqlite3_opendb( byval d as DatabaseDriverF ptr, byref connect as const string ) as StatusCode

	return mapS2E(sqlite3_open( connect, @(cast( SQLite3DriverInfo ptr, d->driverdata )->db)))

end function

function sqlite3_closedb( byval d as DatabaseDriverF ptr ) as StatusCode

	return mapS2E(sqlite3_close( cast( SQLite3DriverInfo ptr, d->driverdata )->db ))

end function

function sqlite3_prepareD( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode

	var x = mapS2E(sqlite3_prepare_v2( cast( SQLite3DriverInfo ptr, d->driverdata )->db, sql, len(sql)+1, @(cast( SQLite3DriverInfo ptr, d->driverdata )->stmt), 0 ))
	print __function__ & ": " & *(sqlite3_errmsg(cast( SQLite3DriverInfo ptr, d->driverdata )->db ))
	return x
	
end function

function sqlite3_stepD( byval d as DatabaseDriverF ptr ) as StatusCode

	var ret = sqlite3_step( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt )
	var x = mapS2E(ret)
	print __function__ & ":(" & ret & "): " & *(sqlite3_errmsg(cast( SQLite3DriverInfo ptr, d->driverdata )->db ))
	return x

end function

function sqlite3_numcol( byval d as DatabaseDriverF ptr ) as integer

	return sqlite3_column_count( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt ) 'sqlite3_data_count?

end function

function sqlite3_colname( byval d as DatabaseDriverF ptr, byval col as integer ) as string

	var temp = *( sqlite3_column_name( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt, col ) )
	print __function__ & ": " & *(sqlite3_errmsg(cast( SQLite3DriverInfo ptr, d->driverdata )->db ))
	return temp

end function

function sqlite3_bindint( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as integer ) as StatusCode
	return mapS2E(sqlite3_bind_int( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt, coli, vali ))
end function

function sqlite3_binddbl( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as double ) as StatusCode
	return mapS2E(sqlite3_bind_double( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt, coli, vali ))
end function

function sqlite3_bindstr( byval d as DatabaseDriverF ptr, byval coli as integer, byref vali as string ) as StatusCode
	return mapS2E(sqlite3_bind_text( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt, coli, vali, len(vali), SQLITE_TRANSIENT ))
end function

function sqlite3_bindblob( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as any ptr, byval lenv as integer ) as StatusCode
	return mapS2E(sqlite3_bind_blob( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt, coli, vali, lenv, SQLITE_TRANSIENT ))
end function

function sqlite3_bindNull( byval d as DatabaseDriverF ptr, byval coli as integer ) as StatusCode
	return mapS2E(sqlite3_bind_null( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt, coli ))
end function

function sqlite3_colval( byval d as DatabaseDriverF ptr, byval col as integer ) as string

	var temp = *( sqlite3_column_text( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt, col ) )
	print __function__ & ": " & *(sqlite3_errmsg(cast( SQLite3DriverInfo ptr, d->driverdata )->db ))
	return temp

end function

function sqlite3_final( byval d as DatabaseDriverF ptr ) as StatusCode
	return mapS2E(sqlite3_finalize( cast( SQLite3DriverInfo ptr, d->driverdata )->stmt ))
end function

function sqlite3_errors( byval d as DatabaseDriverF ptr ) as string

	var temp = *( sqlite3_errmsg( cast( SQLite3DriverInfo ptr, d->driverdata )->db ) )
	return temp

end function

function sqlite3_dbhandle( byval d as DatabaseDriverF ptr ) as any ptr

	return cast( SQLite3DriverInfo ptr, d->driverdata )->db

end function

function sqlite3_stmthandle( byval d as DatabaseDriverF ptr ) as any ptr

	return cast( SQLite3DriverInfo ptr, d->driverdata )->stmt

end function

end namespace
