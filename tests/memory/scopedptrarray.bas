# include once "ext/tests.bi"
# include once "ext/memory/scopedptrarray.bi"

namespace ext.tests.memory

	private sub test
	
		' default construction..
		var sp0 = fbext_ScopedPtrArray((integer))
		
		ext_assert_TRUE( null = sp0.Get() )
		
		' construction with a pointer..
		var ip = new integer[10]
		var sp1 = fbext_ScopedPtrArray((integer))(ip)
		
		ext_assert_TRUE( ip = sp1.Get() )
		
		' copy construction..
		var sp2 = sp1
		
		ext_assert_TRUE( null = sp1.Get() )
		ext_assert_TRUE( ip = sp2.Get() )
		
		' copy assignment..
		sp2 = sp1
	
		ext_assert_TRUE( null = sp1.Get() )
		ext_assert_TRUE( null = sp2.Get() )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-memory-scopedarray")
		ext.tests.addTest("test", @test)
	end sub

end namespace
