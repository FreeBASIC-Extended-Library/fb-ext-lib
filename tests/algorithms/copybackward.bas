# include once "ext/testly.bi"
# include once "ext/algorithms/copybackward.bi"

namespace ext.tests.algorithms

	private sub test_copybackward
		dim array(4) as integer = { 10, 20, 30, 40, 50 }
		dim result(4) as integer = any
		
		ext.CopyBackward(@array(0), @array(0) + 5, @result(0) + 5)
		
		TESTLY_ASSERT_TRUE( result(0) = 10 )
		TESTLY_ASSERT_TRUE( result(1) = 20 )
		TESTLY_ASSERT_TRUE( result(2) = 30 )
		TESTLY_ASSERT_TRUE( result(3) = 40 )
		TESTLY_ASSERT_TRUE( result(4) = 50 )
		
	end sub
	
	private sub test_copybackward_overlap
	
		dim array(4) as integer = { 10, 20, 30, 40, 50 }
		
		ext.CopyBackward(@array(2), @array(2) + 3, @array(0))
		
		TESTLY_ASSERT_TRUE( array(0) = 30 )
		TESTLY_ASSERT_TRUE( array(1) = 40 )
		TESTLY_ASSERT_TRUE( array(2) = 50 )
		TESTLY_ASSERT_TRUE( array(3) = 40 )
		TESTLY_ASSERT_TRUE( array(4) = 50 )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-algorithms-copy")
		ext.testly.addTest("join", @test_copybackward)
		ext.testly.addTest("join", @test_copybackward_overlap)
	end sub

end namespace
