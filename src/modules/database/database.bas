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

#include once "ext/database/database.bi"

namespace ext.database

constructor Connection ( byref connectst as string, byval d as DatabaseDriverF ptr )
	m_cs = connectst
	m_db_driver = d
end constructor

constructor Connection ( byval d as DatabaseDriverF ptr )
	m_db_driver = d
end constructor

constructor Connection ( byref rhs as Connection )
	m_cs = rhs.m_cs
	m_db_driver = rhs.m_db_driver
end constructor

function Connection.connect( byref connectst as string = "") as StatusCode

	if connectst = "" and m_cs = "" then return -1
	if connectst <> "" then
		m_cs = connectst
	else
		if m_cs = "" then return -1
	end if

	return m_db_driver->opendb( m_db_driver, m_cs )

end function

function Connection.getError() as string
	return m_db_driver->geterr( m_db_driver )
end function

function Connection.query( byref sql as const string ) as StatusCode

	return m_db_driver->noresq( m_db_driver, sql )

end function

function Connection.prepare( byref sql as string ) as Statement ptr

	return new Statement( sql, m_db_driver )

end function

function Connection.close() as StatusCode

	return m_db_driver->closedb( m_db_driver )

end function

function Connection.handle() as any ptr

	return m_db_driver->gethandle( m_db_driver )

end function

destructor Connection()
	m_cs = ""
	this.close()
	m_db_driver->destroy( m_db_driver )
	delete m_db_driver

end destructor

constructor Statement( byref zzsql as string, byval d as DatabaseDriverF ptr )
	m_db_driver = d
	m_sql = zzsql
end constructor

destructor Statement()
	m_sql = ""
	this.finalize()

end destructor

function Statement.bind overload ( byval coli as integer, byval value as integer ) as StatusCode
	return m_db_driver->bindint( m_db_driver, coli, value )
end function

function Statement.bind ( byval coli as integer, byval value as double ) as StatusCode
	return m_db_driver->binddbl( m_db_driver, coli, value )
end function

function Statement.bind ( byval coli as integer, byref value as string ) as StatusCode
	return m_db_driver->bindstr( m_db_driver, coli, value )
end function

function Statement.bind ( byval coli as integer, byval value as any ptr, byval lenv as integer ) as StatusCode
	return m_db_driver->bindblob( m_db_driver, coli, value, lenv )
end function

function Statement.bind ( byval coli as integer ) as StatusCode
	return m_db_driver->bindNull( m_db_driver, coli )
end function

function Statement.execute( ) as StatusCode

	if (not m_prepared) then
		m_db_driver->prepdb( m_db_driver, m_sql )
		m_prepared = true
	end if

	return m_db_driver->stepfunc( m_db_driver )
end function

function Statement.numColumns( ) as integer
	return m_db_driver->numcols( m_db_driver )
end function

function Statement.columnName( byval iCol as integer ) as string
	var temp = (m_db_driver->colname( m_db_driver, iCol ))
	return temp
end function

function Statement.columnValue( byval iCol as integer ) as string
	var temp = (m_db_driver->colval( m_db_driver, iCol ))
	return temp
end function

function Statement.finalize( ) as StatusCode
	return m_db_driver->cleanup( m_db_driver )
end function

function Statement.handle() as any ptr

	return m_db_driver->sthandle( m_db_driver )

end function

end namespace
