#include once "ext/database/database.bi"
#include once "ext/database/drivers/sqlite3driver.bi"
using ext.database

var db = new Connection( "sqlite3.db", newSQLite3Driver() )

if db->connect() <> StatusCode.Ok then
	print "Error connecting to the database."
	print db->getError()
	delete db
	end
end if

var res = db->prepare( "SELECT * FROM test_table;" )

while res->execute() = StatusCode.MoreResults

	for n as integer = 0 to res->numColumns() - 1
		print res->columnName( n ) & " | ";
	next
	print
	for n as integer = 0 to res->numColumns() - 1
		print res->columnValue( n ) & " | ";
	next
	print

wend

delete res
delete db


