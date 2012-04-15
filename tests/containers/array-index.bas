# include once "ext/testly.bi"
# include once "ext/containers/array.bi"

namespace ext.tests.containers.array_

	private sub test
	
	    var array = ext.fbext_Array( ((integer)) )
	    
	    for i as integer = 0 to 5
	        array.PushBack(i)
	    next
	    
	    for i as integer = 0 to 5
	        TESTLY_ASSERT_EQUAL( i, *array.Index(i) )
	    next
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-containers-array-index")
		ext.testly.addTest("test", @test)
	end sub

end namespace
