#include once "ext/testly.bi"
#include once "ext/json.bi"

namespace ext.tests.json_

    private sub test_create

    dim j as ext.json.JSONobject

    j.addChild("one",new ext.json.JSONvalue(1))
    j.addChild("test",new ext.json.JSONvalue(true))

    dim as string test
    test = j

    TESTLY_ASSERT_TRUE( test = !"{ \"one\" : 1, \"test\" : true }")

    end sub

    private sub test_create_array

    dim j as ext.json.JSONobject

    dim as ext.json.JSONvalue ptr ptr arr

    arr = callocate(sizeof(ext.json.JSONvalue ptr)*10)

    for n as uinteger = 0 to 9
        arr[n] = new ext.json.JSONvalue(n)
    next

    j.addChild("array",new ext.json.JSONvalue(new ext.json.JSONarray(arr,10)))

    dim as string test
    test = j

    TESTLY_ASSERT_TRUE( test = !"{ \"array\" : [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ] }")


    end sub

    private sub test_create_blank

    dim j as ext.json.JSONobject
    dim t as string
    t = j

    TESTLY_ASSERT_TRUE( t = "{}" )

    end sub

    private sub test_create_from_string

    var test_str = !"{ \"one\" : 1, \"test\" : true }"

    dim as ext.json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    TESTLY_ASSERT_TRUE( t = test_str )

    end sub

    private sub test_create_from_string_array
    var test_str = !"{ \"array\" : [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ] }"

    dim as ext.json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    TESTLY_ASSERT_TRUE( t = test_str )

    end sub

    private sub test_create_from_string_obj
    var test_str = !"{ \"obj\" : [ 1, { \"this\" : true } ] }"

    dim as ext.json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    TESTLY_ASSERT_TRUE( t = test_str )

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-json-create")
        ext.testly.addTest("test_create", @test_create)
        ext.testly.addTest("test_create_array",@test_create_array)
        ext.testly.addTest("test_create_blank",@test_create_blank)
        ext.testly.addTest("test_create_from_string",@test_create_from_string)
        ext.testly.addTest("loadString w/ Array",@test_create_from_string_array)
        ext.testly.addTest("loadString w/ Object",@test_create_from_string_obj)
    end sub


end namespace
