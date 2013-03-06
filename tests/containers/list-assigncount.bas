'# define fbext_NoBuiltinInstanciations() -1
# include once "ext/testly.bi"
# include once "ext/containers/list.bi"

'fbext_Instanciate(fbext_List, ((integer)) )

namespace ext.tests.containers

    const n = 4
    const value = 69

    private sub testAssignToEmptyList

        var list = fbext_List( ((integer)) )

        list.Assign(n, value)

        TESTLY_ASSERT_EQUAL( list.Size(), n )

        var first = list.cBegin()

        do while first <> list.cEnd()
            TESTLY_ASSERT_EQUAL( **(first.PostIncrement()), value )
        loop

    end sub

    private sub testAssignToSmallerList

        var list = fbext_List( ((integer)) )
        list.PushBack(1)
        list.PushBack(2)

        list.Assign(n, value)

        TESTLY_ASSERT_EQUAL( list.Size(), n )

        var first = list.cBegin()

        do while first <> list.cEnd()
            TESTLY_ASSERT_EQUAL( **(first.PostIncrement()), value )
        loop

    end sub

    private sub testAssignToSimilarList

        var list = fbext_List( ((integer)) )
        list.PushBack(1)
        list.PushBack(2)
        list.PushBack(3)
        list.PushBack(4)

        list.Assign(n, value)

        TESTLY_ASSERT_EQUAL( list.Size(), n )

        var first = list.cBegin()

        do while first <> list.cEnd()
            TESTLY_ASSERT_EQUAL( **(first.PostIncrement()), value )
        loop

    end sub

    private sub testAssignToLargerList

        var list = fbext_List( ((integer)) )
        list.PushBack(1)
        list.PushBack(2)
        list.PushBack(3)
        list.PushBack(4)
        list.PushBack(5)
        list.PushBack(6)

        list.Assign(n, value)

        TESTLY_ASSERT_EQUAL( list.Size(), n )

        var first = list.cBegin()

        do while first <> list.cEnd()
            TESTLY_ASSERT_EQUAL( **(first.PostIncrement()), value )
        loop

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-containers-list-assigncount")
        ext.testly.addTest("testAssignToEmptyList", @testAssignToEmptyList)
        ext.testly.addTest("testAssignToSmallerList", @testAssignToSmallerList)
        ext.testly.addTest("testAssignToSimilarList", @testAssignToSimilarList)
        ext.testly.addTest("testAssignToLargerList", @testAssignToLargerList)
    end sub

end namespace
