# include once "ext/testly.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers.array_

	private sub testDefaultCtor
	
	    var array = fbext_Array( ((integer)) )
	    
	    TESTLY_ASSERT_EQUAL( 0, array.Size() )
	    TESTLY_ASSERT_EQUAL( 0, array.Capacity() )
	    TESTLY_ASSERT_EQUAL( ext.true, array.Empty() )
	
	end sub
	
	private sub testRangedCtor
	
	    dim elems(0 to 2) as const integer = { 10, 20, 30 }
	    
	    var first = @elems(0)
	    var last = first + 3
	    
	    var array = fbext_Array( ((integer)) )(first, last)
	    
	    for i as ext.SizeType = 0 to 2
	        TESTLY_ASSERT_EQUAL( *array.cIndex(i), elems(i) )
	    next
	
	end sub
	
	private sub testRepeatCtor
	
	    dim count as const ext.SizeType = 5
	    dim value as const integer = 420
	    var array = fbext_Array( ((integer)) )(count, value)
	
	    TESTLY_ASSERT_EQUAL( count, array.Size() )
	    
	    for i as integer = 0 to count-1
    	    TESTLY_ASSERT_EQUAL( 420, *array.cIndex(i) )
	    next
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-containers-array-ctor")
		ext.testly.addTest("testDefaultCtor", @testDefaultCtor)
		ext.testly.addTest("testRangedCtor", @testRangedCtor)
		ext.testly.addTest("testRepeatCtor", @testRepeatCtor)
	end sub

end namespace
