# define fbext_NoBuiltinInstanciations() 1
# include once "ext/testly.bi"

# include once "ext/containers/stack.bi"

fbext_Instanciate(fbext_Array, ((integer)))
fbext_Instanciate(fbext_Stack, ((integer)))
fbext_Instanciate(fbext_Stack, ((single)))

namespace ext.tests.containers

	private sub test_construct

		var stack = fbext_Stack( ((integer)) )
		TESTLY_ASSERT_TRUE( 0 = stack.Size() )

	end sub

	private sub test_construct_with_array

		var array = fbext_Array( ((single)) )
		array.PushBack(1.0)
		array.PushBack(2.0)
		array.PushBack(3.0)

		var stack = fbext_Stack( ((single)) )(array)

		TESTLY_ASSERT_TRUE( 3 = stack.Size() )


		var temp = *stack.Top()

		stack.Pop()
		TESTLY_ASSERT_TRUE( 3.0 = temp )

		temp = *stack.Top()
		stack.Pop()
		TESTLY_ASSERT_TRUE( 2.0 = temp )

		temp = *stack.Top()
		stack.Pop()
		TESTLY_ASSERT_TRUE( 1.0 = temp )

		TESTLY_ASSERT_TRUE( 0 = stack.Size() )

	end sub

	private sub test_push

		var stack = fbext_Stack( ((integer)) )

		stack.Push(10)
		TESTLY_ASSERT_TRUE( 1 = stack.Size() )
		TESTLY_ASSERT_TRUE( 10 = *stack.Top() )

		stack.Push(20)
		TESTLY_ASSERT_TRUE( 2 = stack.Size() )
		TESTLY_ASSERT_TRUE( 20 = *stack.Top() )

		stack.Push(30)
		TESTLY_ASSERT_TRUE( 3 = stack.Size() )
		TESTLY_ASSERT_TRUE( 30 = *stack.Top() )

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-stack")
		ext.testly.addTest("test_construct", @test_construct)
		ext.testly.addTest("test_construct_with_array", @test_construct_with_array)
		ext.testly.addTest("test_push", @test_push)
	end sub

end namespace
