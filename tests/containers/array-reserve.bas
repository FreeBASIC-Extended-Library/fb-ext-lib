# include once "ext/tests.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers.array_

	private sub testEmptyArray
	
	    var array = ext.fbext_Array( ((integer)) )
	    
	    array.Reserve(0)
	    ext_assert_EQUAL( 0, array.Size() )
	    ext_assert_EQUAL( 0, array.Capacity() )
	
	    array.Reserve(5)
	    ext_assert_EQUAL( 0, array.Size() )
	    ext_assert_EQUAL( 5, array.Capacity() )
	
	end sub
	
	private sub test_array
	
	    var array = ext.fbext_Array( ((integer)) )
	    array.PushBack(1)
	    array.PushBack(2)
	    array.PushBack(3)
	    
	    ext_assert_TRUE( array.Size() < array.Capacity() )
	    
	    array.Reserve(5)
	    
	    ext_assert_EQUAL( 3, array.Size() )
	    ext_assert_TRUE( 5 <= array.Capacity() )
	    
	    dim room as ext.SizeType = array.Capacity() - array.Size()
	    
	    array.Insert(array.End_(), room, 420)
	    
	    dim oldsize as ext.SizeType = array.Size()
	    ext_assert_EQUAL( oldsize, array.Capacity() )
	    
	    array.Reserve(10)
	
	    ext_assert_EQUAL( oldsize, array.Size() )
	    ext_assert_TRUE( 10 <= array.Capacity() )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-containers-array-reserve")
		ext.tests.addTest("testEmptyArray", @testEmptyArray)
		ext.tests.addTest("test_array", @test_array)
	end sub

end namespace
