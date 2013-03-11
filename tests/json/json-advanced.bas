#include once "ext/testly.bi"
#include once "ext/json.bi"

namespace ext.tests.json_

    const as string test_string_a = _
    !"{\n" & _
    !"\"object1\":1,\n" & _
    !"\"object2\":2\n" & _
    "}"

    const as string test_string = !"{ \"object1\" : 1, \"object2\" : 2 }"

    private sub test_create_adv

    dim j as ext.json.JSONobject
    var t = j.loadString(test_string_a)
    TESTLY_ASSERT_TRUE( t <> null )
    dim as string test
    test = j

    TESTLY_ASSERT_TRUE( test = test_string )

    var o1 = j.child("object1")
    TESTLY_ASSERT_TRUE_ERROR( o1 <> null )
    TESTLY_ASSERT_TRUE( o1->valueType() = ext.json.jvalue_type.number )
    TESTLY_ASSERT_TRUE( o1->getNumber() = 1 )

    var o2 = j.child("object2")
    TESTLY_ASSERT_TRUE_ERROR( o2 <> null )
    TESTLY_ASSERT_TRUE( o2->valueType() = ext.json.jvalue_type.number )
    TESTLY_ASSERT_TRUE( o2->getNumber() = 2 )

    end sub

    const as string array_string_t = "[ 1, 2, 3, 4, 5 ]"

    private sub test_json_array_toplevel

        dim j as ext.json.JSONobject
        j.loadString(array_string_t)
        var t = ""
        t = j

        TESTLY_ASSERT_TRUE( j.children() = 1 )
        TESTLY_ASSERT_TRUE( t = array_string_t )

    end sub

    const as string nested_obj_str = _
    "{" & _
    !"\"test\": {" & _
    !"       \"case\": 1," & _
    !"       \"case2\": 2," & _
    "       }" & _
    "}"

    private sub nested_obj

        dim j as ext.json.JSONobject
        var test = j.loadString(nested_obj_str)
        TESTLY_ASSERT_TRUE(test <> null)

        var t = ""
        t = j

        TESTLY_ASSERT_TRUE( t = !"{ \"test\" : { \"case\" : 1, \"case2\" : 2 } }" )

    end sub

    private sub register constructor
        ext.testly.addSuite("JSON Advanced")
        ext.testly.addTest("test_create_adv", @test_create_adv)
        ext.testly.addTest("Toplevel Array",@test_json_array_toplevel)
        ext.testly.addTest("Nested Objects",@nested_obj)
    end sub


end namespace
