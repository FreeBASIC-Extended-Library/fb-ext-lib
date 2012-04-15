# include once "ext/testly.bi"
# include once "ext/algorithms/count.bi"
# include once "ext/algorithms/countif.bi"

namespace ext.tests.algorithms

	private sub test_count
		dim array(6) as integer = { 420, 20, 30, 420, 420, 50, 10 }
		
		var c = ext.Count(@array(0), @array(0) + 6, 420)
		
		TESTLY_ASSERT_TRUE( 3 = c )
		
	end sub
	
	private function LessThan30 ( byref a as integer) as bool
		return a < 30
	end function
	
	private sub test_countif
		dim array(6) as integer = { 10, 20, 30, 420, 420, 50, 10 }
		
		var c = ext.CountIf(@array(0), @array(0) + 7, @LessThan30)
		
		TESTLY_ASSERT_TRUE( 3 = c )
		
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-algorithms-count")
		ext.testly.addTest("ext_algorithms-count", @test_count)
		ext.testly.addTest("ext_algorithms-countif", @test_countif)
	end sub

end namespace
