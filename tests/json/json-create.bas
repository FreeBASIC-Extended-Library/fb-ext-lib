#include once "ext/tests.bi"
#include once "ext/json.bi"

namespace ext.tests.json_

    private sub test_create

    dim x as uinteger
    dim j as ext.json.JSONobject

    j.addChild("one",new ext.json.JSONvalue(1))
    
    ext_assert_TRUE(j.hasChild("one", x))
    ext_assert_TRUE(x = 0)
    
    j.addChild("test",new ext.json.JSONvalue(true))
    ext_assert_TRUE(j.hasChild("test", x))
    ext_assert_TRUE(x = 1)

    dim as string test
    test = j

    ext_assert_TRUE( test = !"{ \"one\" : 1, \"test\" : true }")
    'and test removing
    
    j.removeChild("test")
    ext_assert_FALSE(j.hasChild("test"))
    ext_assert_TRUE( j.children = 1 )

    end sub

    private sub test_create_array_adv

    dim j as ext.json.JSONobject

    dim as ext.json.JSONvalue ptr ptr arr

    arr = new ext.json.JSONvalue ptr[10]

    for n as uinteger = 0 to 9
        arr[n] = new ext.json.JSONvalue(n)
    next

    j.addChild("array",new ext.json.JSONvalue(new ext.json.JSONarray(arr,10)))

    dim as string test
    test = j

    ext_assert_TRUE( test = !"{ \"array\" : [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ] }")


    end sub

    private sub test_create_blank

    dim j as ext.json.JSONobject
    dim t as string
    t = j

    ext_assert_TRUE( t = "{}" )

    end sub

    private sub test_create_from_string

    var test_str = !"{ \"one\" : 1, \"test\" : true }"

    dim as ext.json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    ext_assert_TRUE( t = test_str )

    end sub

    private sub test_create_from_string_array
    var test_str = !"{ \"array\" : [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ] }"

    dim as ext.json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    ext_assert_TRUE( t = test_str )

    end sub

    private sub test_create_from_string_obj
    var test_str = !"{ \"obj\" : [ 1, { \"this\" : true } ] }"

    dim as ext.json.JSONobject j
    j.loadString( test_str )
    var t = ""
    t = j

    ext_assert_TRUE( t = test_str )

    end sub

    private sub test_create_null_array
    var test_arr = ext.json.JSONarray(10)
    for n as uinteger = 0 to 9
        var tv = test_arr.at(n)
        EXT_ASSERT_TRUE( tv->valueType() = ext.json.jvalue_type.jnull )
    next
    end sub

    private sub register constructor
        ext.tests.addSuite("ext-json-create")
        ext.tests.addTest("test_create", @test_create)
        ext.tests.addTest("test_create_array_adv",@test_create_array_adv)
        ext.tests.addTest("test_create_null_array",@test_create_null_array)
        ext.tests.addTest("test_create_blank",@test_create_blank)
        ext.tests.addTest("test_create_from_string",@test_create_from_string)
        ext.tests.addTest("loadString w/ Array",@test_create_from_string_array)
        ext.tests.addTest("loadString w/ Object",@test_create_from_string_obj)
    end sub


end namespace
