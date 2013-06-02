# define fbext_NoBuiltinInstanciations() 1
# include once "ext/tests.bi"
# include once "ext/containers/queue.bi"

fbext_Instanciate(fbext_List, ((integer)))
fbext_Instanciate(fbext_Queue, ((integer)))
fbext_Instanciate(fbext_Queue, ((single)))

namespace ext.tests.containers

	private sub test_construct

		var queue = fbext_Queue( ((integer)) )
		ext_assert_TRUE( 0 = queue.Size() )

	end sub

	private sub test_construct_with_list

		var list = fbext_List( ((single)) )
		list.PushBack(1.0)
		list.PushBack(2.0)
		list.PushBack(3.0)

		var queue = fbext_Queue( ((single)) )(list)

		ext_assert_TRUE( 3 = queue.Size() )

		ext_assert_TRUE( 1.0 = *queue.Front() )
		queue.Pop()
		ext_assert_TRUE( 2.0 = *queue.Front() )
		queue.Pop()
		ext_assert_TRUE( 3.0 = *queue.Front() )
		queue.Pop()

		ext_assert_TRUE( 0 = queue.Size() )

	end sub

	private sub test_push

		var queue = fbext_Queue( ((integer)) )

		queue.Push(10)
		ext_assert_TRUE( 1 = queue.Size() )
		ext_assert_TRUE( 10 = *queue.Front() )
		ext_assert_TRUE( 10 = *queue.Back() )

		queue.Push(20)
		ext_assert_TRUE( 2 = queue.Size() )
		ext_assert_TRUE( 10 = *queue.Front() )
		ext_assert_TRUE( 20 = *queue.Back() )

		queue.Push(30)
		ext_assert_TRUE( 3 = queue.Size() )
		ext_assert_TRUE( 10 = *queue.Front() )
		ext_assert_TRUE( 30 = *queue.Back() )

	end sub

	private sub register constructor
		ext.tests.addSuite("ext-containers-queue")
		ext.tests.addTest("test_construct", @test_construct)
		ext.tests.addTest("test_construct_with_list", @test_construct_with_list)
		ext.tests.addTest("test_push", @test_push)
	end sub

end namespace
