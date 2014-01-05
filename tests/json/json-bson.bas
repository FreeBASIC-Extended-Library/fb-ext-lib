#include once "ext/tests.bi"
#include once "ext/json.bi"

namespace ext.tests.json_bson

private sub test_bson2json

        dim j as ext.json.JSONobject
        j.addChild("hello",new ext.json.JSONvalue("world"))
        var bson_len = 0u
        var bson = j.toBSON(bson_len)

        dim b as ext.json.JSONobject
        b.fromBSON(bson,bson_len)

        delete[] bson

        var s = b.child("hello")->getString()

        EXT_ASSERT_TRUE("world" = s)
        EXT_ASSERT_TRUE(1 = b.children())

    end sub

    private sub test_json2bson

        dim j as ext.json.JSONobject

        j.addChild("hello",new ext.json.JSONvalue("world"))

        var bson_len = 0u
        var bson = j.toBSON(bson_len)

        EXT_ASSERT_TRUE(&h16 = bson_len)
        EXT_ASSERT_TRUE("hello" = *(cast(zstring ptr, @(bson[5]))))
        EXT_ASSERT_TRUE("world" = *(cast(zstring ptr, @(bson[15]))))
        delete[] bson

    end sub

    private sub test_bson_array

        var test_str = !"{ \"obj\" : [ 1, { \"this\" : true } ] }"
        dim j as ext.json.JSONobject
        j.loadString(test_str)

        var bson_len = 0u
        var bson = j.toBSON(bson_len)

        dim b as ext.json.JSONobject
        b.fromBSON(bson,bson_len)

        delete[] bson

        var a = b.child("obj")->getArray()
        EXT_ASSERT_TRUE(2 = a->length())
        EXT_ASSERT_TRUE(1 = a->at(0)->getNumber())
        EXT_ASSERT_TRUE(a->at(1)->getObject()->child("this")->getBool())

        EXT_ASSERT_TRUE(1 = b.children())
        EXT_ASSERT_TRUE(test_str = str(j))
        EXT_ASSERT_TRUE(test_str = str(b))

    end sub

    private sub test_bson_object

        var test_str = !"{ \"obj\" : { \"one\" : 1, \"two\" : 2 } }"
        dim j as ext.json.JSONobject
        j.loadString(test_str)

        var bson_len = 0u
        var bson = j.toBSON(bson_len)

        dim b as ext.json.JSONobject
        b.fromBSON(bson,bson_len)

        delete[] bson

        EXT_ASSERT_TRUE(1 = b.children())
        EXT_ASSERT_TRUE(2 = b.child("obj")->getObject()->children())
        EXT_ASSERT_TRUE(1 = b.child("obj")->getObject()->child("one")->getNumber())
        EXT_ASSERT_TRUE(2 = b.child("obj")->getObject()->child("two")->getNumber())

    end sub

    private sub register constructor
        ext.tests.addSuite("ext-json-bson")
        ext.tests.addTest("JSON to BSON",@test_json2bson)
        ext.tests.addTest("BSON to JSON",@test_bson2json)
        ext.tests.addTest("BSON array",@test_bson_array)
        ext.tests.addTest("BSON object",@test_bson_object)
    end sub
end namespace

