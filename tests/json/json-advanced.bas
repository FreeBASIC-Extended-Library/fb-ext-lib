#include once "ext/tests.bi"
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
    ext_assert_TRUE( t <> null )
    dim as string test
    test = j

    ext_assert_TRUE( test = test_string )

    var o1 = j.child("object1")
    ext_assert_TRUE_ERROR( o1 <> null )
    ext_assert_TRUE( o1->valueType() = ext.json.jvalue_type.jnumber )
    ext_assert_TRUE( o1->getNumber() = 1 )

    var o2 = j.child("object2")
    ext_assert_TRUE_ERROR( o2 <> null )
    ext_assert_TRUE( o2->valueType() = ext.json.jvalue_type.jnumber )
    ext_assert_TRUE( o2->getNumber() = 2 )

    end sub

    const as string array_string_t = "[ 1, 2, 3, 4, 5 ]"

    private sub test_json_array_toplevel

        dim j as ext.json.JSONobject
        j.loadString(array_string_t)
        var t = ""
        t = j

        ext_assert_TRUE( j.children() = 1 )
        ext_assert_TRUE( t = array_string_t )
        ext_assert_TRUE( j.child("") <> null )

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
        ext_assert_TRUE(test <> null)

        var t = ""
        t = j

        ext_assert_TRUE( t = !"{ \"test\" : { \"case\" : 1, \"case2\" : 2 } }" )

    end sub

    private sub floating_point
        dim j as ext.json.JSONobject
        var test = j.loadString(!"{ \"PI\":3.141E-10 }")
        ext_assert_TRUE(test <> null)

        var v = j.child("PI")
        ext_assert_TRUE(v <> null)

        ext_assert_TRUE(v->valueType = ext.json.jvalue_type.jnumber)
        ext_assert_TRUE(v->getNumber = 3.141e-10)

    end sub

    private sub register constructor
        ext.tests.addSuite("JSON Advanced")
        ext.tests.addTest("test_create_adv", @test_create_adv)
        ext.tests.addTest("Toplevel Array",@test_json_array_toplevel)
        ext.tests.addTest("Nested Objects",@nested_obj)
        ext.tests.addTest("Floating Point",@floating_point)
    end sub


end namespace
