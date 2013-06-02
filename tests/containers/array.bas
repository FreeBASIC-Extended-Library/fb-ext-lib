# include once "ext/tests.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers

	private sub test_pushback
	
		var array = fbext_Array( ((integer)) )
		
		array.PushBack(10)
		ext_assert_TRUE( 1 = array.Size() )
		ext_assert_TRUE( 10 = *array.Front() )
		ext_assert_TRUE( 10 = *array.Back() )
		
		array.PushBack(20)
		ext_assert_TRUE( 2 = array.Size() )
		ext_assert_TRUE( 10 = *array.Front() )
		ext_assert_TRUE( 20 = *array.Back() )
	
		array.PushBack(30)
		ext_assert_TRUE( 3 = array.Size() )
		ext_assert_TRUE( 10 = *array.Front() )
		ext_assert_TRUE( 30 = *array.Back() )
	
	end sub
	
	private sub test_insert
	
		var array = fbext_Array( ((integer)) )
		
		array.Insert(array.End_(), 5, 420)
		ext_assert_TRUE( 5 = array.Size() )
	
	end sub

	private sub register constructor
		ext.tests.addSuite("ext-containers-array")
		ext.tests.addTest("test_pushback", @test_pushback)
		ext.tests.addTest("test_insert", @test_insert)
	end sub

end namespace
