''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
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

#include once "ext/database/drivers/mysql.bi"

#include once "mysql/mysql.bi"

namespace ext.database.driver

type MySQLDriverInfo
    as mysql ptr db
    as mysql_res ptr res
    as mysql_row trow
    as string sql_s
    as string conn_s
    declare destructor
end type

destructor MySQLDriverInfo
    sql_s = ""
    conn_s = ""
end destructor

    declare function mapMY2E( byval c as integer ) as StatusCode

    declare function MySQL_opendb( byval d as DatabaseDriverF ptr ) as StatusCode
    declare function MySQL_closedb( byval d as DatabaseDriverF ptr ) as StatusCode
    declare function MySQL_prepareD( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
    declare function MySQL_noresquery( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
    declare function MySQL_stepD( byval d as DatabaseDriverF ptr ) as StatusCode
    declare function MySQL_numcol( byval d as DatabaseDriverF ptr ) as integer
    declare function MySQL_colname( byval d as DatabaseDriverF ptr, byval col as integer ) as string
    declare function MySQL_colval( byval d as DatabaseDriverF ptr, byval col as integer ) as string
    declare function MySQL_final( byval d as DatabaseDriverF ptr ) as StatusCode
    declare function MySQL_errors( byval d as DatabaseDriverF ptr ) as string
    declare function MySQL_dbhandle( byval d as DatabaseDriverF ptr ) as any ptr
    declare function MySQL_stmthandle( byval d as DatabaseDriverF ptr ) as any ptr
    declare sub MySQL_destroydd( byval d as DatabaseDriverF ptr )
    declare function MySQL_bindint( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as integer ) as StatusCode
    declare function MySQL_bindstr( byval d as DatabaseDriverF ptr, byval coli as integer, byref vali as string ) as StatusCode
    declare function MySQL_binddbl( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as double ) as StatusCode
    declare function MySQL_bindblob( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as any ptr, byval lenv as integer ) as StatusCode
    declare function MySQL_bindnull( byval d as DatabaseDriverF ptr, byval coli as integer ) as StatusCode
    declare function MySQL_affrow( byval d as DatabaseDriverF ptr ) as ulongint
    
private function mapMY2E( byval c as integer ) as StatusCode

    return c

end function

private function mysql_estr( byval d as DatabaseDriverF ptr, byref e as string ) as string

    var ret = space(len(e)*2)

    mysql_real_escape_string(cast( MySQLDriverInfo ptr, d->driverdata )->db,ret,e,len(e))

    return trim(ret)

end function

function _MySQL( byref connect as const string ) as DatabaseDriverF ptr

    var x = new DatabaseDriverF
    x->opendb = @MySQL_opendb
    x->closedb = @MySQL_closedb
    x->noresq = @MySQL_noresquery
    x->prepdb = @MySQL_prepareD
    x->stepfunc = @MySQL_stepD
    x->numcols = @MySQL_numcol
    x->colname = @MySQL_colname
    x->colval = @MySQL_colval
    x->cleanup = @MySQL_final
    x->geterr = @MySQL_errors
    x->gethandle = @MySQL_dbhandle
    x->sthandle = @MySQL_stmthandle
    x->destroy = @MySQL_destroydd
    x->bindint = 0'@MySQL_bindint
    x->binddbl = 0'@MySQL_binddbl
    x->bindstr = 0'@MySQL_bindstr
    x->bindblob = 0'@MySQL_bindblob
    x->bindnull = 0'@MySQL_bindNull
    x->affected_rows = @MySQL_affrow
    x->escape_string = @mysql_estr
    var di = new MySQLDriverInfo
    di->conn_s = connect
    x->driverdata = di

    return x

end function

private function MySQL_noresquery( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode

    return mapMY2E(MySQL_real_query( cast(MySQLDriverInfo ptr,d->driverdata)->db, sql, len(sql) ))

end function

private sub MySQL_destroydd( byval d as DatabaseDriverF ptr )

    delete cast( MySQLDriverInfo ptr, d->driverdata )

end sub

private function MySQL_opendb( byval d as DatabaseDriverF ptr ) as StatusCode

    var username = ""
    var passwd = ""
    var host = ""
    var db = ""
    var port = 0
    var connect = cast(MySQLDriverInfo ptr,d->driverdata)->conn_s
    'connect string format: "username:passwd@host:port/db
    var i = instr(connect,"@")
    if i > 0 then
        var ii = instr(connect,":")
        if ii < i then
            'username and passwd
            username = left(connect,ii-1)
            passwd = mid(connect,ii+1,i-(ii+1))
        else
            'just username
            username = left(connect,i)
        endif
        var foundhost = 0
        ii = instr(i,connect,":")
        if ii > 0 then
            foundhost = 1
            host = mid(connect,i+1,ii-(i+1))
            'have port
            port = valint(mid(connect,ii+1))
        endif

        ii = instr(i,connect,"/")
        if ii > 0 then
            'have db
            if foundhost = 0 then
                host = mid(connect,i+1,ii-(i+1))
            endif
            db = right(connect,len(connect)-ii)
        elseif foundhost = 0 then
            'just hostname
            host = right(connect,Len(connect)-i)
        endif
    endif

    cast( MySQLDriverInfo ptr, d->driverdata )->db = mysql_real_connect( cast( MySQLDriverInfo ptr, d->driverdata )->db, host, username, passwd, db, port, 0, 0 )

    return mapMY2E(MySQL_errno( cast( MySQLDriverInfo ptr, d->driverdata )->db ) )

end function

private function MySQL_closedb( byval d as DatabaseDriverF ptr ) as StatusCode

    MySQL_close( cast( MySQLDriverInfo ptr, d->driverdata )->db )
    return StatusCode.Ok

end function

private function MySQL_prepareD( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode

    mysql_real_query( cast( MySQLDriverInfo ptr, d->driverdata )->db, sql, len(sql) )

    cast( MySQLDriverInfo ptr, d->driverdata )->res = mysql_store_result( cast( MySQLDriverInfo ptr, d->driverdata )->db )
    return StatusCode.Ok

end function

private function MySQL_stepD( byval d as DatabaseDriverF ptr ) as StatusCode

    cast( MySQLDriverInfo ptr, d->driverdata )->trow = MySQL_fetch_row( cast( MySQLDriverInfo ptr, d->driverdata )->res )

    return iif( cast( MySQLDriverInfo ptr, d->driverdata )->trow = 0, StatusCode.Done, StatusCode.MoreResults )

end function

private function MySQL_numcol( byval d as DatabaseDriverF ptr ) as integer

    return mysql_num_fields( cast( MySQLDriverInfo ptr, d->driverdata )->res ) 'MySQL_data_count?

end function

private function MySQL_colname( byval d as DatabaseDriverF ptr, byval col as integer ) as string

    var result = ""

    var f = mysql_fetch_field_direct( cast( MySQLDriverInfo ptr, d->driverdata )->res, col )

    result = *(f->name)

    return result

end function
/'
private function MySQL_bindint( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as integer ) as StatusCode
    return mapMY2E(MySQL_bind_int( cast( MySQLDriverInfo ptr, d->driverdata )->stmt, coli, vali ))
end function

private function MySQL_binddbl( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as double ) as StatusCode
    return mapMY2E(MySQL_bind_double( cast( MySQLDriverInfo ptr, d->driverdata )->stmt, coli, vali ))
end function

private function MySQL_bindstr( byval d as DatabaseDriverF ptr, byval coli as integer, byref vali as string ) as StatusCode
    return mapMY2E(MySQL_bind_text( cast( MySQLDriverInfo ptr, d->driverdata )->stmt, coli, vali, len(vali), SQLITE_TRANSIENT ))
end function

private function MySQL_bindblob( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as any ptr, byval lenv as integer ) as StatusCode
    return mapMY2E(MySQL_bind_blob( cast( MySQLDriverInfo ptr, d->driverdata )->stmt, coli, vali, lenv, SQLITE_TRANSIENT ))
end function

private function MySQL_bindNull( byval d as DatabaseDriverF ptr, byval coli as integer ) as StatusCode
    return mapMY2E(MySQL_bind_null( cast( MySQLDriverInfo ptr, d->driverdata )->stmt, coli ))
end function
'/
private function MySQL_colval( byval d as DatabaseDriverF ptr, byval col as integer ) as string

    var temp = *( cast( MySQLDriverInfo ptr, d->driverdata )->trow[col] )
    return temp

end function

private function MySQL_final( byval d as DatabaseDriverF ptr ) as StatusCode
    MySQL_free_result( cast( MySQLDriverInfo ptr, d->driverdata )->res )
    return StatusCode.Ok
end function

private function MySQL_errors( byval d as DatabaseDriverF ptr ) as string

    var temp = *( MySQL_error( cast( MySQLDriverInfo ptr, d->driverdata )->db ) )
    return temp

end function

private function MySQL_dbhandle( byval d as DatabaseDriverF ptr ) as any ptr

    return cast( MySQLDriverInfo ptr, d->driverdata )->db

end function

private function MySQL_stmthandle( byval d as DatabaseDriverF ptr ) as any ptr

    return cast( MySQLDriverInfo ptr, d->driverdata )->res

end function

private function MySQL_affrow( byval d as DatabaseDriverF ptr ) as ulongint
    return mysql_affected_rows(cast(MySQLDriverInfo ptr,d)->db)
end function

end namespace
