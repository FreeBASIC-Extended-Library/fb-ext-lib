''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

#include once "ext/xml/dom.bi"
#include once "ext/database/drivers/xml.bi"
#include once "ext/strings/split.bi"

namespace ext.database.drivers.xml_

constructor XMLdatabase ( byref fn as const string = "::memory::" )
    dbfile = fn
    docroot = new ext.xml.tree
    if dbfile <> "::memory::" then
        docroot->load(dbfile)
    end if
end constructor

destructor XMLdatabase
    if docroot <> 0 then
        if dbfile <> "::memory::" then
            docroot->unload(dbfile)
        end if
        delete docroot
    end if
end destructor

private function do_where( byval db as XMLdatabase ptr ) as ext.bool

    var t = db->lasttable
    var i = instr(db->where_clause,"=")
    var coln = trim(left(db->where_clause,i-1))
    var colv = trim(mid(db->where_clause,i+1))
    for n as uinteger = db->index to t->children -1
        var row = db->lasttable->child(n)
        for m as uinteger = 0 to row->children -1
            if row->child(m)->attribute("name") = coln then
                if row->child(m)->getText = colv then
                    db->index = n
                    return ext.true
                end if
            end if
        next
    next

    return ext.false

end function

'CREATE TABLE table_name ( colname type, colname type, colname type );
'table_name;colname;colname;...
private function create_table ( byval db as XMLdatabase ptr, byref query as string ) as Xderr
    dim names() as string
    strings.explode(query,";",names())
    var cols = right(query,len(query)-(len(names(0))+1))
    if db->docroot->root->child(names(0)) <> 0 then return Xderr.TABLE_ALREADY_EXISTS
    db->lasttable = db->docroot->root->appendChild(names(0))
    db->lasttable->attribute("schema") = db->where_clause
    db->lasttable->attribute("columns") = cols
    db->where_clause = ""
    return Xderr.NO_ERROR
end function

'DELETE FROM table_name WHERE colname = value;
private function delete_from ( byval db as XMLdatabase ptr, byref query as string ) as Xderr

    db->lasttable = db->docroot->root->child(query)
    if db->lasttable = 0 then return Xderr.INVALID

    db->affected_rows = 0
    db->index = 0

    while 1

    if db->lasttable->children() = 0 then exit while

        if db->where_clause <> "" then
            if do_where(db) = false then exit while
            'don't increment index here otherwise will skip next row
            db->lasttable->removeChild(db->index)
            db->affected_rows += 1
        else
            db->lasttable->removeChild(0)
            db->affected_rows += 1
        end if

    wend

    return Xderr.NO_ERROR

end function

'INSERT INTO table_name VALUES (value1, value2, value3, ...);
'table_name;value1;value2;value3
private function insert_into ( byval db as XMLdatabase ptr, byref query as string ) as Xderr
    dim vals() as string
    dim cols() as string
    strings.explode(query,";",vals())
    db->lasttable = db->docroot->root->child(vals(0))
    if db->lasttable = 0 then return Xderr.INVALID
    strings.explode(db->lasttable->attribute("columns"),";",cols())
    if ubound(cols) <> (ubound(vals)-1) then
        ? "problem detected with"
        ? query
        return Xderr.INVALID
    end if
    var x = db->lasttable->appendChild("row")
    for n as uinteger = 1 to ubound(vals)
        var c = x->appendChild("column",xml.node_type_e.text)
        c->attribute("name") = cols(n-1)
        c->setText = vals(n)
    next
    return Xderr.NO_ERROR
end function

'DROP TABLE table_name;
'table_name
private function drop_table ( byval db as XMLdatabase ptr, byref query as string ) as Xderr
    if db->docroot->root->child(query) = 0 then return Xderr.INVALID
    db->docroot->root->removeChild(query)
    return Xderr.NO_ERROR
end function

'UPDATE table_name SET colname=value, colname=value, ... WHERE colname=value;
'table_name;colname = value;colname = value
private function update ( byval db as XMLdatabase ptr, byref query as string ) as Xderr
    dim vals() as string
    dim cols() as string
    dim valx() as string
    strings.explode(query,";",vals())
    db->lasttable = db->docroot->root->child(vals(0))
    if db->lasttable = 0 then return Xderr.INVALID
    strings.explode(db->lasttable->attribute("columns"),";",cols())
    
    if db->where_clause <> "" then
        db->index = 0
        var e = do_where(db)
        while e = true

            var row = db->lasttable->child(db->index)
            for n as uinteger = 0 to ubound(cols)-1
                for z as uinteger = 1 to ubound(vals)
                    strings.explode(vals(z),"=",valx())
                    if valx(1)[len(valx(1))-1] = asc(";") then
                        valx(1) = trim(left(valx(1),len(valx(1))-1))
                    end if
                    var c = row->child("column",n)
                    if c->attribute("name") = trim(valx(0)) then
                        c->setText = trim(valx(1))
                        db->affected_rows += 1
                    end if
                next
            next

            db->index += 1
            e = do_where(db)

        wend
    else
        for m as uinteger = 0 to db->lasttable->children() -1
            var x = db->lasttable->child("row",m)
            for n as uinteger = 1 to ubound(vals)
                for z as uinteger = 0 to x->children() -1
                    strings.explode(vals(n),"=",valx())
                    if valx(1)[len(valx(1))-1] = asc(";") then
                        valx(1) = trim(left(valx(1),len(valx(1))-1))
                    end if
                    var c = x->child("column",z)
                    if c->attribute("name") = trim(valx(0)) then
                        c->setText = trim(valx(1))
                        db->affected_rows += 1
                    end if
                next
            next
        next
    end if
    return Xderr.NO_ERROR
end function

'SELECT * FROM table_name WHERE colname=value;
'table_name
private function select_from ( byval db as XMLdatabase ptr, byref query as string ) as Xderr
    if query = "" then return Xderr.INVALID
    db->lasttable = db->docroot->root->child(query)
    db->index = 0
    if db->where_clause <> "" then
        if do_where(db) = false then return Xderr.END_OF_QUERY
    end if

    return Xderr.MORE_RESULTS

end function

public function query_noresults ( byval db as XMLdatabase ptr, byref query as const string ) as Xderr

    if db = 0 then return Xderr.INVALID

    db->affected_rows = 0
    db->where_clause = ""

    if left(query,11) = "DELETE FROM" then
        var res = trim(right(query,len(query)-11))
        var wh = instr(res,"WHERE")
        if wh > 0 then
            db->where_clause = trim(right(res,len(res)-wh-5))
            db->where_clause = trim(left(db->where_clause,len(db->where_clause)-1))
            res = trim(mid(res,1,wh-1))
        end if
        return delete_from(db,res)
    end if

    if left(query,12) = "CREATE TABLE" then
        db->where_clause = query
        var xq = trim(right(query,len(query)-12))
        var iq = instr(xq,"(")
        var res = trim(left(xq,iq-1)) & ";"
        var c = iq+1
        while 1
            var ic = instr(c+1,xq," ")
            if ic < 1 then exit while
            res &= trim(mid(xq,c+1,ic-c)) & ";"
            c = instr(ic+1,xq,",") + 1
            if instr(ic+1,xq,",") < 1 then exit while
        wend
        res = left(res,len(res)-1)
        return create_table(db,res)
    end if

    if left(query,10) = "DROP TABLE" then
        var res = trim(left(right(query,len(query)-10),len(query)-11))
        return drop_table(db,res)
    end if

    if left(query,11) = "INSERT INTO" then
        var res = trim(right(query,len(query)-11))
        var i = instr(res," ")
        var p = instr(res,"VALUES (") + 7
        var f = iif(i > p,p,i)
        var tbln = left(res,f-1)
        res = trim(right(res,len(res)-p))
        dim values() as string
        strings.explode(res,",",values())
        for n as integer = lbound(values) to ubound(values)
            values(n) = trim(values(n))
            if len(values(n)) > 0 then
            if values(n)[0] = asc("(") then values(n) = trim(right(values(n),len(values(n))-1))
            if values(n)[len(values(n))-1] = asc(";") then values(n) = trim(left(values(n),len(values(n))-2))
            end if
        next
        var x = tbln & ";" & strings.join(values(),";")
        return insert_into(db,x)
    end if

    if left(query,6) = "UPDATE" then

        var res = trim(right(query,len(query)-6))
        var i = instr(res," ")
        
        var tbln = left(res,i-1)
        i = instr(i+1,res," ")
        res = trim(right(res,len(res)-i))
        dim values() as string
        strings.explode(res,",",values())
        for n as integer = lbound(values) to ubound(values)
            values(n) = trim(values(n))
            if values(n)[0] = asc("(") then values(n) = trim(right(values(n),len(values(n))-1))
            if values(n)[len(values(n))-1] = asc(";") then values(n) = trim(left(values(n),len(values(n))-1))
            var wh = instr(values(n),"WHERE")
            if wh > 1 then
                db->where_clause = trim(right(values(n),len(values(n))-wh-5))
                values(n) = trim(left(values(n),wh-1))
            end if
        next
        var x = tbln & ";" & strings.join(values(),";")
        return update(db,x)

    end if

    return Xderr.INVALID

end function

public function query_res ( byval db as XMLdatabase ptr, byref query as const string ) as Xderr

    if db = 0 then return Xderr.INVALID

    db->affected_rows = 0

    if left(query,8) = "SELECT *" then

        var from = instr(query,"FROM")+4
        var res = trim(right(query,len(query)-from))
        var s = instr(res," ")
        var tblname = trim(left(res,s-1))
        res = trim(right(res,len(res)-s))
        if tblname = "" then
            tblname = left(res,len(res)-1)
            res = ""
        end if
        db->where_clause = trim(right(res,len(res)-6))
        if db->where_clause[len(db->where_clause)-1] = asc(";") then
            db->where_clause = trim(left(db->where_clause,len(db->where_clause)-1))
        end if
        return select_from(db,tblname)
    end if

    return Xderr.INVALID
end function

public function result_step ( byval db as XMLdatabase ptr ) as Xderr
    if db->where_clause <> "" then
        db->index += 1
        if do_where(db) = false then return Xderr.END_OF_QUERY
    else
        db->index += 1
        if db->index >= db->lasttable->children() then
            db->index = 0
            return Xderr.END_OF_QUERY
        end if
    end if
    return Xderr.MORE_RESULTS
end function

public function result_column overload ( byval db as XMLdatabase ptr, byref colname as string ) as string
    var x = db->lasttable->child(db->index)
    var ret = ""
    for n as uinteger = 0 to x->children -1
        if x->child(n)->attribute("name") = colname then
            ret = x->child(n)->getText
            exit for
        end if
    next
    return ret
end function

public function result_column overload ( byval db as XMLdatabase ptr, byval i as uinteger ) as string
    return db->lasttable->child(db->index)->child(i)->getText
end function

public function result_columns ( byval db as XMLDatabase ptr ) as uinteger
    return db->lasttable->child(db->index)->children
end function

public function result_colname ( byval db as XMLDatabase ptr, byval i as uinteger ) as string
    return db->lasttable->child(db->index)->child(i)->attribute("name")
end function

end namespace

namespace ext.database.drivers

function mapx2d ( byval e as xml_.Xderr ) as StatusCode
    select case e
    case xml_.Xderr.NO_ERROR
        return StatusCode.Ok
    case xml_.Xderr.MORE_RESULTS
        return STatusCode.MoreResults
    case xml_.Xderr.END_OF_QUERY
        return StatusCode.Done
    case xml_.Xderr.INVALID
        return StatusCode.SyntaxError
    case else
        return StatusCode.Error
    end select
end function

function xopen ( byval d as  DatabaseDriverF ptr ) as StatusCode
    return StatusCode.Ok
end function

function xclose( byval d as DatabaseDriverF ptr ) as StatusCode
    delete cast(xml_.XMLdatabase ptr, d->driverdata)
    return StatusCode.Ok
end function

function xnores( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
    var db = cast(xml_.XMLdatabase ptr, d->driverdata)
    return mapx2d(xml_.query_noresults(db,sql))
end function

function xprepare ( byval d as DatabaseDriverF ptr, byref sql as const string ) as StatusCode
    var db = cast(xml_.XMLdatabase ptr, d->driverdata)
    return mapx2d(xml_.query_res(db,sql))
end function

function xstep ( byval d as DatabaseDriverF ptr ) as StatusCode
    var db = cast(xml_.XMLdatabase ptr, d->driverdata)
    return mapx2d(xml_.result_step(db))
end function

function xhandle ( byval d as DatabaseDriverF ptr ) as any ptr
    return d->driverdata
end function

function xaffrow ( byval d as DatabaseDriverF ptr ) as ulongint
    return cast(xml_.XMLdatabase ptr, d->driverdata)->affected_rows
end function

function xcols ( byval d as DatabaseDriverF ptr ) as integer
    var db = cast(xml_.XMLdatabase ptr, d->driverdata)
    return xml_.result_columns(db)
end function

function xcoln ( byval d as DatabaseDriverF ptr, byval col as integer ) as string
    var db = cast(xml_.XMLdatabase ptr, d->driverdata)
    return xml_.result_colname(db,col)
end function

function xcolv ( byval d as DatabaseDriverF ptr, byval col as integer ) as string
    var db = cast(xml_.XMLdatabase ptr, d->driverdata)
    return xml_.result_column(db,col)
end function

function _XML( byref conn as const string ) as DatabaseDriver ptr

    var ret = new DatabaseDriver
    ret->opendb = @xopen
    ret->closedb = @xclose
    ret->noresq = @xnores
    ret->prepdb = @xprepare
    ret->stepfunc = @xstep
    ret->gethandle = @xhandle
    ret->affected_rows = @xaffrow
    ret->numcols = @xcols
    ret->colname = @xcoln
    ret->colval = @xcolv
    ret->driverdata = new xml_.XMLdatabase(conn)
    return ret

end function

end namespace

