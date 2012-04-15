# include once "ext/testly.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers

	private sub test_pushback
	
		var array = fbext_Array( ((integer)) )
		
		array.PushBack(10)
		TESTLY_ASSERT_TRUE( 1 = array.Size() )
		TESTLY_ASSERT_TRUE( 10 = *array.Front() )
		TESTLY_ASSERT_TRUE( 10 = *array.Back() )
		
		array.PushBack(20)
		TESTLY_ASSERT_TRUE( 2 = array.Size() )
		TESTLY_ASSERT_TRUE( 10 = *array.Front() )
		TESTLY_ASSERT_TRUE( 20 = *array.Back() )
	
		array.PushBack(30)
		TESTLY_ASSERT_TRUE( 3 = array.Size() )
		TESTLY_ASSERT_TRUE( 10 = *array.Front() )
		TESTLY_ASSERT_TRUE( 30 = *array.Back() )
	
	end sub
	
	private sub test_insert
	
		var array = fbext_Array( ((integer)) )
		
		array.Insert(array.End_(), 5, 420)
		TESTLY_ASSERT_TRUE( 5 = array.Size() )
	
	end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-array")
		ext.testly.addTest("test_pushback", @test_pushback)
		ext.testly.addTest("test_insert", @test_insert)
	end sub

end namespace
