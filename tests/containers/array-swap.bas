# include once "ext/tests.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers.array_

	private sub test_arrayswap
	
	    var array1 = ext.fbext_Array( ((integer)) )(3, 69)
	    var array2 = ext.fbext_Array( ((integer)) )(8, 420)
	    
	    array1.Swap_(array2)
	    
	    ext_assert_EQUAL( 8, array1.Size() )
	    ext_assert_EQUAL( 3, array2.Size() )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-containers-array-swap")
		ext.tests.addTest("test_arrayswap", @test_arrayswap)
	end sub

end namespace
