# include once "ext/tests.bi"
# include once "ext/math/npr.bi"
# include once "ext/math/ncr.bi"

namespace ext.tests.math

	using ext.math
	
	private sub test_npr
	
		' 0-size set and/or subset (fail)..
		ext_assert_EQUAL(0, nPr(0, 0))
		ext_assert_EQUAL(0, nPr(1, 0))
		ext_assert_EQUAL(0, nPr(0, 1))
		
		' larger subset (fail)..
		ext_assert_EQUAL(0, nPr(1, 2))
		
		' general..
		ext_assert_EQUAL(311875200, nPr(52, 5))
		
	end sub
	
	private sub test_ncr
	
		' 0-size set and/or subset (fail)..
		ext_assert_EQUAL(0, nCr(0, 0))
		ext_assert_EQUAL(0, nCr(1, 0))
		ext_assert_EQUAL(0, nCr(0, 1))
		
		' larger subset (fail)..
		ext_assert_EQUAL(0, nCr(1, 2))
		
		' general..
		ext_assert_EQUAL(2598960, nCr(52, 5))
		
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-math-npr/ncr")
		ext.tests.addTest("test_npr", @test_npr)
		ext.tests.addTest("test_ncr", @test_ncr)
	end sub

end namespace

