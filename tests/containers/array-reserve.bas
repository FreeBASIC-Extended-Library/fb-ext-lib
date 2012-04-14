# include once "ext/testly.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers.array_

	private sub testEmptyArray
	
	    var array = ext.fbext_Array( ((integer)) )
	    
	    array.Reserve(0)
	    TESTLY_ASSERT_EQUAL( 0, array.Size() )
	    TESTLY_ASSERT_EQUAL( 0, array.Capacity() )
	
	    array.Reserve(5)
	    TESTLY_ASSERT_EQUAL( 0, array.Size() )
	    TESTLY_ASSERT_EQUAL( 5, array.Capacity() )
	
	end sub
	
	private sub test_array
	
	    var array = ext.fbext_Array( ((integer)) )
	    array.PushBack(1)
	    array.PushBack(2)
	    array.PushBack(3)
	    
	    TESTLY_ASSERT_TRUE( array.Size() < array.Capacity() )
	    
	    array.Reserve(5)
	    
	    TESTLY_ASSERT_EQUAL( 3, array.Size() )
	    TESTLY_ASSERT_TRUE( 5 <= array.Capacity() )
	    
	    dim room as ext.SizeType = array.Capacity() - array.Size()
	    
	    array.Insert(array.End_(), room, 420)
	    
	    dim oldsize as ext.SizeType = array.Size()
	    TESTLY_ASSERT_EQUAL( oldsize, array.Capacity() )
	    
	    array.Reserve(10)
	
	    TESTLY_ASSERT_EQUAL( oldsize, array.Size() )
	    TESTLY_ASSERT_TRUE( 10 <= array.Capacity() )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-containers-array-reserve")
		ext.testly.addTest("testEmptyArray", @testEmptyArray)
		ext.testly.addTest("test_array", @test_array)
	end sub

end namespace
