# include once "ext/testly.bi"
# include once "ext/memory/scopedptr.bi"

namespace ext.tests.memory

	private sub test
	
		' default construction..
		var sp0 = fbext_ScopedPtr((integer))
		
		TESTLY_ASSERT_TRUE( null = sp0.Get() )
		
		' construction with a pointer..
		var ip = new integer(50)
		var sp1 = fbext_ScopedPtr((integer))(ip)
		
		TESTLY_ASSERT_TRUE( ip = sp1.Get() )
		
		' copy construction..
		var sp2 = sp1
		
		TESTLY_ASSERT_TRUE( null = sp1.Get() )
		TESTLY_ASSERT_TRUE( ip = sp2.Get() )
		
		' copy assignment..
		sp2 = sp1
	
		TESTLY_ASSERT_TRUE( null = sp1.Get() )
		TESTLY_ASSERT_TRUE( null = sp2.Get() )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-memory-scopedptr")
		ext.testly.addTest("test", @test)
	end sub

end namespace
