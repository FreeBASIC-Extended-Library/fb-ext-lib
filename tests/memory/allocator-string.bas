# include once "ext/tests.bi"
# include once "ext/memory/allocator.bi"

namespace ext.tests.memory

	private sub test
	
	    var alloc = ext.fbext_Allocator( ((string)) )
	    
	    var p = alloc.Allocate(1)
	    alloc.Construct(p, "text")
	    
	    ext_assert_STRING_EQUAL( "text", *p )
	    
	    alloc.DeAllocate(p, 1)
	    
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-memory-allocator-string")
		ext.tests.addTest("test", @test)
	end sub

end namespace
