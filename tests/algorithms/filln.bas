# include once "ext/tests.bi"
# include once "ext/algorithms/filln.bi"

namespace ext.tests.algorithms

	private sub test_filln
		dim array(4) as integer = { 10, 20, 30, 40, 50 }
		
		ext.FillN(@array(1), 3, 420)
		
		ext_assert_TRUE( array(0) = 10 )
		ext_assert_TRUE( array(1) = 420 )
		ext_assert_TRUE( array(2) = 420 )
		ext_assert_TRUE( array(3) = 420 )
		ext_assert_TRUE( array(4) = 50 )
		
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-algorithms-filln")
		ext.tests.addTest("ext_algorithms-filln", @test_filln)
	end sub

end namespace
