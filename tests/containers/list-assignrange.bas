# define fbext_NoBuiltinInstanciations() 1
# include once "ext/tests.bi"

# include once "ext/containers/list.bi"

fbext_Instanciate(fbext_List, ((integer)))

namespace ext.tests.containers

	private sub testAssignToEmptyList

		var list1 = fbext_List( ((integer)) )
		list1.PushBack(1)
		list1.PushBack(2)
		list1.PushBack(3)
		list1.PushBack(4)

		var list2 = fbext_List( ((integer)) )

		list2.Assign(list1.cBegin(), list1.cEnd())

   		ext_assert_EQUAL( list2.Size(), list1.Size() )

		var first1 = list1.cBegin()
		var first2 = list2.cBegin()

		do while first1 <> list1.cEnd()
    		ext_assert_EQUAL( **(first2.PostIncrement()), **(first1.PostIncrement()) )
		loop

	end sub

	private sub testAssignToSmallerList

		var list1 = fbext_List( ((integer)) )
		list1.PushBack(1)
		list1.PushBack(2)
		list1.PushBack(3)
		list1.PushBack(4)

		var list2 = fbext_List( ((integer)) )
		list2.PushBack(5)
		list2.PushBack(6)

		list2.Assign(list1.cBegin(), list1.cEnd())

   		ext_assert_EQUAL( list2.Size(), list1.Size() )

		var first1 = list1.cBegin()
		var first2 = list2.cBegin()

		do while first1 <> list1.cEnd()
    		ext_assert_EQUAL( **(first2.PostIncrement()), **(first1.PostIncrement()) )
		loop

	end sub

	private sub testAssignToSimilarList

		var list1 = fbext_List( ((integer)) )
		list1.PushBack(1)
		list1.PushBack(2)
		list1.PushBack(3)
		list1.PushBack(4)

		var list2 = fbext_List( ((integer)) )
		list2.PushBack(5)
		list2.PushBack(6)
		list2.PushBack(7)
		list2.PushBack(8)

		list2.Assign(list1.cBegin(), list1.cEnd())

   		ext_assert_EQUAL( list2.Size(), list1.Size() )

		var first1 = list1.cBegin()
		var first2 = list2.cBegin()

		do while first1 <> list1.cEnd()
    		ext_assert_EQUAL( **(first2.PostIncrement()), **(first1.PostIncrement()) )
		loop

	end sub

	private sub testAssignToLargerList

		var list1 = fbext_List( ((integer)) )
		list1.PushBack(1)
		list1.PushBack(2)

		var list2 = fbext_List( ((integer)) )
		list2.PushBack(3)
		list2.PushBack(4)
		list2.PushBack(5)
		list2.PushBack(6)

		list2.Assign(list1.cBegin(), list1.cEnd())

   		ext_assert_EQUAL( list2.Size(), list1.Size() )

		var first1 = list1.cBegin()
		var first2 = list2.cBegin()

		do while first1 <> list1.cEnd()
    		ext_assert_EQUAL( **(first2.PostIncrement()), **(first1.PostIncrement()) )
		loop

	end sub

	private sub testAssignToSameList

		var list = fbext_List( ((integer)) )
		list.PushBack(1)
		list.PushBack(2)
		list.PushBack(3)
		list.PushBack(4)
		list.PushBack(5)
		list.PushBack(6)

   		' "move to the front"
		scope
    		var a = list.cBegin() : a.Increment()
    		var b = list.cEnd() : b.Decrement()
    		list.Assign(a, b)

       		ext_assert_EQUAL( list.Size(), 4 )

    		var first = list.cBegin()
    		var n = 2
    		do while first <> list.cEnd()
        		ext_assert_EQUAL( **(first.PostIncrement()), n )
        		n += 1
    		loop
	    end scope

   		' "truncate"
		scope
    		var a = list.cBegin()
    		var b = list.cEnd() : b.Decrement()
    		list.Assign(a, b)

       		ext_assert_EQUAL( list.Size(), 3 )

    		var first = list.cBegin()
    		var n = 2
    		do while first <> list.cEnd()
        		ext_assert_EQUAL( **(first.PostIncrement()), n )
        		n += 1
    		loop
	    end scope

	end sub

	private sub register constructor
		ext.tests.addSuite("ext-containers-list-assignrange")
		ext.tests.addTest("testAssignToEmptyList", @testAssignToEmptyList)
		ext.tests.addTest("testAssignToSmallerList", @testAssignToSmallerList)
		ext.tests.addTest("testAssignToSimilarList", @testAssignToSimilarList)
		ext.tests.addTest("testAssignToLargerList", @testAssignToLargerList)
		ext.tests.addTest("testAssignToSameList", @testAssignToSameList)
	end sub

end namespace
