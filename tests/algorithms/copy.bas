# include once "ext/tests.bi"
# include once "ext/algorithms/copy.bi"

namespace ext.tests.algorithms

	private sub test_copy
		dim array(4) as integer = { 10, 20, 30, 40, 50 }
		dim result(4) as integer = any
		
		ext.Copy(@array(0), @array(0) + 5, @result(0))
		
		ext_assert_TRUE( result(0) = 10 )
		ext_assert_TRUE( result(1) = 20 )
		ext_assert_TRUE( result(2) = 30 )
		ext_assert_TRUE( result(3) = 40 )
		ext_assert_TRUE( result(4) = 50 )
		
	end sub
	
	private sub test_copy_overlap
	
		dim array(4) as integer = { 10, 20, 30, 40, 50 }
		
		ext.Copy(@array(2), @array(2) + 3, @array(0))
		
		ext_assert_TRUE( array(0) = 30 )
		ext_assert_TRUE( array(1) = 40 )
		ext_assert_TRUE( array(2) = 50 )
		ext_assert_TRUE( array(3) = 40 )
		ext_assert_TRUE( array(4) = 50 )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-algorithms-copy")
		ext.tests.addTest("copy_overlap", @test_copy_overlap)
		ext.tests.addTest("copy",@test_copy)
	end sub

end namespace
