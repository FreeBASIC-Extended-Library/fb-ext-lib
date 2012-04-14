# define fbext_NoBuiltinInstanciations() 1
# include once "ext/testly.bi"
# include once "ext/containers/queue.bi"

fbext_Instanciate(fbext_List, ((integer)))
fbext_Instanciate(fbext_Queue, ((integer)))
fbext_Instanciate(fbext_Queue, ((single)))

namespace ext.tests.containers

	private sub test_construct

		var queue = fbext_Queue( ((integer)) )
		TESTLY_ASSERT_TRUE( 0 = queue.Size() )

	end sub

	private sub test_construct_with_list

		var list = fbext_List( ((single)) )
		list.PushBack(1.0)
		list.PushBack(2.0)
		list.PushBack(3.0)

		var queue = fbext_Queue( ((single)) )(list)

		TESTLY_ASSERT_TRUE( 3 = queue.Size() )

		TESTLY_ASSERT_TRUE( 1.0 = *queue.Front() )
		queue.Pop()
		TESTLY_ASSERT_TRUE( 2.0 = *queue.Front() )
		queue.Pop()
		TESTLY_ASSERT_TRUE( 3.0 = *queue.Front() )
		queue.Pop()

		TESTLY_ASSERT_TRUE( 0 = queue.Size() )

	end sub

	private sub test_push

		var queue = fbext_Queue( ((integer)) )

		queue.Push(10)
		TESTLY_ASSERT_TRUE( 1 = queue.Size() )
		TESTLY_ASSERT_TRUE( 10 = *queue.Front() )
		TESTLY_ASSERT_TRUE( 10 = *queue.Back() )

		queue.Push(20)
		TESTLY_ASSERT_TRUE( 2 = queue.Size() )
		TESTLY_ASSERT_TRUE( 10 = *queue.Front() )
		TESTLY_ASSERT_TRUE( 20 = *queue.Back() )

		queue.Push(30)
		TESTLY_ASSERT_TRUE( 3 = queue.Size() )
		TESTLY_ASSERT_TRUE( 10 = *queue.Front() )
		TESTLY_ASSERT_TRUE( 30 = *queue.Back() )

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-queue")
		ext.testly.addTest("test_construct", @test_construct)
		ext.testly.addTest("test_construct_with_list", @test_construct_with_list)
		ext.testly.addTest("test_push", @test_push)
	end sub

end namespace
