# include once "ext/testly.bi"
# include once "ext/algorithms/filln.bi"

namespace ext.tests.algorithms

	private sub test_filln
		dim array(4) as integer = { 10, 20, 30, 40, 50 }
		
		ext.FillN(@array(1), 3, 420)
		
		TESTLY_ASSERT_TRUE( array(0) = 10 )
		TESTLY_ASSERT_TRUE( array(1) = 420 )
		TESTLY_ASSERT_TRUE( array(2) = 420 )
		TESTLY_ASSERT_TRUE( array(3) = 420 )
		TESTLY_ASSERT_TRUE( array(4) = 50 )
		
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-algorithms-filln")
		ext.testly.addTest("ext_algorithms-filln", @test_filln)
	end sub

end namespace
