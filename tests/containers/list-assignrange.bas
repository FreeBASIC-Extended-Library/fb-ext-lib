# define fbext_NoBuiltinInstanciations() 1
# include once "ext/testly.bi"

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

   		TESTLY_ASSERT_EQUAL( list2.Size(), list1.Size() )

		var first1 = list1.cBegin()
		var first2 = list2.cBegin()

		do while first1 <> list1.cEnd()
    		TESTLY_ASSERT_EQUAL( **(first2.PostIncrement()), **(first1.PostIncrement()) )
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

   		TESTLY_ASSERT_EQUAL( list2.Size(), list1.Size() )

		var first1 = list1.cBegin()
		var first2 = list2.cBegin()

		do while first1 <> list1.cEnd()
    		TESTLY_ASSERT_EQUAL( **(first2.PostIncrement()), **(first1.PostIncrement()) )
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

   		TESTLY_ASSERT_EQUAL( list2.Size(), list1.Size() )

		var first1 = list1.cBegin()
		var first2 = list2.cBegin()

		do while first1 <> list1.cEnd()
    		TESTLY_ASSERT_EQUAL( **(first2.PostIncrement()), **(first1.PostIncrement()) )
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

   		TESTLY_ASSERT_EQUAL( list2.Size(), list1.Size() )

		var first1 = list1.cBegin()
		var first2 = list2.cBegin()

		do while first1 <> list1.cEnd()
    		TESTLY_ASSERT_EQUAL( **(first2.PostIncrement()), **(first1.PostIncrement()) )
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

       		TESTLY_ASSERT_EQUAL( list.Size(), 4 )

    		var first = list.cBegin()
    		var n = 2
    		do while first <> list.cEnd()
        		TESTLY_ASSERT_EQUAL( **(first.PostIncrement()), n )
        		n += 1
    		loop
	    end scope

   		' "truncate"
		scope
    		var a = list.cBegin()
    		var b = list.cEnd() : b.Decrement()
    		list.Assign(a, b)

       		TESTLY_ASSERT_EQUAL( list.Size(), 3 )

    		var first = list.cBegin()
    		var n = 2
    		do while first <> list.cEnd()
        		TESTLY_ASSERT_EQUAL( **(first.PostIncrement()), n )
        		n += 1
    		loop
	    end scope

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-list-assignrange")
		ext.testly.addTest("testAssignToEmptyList", @testAssignToEmptyList)
		ext.testly.addTest("testAssignToSmallerList", @testAssignToSmallerList)
		ext.testly.addTest("testAssignToSimilarList", @testAssignToSimilarList)
		ext.testly.addTest("testAssignToLargerList", @testAssignToLargerList)
		ext.testly.addTest("testAssignToSameList", @testAssignToSameList)
	end sub

end namespace
