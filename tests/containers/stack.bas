# define fbext_NoBuiltinInstanciations() 1
# include once "ext/tests.bi"

# include once "ext/containers/stack.bi"

fbext_Instanciate(fbext_Array, ((integer)))
fbext_Instanciate(fbext_Stack, ((integer)))
fbext_Instanciate(fbext_Stack, ((single)))

namespace ext.tests.containers

	private sub test_construct

		var stack = fbext_Stack( ((integer)) )
		ext_assert_TRUE( 0 = stack.Size() )

	end sub

	private sub test_construct_with_array

		var array = fbext_Array( ((single)) )
		array.PushBack(1.0)
		array.PushBack(2.0)
		array.PushBack(3.0)

		var stack = fbext_Stack( ((single)) )(array)

		ext_assert_TRUE( 3 = stack.Size() )


		var temp = *stack.Top()

		stack.Pop()
		ext_assert_TRUE( 3.0 = temp )

		temp = *stack.Top()
		stack.Pop()
		ext_assert_TRUE( 2.0 = temp )

		temp = *stack.Top()
		stack.Pop()
		ext_assert_TRUE( 1.0 = temp )

		ext_assert_TRUE( 0 = stack.Size() )

	end sub

	private sub test_push

		var stack = fbext_Stack( ((integer)) )

		stack.Push(10)
		ext_assert_TRUE( 1 = stack.Size() )
		ext_assert_TRUE( 10 = *stack.Top() )

		stack.Push(20)
		ext_assert_TRUE( 2 = stack.Size() )
		ext_assert_TRUE( 20 = *stack.Top() )

		stack.Push(30)
		ext_assert_TRUE( 3 = stack.Size() )
		ext_assert_TRUE( 30 = *stack.Top() )

	end sub

	private sub register constructor
		ext.tests.addSuite("ext-containers-stack")
		ext.tests.addTest("test_construct", @test_construct)
		ext.tests.addTest("test_construct_with_array", @test_construct_with_array)
		ext.tests.addTest("test_push", @test_push)
	end sub

end namespace
