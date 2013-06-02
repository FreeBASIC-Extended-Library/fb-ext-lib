'# define fbext_NoBuiltinInstanciations() -1
# include once "ext/tests.bi"
# include once "ext/containers/list.bi"

'fbext_Instanciate(fbext_List, ((integer)) )

namespace ext.tests.containers

    const n = 4
    const value = 69

    private sub testAssignToEmptyList

        var list = fbext_List( ((integer)) )

        list.Assign(n, value)

        ext_assert_EQUAL( list.Size(), n )

        var first = list.cBegin()

        do while first <> list.cEnd()
            ext_assert_EQUAL( **(first.PostIncrement()), value )
        loop

    end sub

    private sub testAssignToSmallerList

        var list = fbext_List( ((integer)) )
        list.PushBack(1)
        list.PushBack(2)

        list.Assign(n, value)

        ext_assert_EQUAL( list.Size(), n )

        var first = list.cBegin()

        do while first <> list.cEnd()
            ext_assert_EQUAL( **(first.PostIncrement()), value )
        loop

    end sub

    private sub testAssignToSimilarList

        var list = fbext_List( ((integer)) )
        list.PushBack(1)
        list.PushBack(2)
        list.PushBack(3)
        list.PushBack(4)

        list.Assign(n, value)

        ext_assert_EQUAL( list.Size(), n )

        var first = list.cBegin()

        do while first <> list.cEnd()
            ext_assert_EQUAL( **(first.PostIncrement()), value )
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

        ext_assert_EQUAL( list.Size(), n )

        var first = list.cBegin()

        do while first <> list.cEnd()
            ext_assert_EQUAL( **(first.PostIncrement()), value )
        loop

    end sub

    private sub register constructor
        ext.tests.addSuite("ext-containers-list-assigncount")
        ext.tests.addTest("testAssignToEmptyList", @testAssignToEmptyList)
        ext.tests.addTest("testAssignToSmallerList", @testAssignToSmallerList)
        ext.tests.addTest("testAssignToSimilarList", @testAssignToSimilarList)
        ext.tests.addTest("testAssignToLargerList", @testAssignToLargerList)
    end sub

end namespace
