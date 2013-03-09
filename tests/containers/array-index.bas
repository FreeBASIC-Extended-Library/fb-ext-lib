# include once "ext/testly.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers.array_

    private sub test_index

        var array = ext.fbext_Array( ((integer)) )

        for i as integer = 0 to 5
            array.PushBack(i)
        next

        for i as integer = 0 to 5
            TESTLY_ASSERT_EQUAL( i, *array.Index(i) )
        next

    end sub

    private sub test_at

        var array = ext.fbext_Array( ((integer)) )

        for i as integer = 0 to 5
            array.PushBack(i)
        next

        TESTLY_ASSERT_EQUAL( 1, *array.at(1) )
        TESTLY_ASSERT_TRUE( array.at(10) = null )

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-containers-array-index")
        ext.testly.addTest("Index", @test_index)
        ext.testly.addTest("At",@test_at)
    end sub

end namespace
