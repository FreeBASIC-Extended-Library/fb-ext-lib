# include once "ext/tests.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers.array_

    private sub test_index

        var array = ext.fbext_Array( ((integer)) )

        for i as integer = 0 to 5
            array.PushBack(i)
        next

        for i as integer = 0 to 5
            ext_assert_EQUAL( i, *array.Index(i) )
        next

    end sub

    private sub test_at

        var array = ext.fbext_Array( ((integer)) )

        for i as integer = 0 to 5
            array.PushBack(i)
        next

        ext_assert_EQUAL( 1, *array.at(1) )
        ext_assert_TRUE( array.at(10) = null )

    end sub

    private sub register constructor
        ext.tests.addSuite("ext-containers-array-index")
        ext.tests.addTest("Index", @test_index)
        ext.tests.addTest("At",@test_at)
    end sub

end namespace
