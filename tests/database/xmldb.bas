#include once "ext/tests.bi"
#include once "ext/database/drivers/xml.bi"

using ext.database.drivers.xml_

namespace ext.tests.database.xml__

const as string create_t = "CREATE TABLE testing_table ( first_column text, second_column text, third_column text );"
const as string i_one = "INSERT INTO testing_table VALUES ( one, two, three );"
const as string i_two = "INSERT INTO testing_table VALUES ( 1, 2, 3 );"
const as string i_three = "INSERT INTO testing_table VALUES ( one1, two2, three3 );"
const as string up_t = "UPDATE testing_table SET second_column = 'four' WHERE second_column = two;"

private sub verify_schema

    var db = new XMLdatabase
    EXT_ASSERT_TRUE(query_noresults(db,create_t) = Xderr.NO_ERROR)

    EXT_ASSERT_TRUE(db->lasttable <> null)
    EXT_ASSERT_TRUE(create_t = db->lasttable->attribute("schema"))

    delete db

end sub

private sub verify_insertion

    var db = new XMLdatabase

    EXT_ASSERT_TRUE(query_noresults(db,create_t) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_two) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_three) = Xderr.NO_ERROR)

    EXT_ASSERT_TRUE(db->docroot->root->child(0) <> null)
    EXT_ASSERT_TRUE(db->docroot->root->child(0)->children() = 3)
    EXT_ASSERT_TRUE(db->docroot->root->child(0)->child(0)->children() = 3)

    delete db

end sub

private sub verify_update

    var db = new XMLdatabase
    EXT_ASSERT_TRUE(query_noresults(db,create_t) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_two) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_three) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,up_t) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(db->affected_rows = 1)
    EXT_ASSERT_TRUE(db->lasttable->child(0)->child(1)->getText = "four")
    EXT_ASSERT_TRUE(db->lasttable->child(1)->child(1)->getText = "2")
    EXT_ASSERT_TRUE(db->lasttable->child(2)->child(1)->getText = "two2")
    delete db

end sub

private sub do_select_all

    var db = new XMLdatabase
    EXT_ASSERT_TRUE(query_noresults(db,create_t) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_two) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_three) = Xderr.NO_ERROR)

    var r = query_res(db,"SELECT * FROM testing_table;")
    var c = 0
    do while r = Xderr.MORE_RESULTS
    c += 1
    r = result_step(db)
    loop

    EXT_ASSERT_TRUE(3 = c)

    delete db
    
end sub

private sub do_select_some

    var db = new XMLdatabase
    EXT_ASSERT_TRUE(query_noresults(db,create_t) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_two) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_three) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)

    var r = query_res(db,"SELECT * FROM testing_table WHERE second_column = two;")
    var c = 0
    do while r = Xderr.MORE_RESULTS
    c += 1
    r = result_step(db)
    loop

    EXT_ASSERT_TRUE(2 = c)

    delete db
    
end sub

private sub do_delete_some

    var db = new XMLdatabase

    EXT_ASSERT_TRUE(query_noresults(db,create_t) = Xderr.NO_ERROR)

    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_two) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_three) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)

    EXT_ASSERT_TRUE(query_noresults(db,"DELETE FROM testing_table WHERE second_column = two;") = Xderr.NO_ERROR)

    EXT_ASSERT_TRUE(2 = db->affected_rows)

    delete db
    
end sub

private sub do_delete_all

    var db = new XMLdatabase

    EXT_ASSERT_TRUE(query_noresults(db,create_t) = Xderr.NO_ERROR)

    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_two) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_three) = Xderr.NO_ERROR)
    EXT_ASSERT_TRUE(query_noresults(db,i_one) = Xderr.NO_ERROR)

    EXT_ASSERT_TRUE(query_noresults(db,"DELETE FROM testing_table;") = Xderr.NO_ERROR)
    
    EXT_ASSERT_TRUE(4 = db->affected_rows)

    delete db
    
end sub

sub register constructor
    ext.tests.addSuite("ext-database-xml")
    ext.tests.addTest("verify schema",@verify_schema)
    ext.tests.addTest("verify insertion",@verify_insertion)
    ext.tests.addTest("verify update",@verify_update)
    ext.tests.addTest("select all",@do_select_all)
    ext.tests.addTest("select some",@do_select_some)
    ext.tests.addTest("delete some",@do_delete_some)
    ext.tests.addTest("delete all",@do_delete_all)
end sub

end namespace
