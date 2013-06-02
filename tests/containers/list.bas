# define fbext_NoBuiltinInstanciations() 1
# include once "ext/tests.bi"

# include once "ext/containers/list.bi"

fbext_Instanciate(fbext_List, ((integer)))

namespace ext.tests.containers

	private sub test_pushback

		var list = fbext_List( ((integer)) )

		list.PushBack(10)
		ext_assert_TRUE( 1 = list.Size() )
		ext_assert_TRUE( 10 = *list.Front() )
		ext_assert_TRUE( 10 = *list.Back() )

		list.PushBack(20)
		ext_assert_TRUE( 2 = list.Size() )
		ext_assert_TRUE( 10 = *list.Front() )
		ext_assert_TRUE( 20 = *list.Back() )

		list.PushBack(30)
		ext_assert_TRUE( 3 = list.Size() )
		ext_assert_TRUE( 10 = *list.Front() )
		ext_assert_TRUE( 30 = *list.Back() )

	end sub

	private sub test_insert

		var list = fbext_List( ((integer)) )

		list.Insert(list.End_(), 5, 420)
		ext_assert_TRUE( 5 = list.Size() )

	end sub

	private sub register constructor
		ext.tests.addSuite("ext-containers-list")
		ext.tests.addTest("test_pushback", @test_pushback)
		ext.tests.addTest("test_insert", @test_insert)
	end sub

end namespace
