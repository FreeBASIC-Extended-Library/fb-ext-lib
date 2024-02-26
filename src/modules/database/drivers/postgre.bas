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

#include once "ext/database/drivers/postgre.bi"
#include once "postgresql/libpq-fe.bi"

namespace ext.database.driver

type PostgreDriverInfo
    db as pg_conn
    res as pg_result
    conn_s as string
    st as uinteger
    ep as uinteger
end type


    declare function mapP2E( byval c as integer ) as StatusCode

    declare function postgres_opendb( byval d as DatabaseDriverF ptr ) as StatusCode
    declare function postgres_closedb( byval d as DatabaseDriverF ptr ) as StatusCode
    declare function postgres_prepareD( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
    declare function postgres_noresquery( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
    declare function postgres_stepD( byval d as DatabaseDriverF ptr ) as StatusCode
    declare function postgres_numcol( byval d as DatabaseDriverF ptr ) as integer
    declare function postgres_colname( byval d as DatabaseDriverF ptr, byval col as integer ) as string
    declare function postgres_colval( byval d as DatabaseDriverF ptr, byval col as integer ) as string
    declare function postgres_final( byval d as DatabaseDriverF ptr ) as StatusCode
    declare function postgres_errors( byval d as DatabaseDriverF ptr ) as string
    declare function postgres_dbhandle( byval d as DatabaseDriverF ptr ) as any ptr
    declare function postgres_stmthandle( byval d as DatabaseDriverF ptr ) as any ptr
    declare sub postgres_destroydd( byval d as DatabaseDriverF ptr )
    'declare function postgres_bindint( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as integer ) as StatusCode
    'declare function postgres_bindstr( byval d as DatabaseDriverF ptr, byval coli as integer, byref vali as string ) as StatusCode
    'declare function postgres_binddbl( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as double ) as StatusCode
    'declare function postgres_bindblob( byval d as DatabaseDriverF ptr, byval coli as integer, byval vali as any ptr, byval lenv as integer ) as StatusCode
    'declare function postgres_bindnull( byval d as DatabaseDriverF ptr, byval coli as integer ) as StatusCode

private function mapP2E( byval c as integer ) as StatusCode

select case c
    case is > PGRES_COPY_IN
        return StatusCode.Error
    case CONNECTION_OK, PGRES_COMMAND_OK, PGRES_TUPLES_OK
        return StatusCode.Ok
    case CONNECTION_NEEDED
        return StatusCode.Retry
    case PGRES_BAD_RESPONSE
        return StatusCode.SyntaxError
    case else
        return StatusCode.Error
end select

end function

private function postgres_estr( byval d as DatabaseDriverF ptr, byref e as string ) as string

    var ret = space(len(e)*2)

    PQescapeString(ret,e,len(e))

    return trim(ret)

end function

private function postgres_opendb( byval d as DatabaseDriverF ptr ) as StatusCode

    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    i->db = PQconnectdb( i->conn_s )
    function = mapP2E( PQstatus( i->db ) )

end function

private function postgres_closedb( byval d as DatabaseDriverF ptr ) as StatusCode

    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    PQfinish( i->db )

    return StatusCode.Ok

end function

private function postgres_prepareD( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode

    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    i->res = PQexec( i->db, sql )

    return MapP2E( PQresultStatus( i->res ) )

end function

private function postgres_noresquery( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
    return d->prepdb(d,sql)
end function

private function postgres_stepD( byval d as DatabaseDriverF ptr ) as StatusCode

    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    if i->ep = 0 then 'first run
        i->st += 1
    else
        i->ep = PQntuples(i->res)
        i->st = 0
    end if

    if i->st >= i->ep then
        return StatusCode.done
    else
        return StatusCode.MoreResults
    end if

end function

private function postgres_numcol( byval d as DatabaseDriverF ptr ) as integer
    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    return PQnfields( i->res )
end function

private function postgres_colname( byval d as DatabaseDriverF ptr, byval col as integer ) as string

    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    var result = ""

    var t = PQfname(i->res,col)
    result = *t

    return result

end function

private function postgres_colval( byval d as DatabaseDriverF ptr, byval col as integer ) as string

    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    var ret = PQgetvalue(i->res,i->st,col)
    var t = ""
    t = *ret
    return t

end function

private function postgres_final( byval d as DatabaseDriverF ptr ) as StatusCode

    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    PQclear(i->res)
    return StatusCode.Ok

end function

private function postgres_errors( byval d as DatabaseDriverF ptr ) as string

    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    var test = PQresultErrorMessage(i->res)
    if test = 0 then
        test = PQerrorMessage(i->db)
    else
        if *test = "" then
            test = PQerrorMessage(i->db)
        end if
    end if

    if test = 0 then
        return ""
    else
        var temp = ""
        temp = *test
        return temp
    end if

end function

private function postgres_dbhandle( byval d as DatabaseDriverF ptr ) as any ptr
    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    return i->db
end function

private function postgres_stmthandle( byval d as DatabaseDriverF ptr ) as any ptr
    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    return i->res
end function

private sub postgres_destroydd( byval d as DatabaseDriverF ptr )
    var i = cast(PostgreDriverInfo ptr,d->driverdata)
    delete i
end sub

private function postgres_affrow( byval d as DatabaseDriverF ptr ) as ulongint
    return culngint(*PQcmdTuples(cast(PostgreDriverInfo ptr,d->driverdata)->res))
end function

function _Postgre( byref connect as const string ) as DatabaseDriverF ptr

    var x = new DatabaseDriverF
    x->opendb = @postgres_opendb
    x->closedb = @postgres_closedb
    x->noresq = @postgres_noresquery
    x->prepdb = @postgres_prepareD
    x->stepfunc = @postgres_stepD
    x->numcols = @postgres_numcol
    x->colname = @postgres_colname
    x->colval = @postgres_colval
    x->cleanup = @postgres_final
    x->geterr = @postgres_errors
    x->gethandle = @postgres_dbhandle
    x->sthandle = @postgres_stmthandle
    x->destroy = @postgres_destroydd
    x->bindint = 0'@postgre_bindint
    x->binddbl = 0'@postgre_binddbl
    x->bindstr = 0'@postgre_bindstr
    x->bindblob = 0'@postgre_bindblob
    x->bindnull = 0'@postgre_bindNull
    x->affected_rows = @postgres_affrow
    x->escape_string = @postgres_estr
    var di = new PostgreDriverInfo
    di->conn_s = connect
    x->driverdata = di

    return x

end function


end namespace
