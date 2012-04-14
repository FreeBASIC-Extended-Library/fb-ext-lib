# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/math/pow2.bi"

namespace ext.tests.math

	private sub ispow2test
	
	dim as ulongint n 
	n = cast(ulongint, 2)
	while n < 2^32
		TESTLY_ASSERT_TRUE( ext.math.ispow2(n) )
		'print ext.math.ispow2(n) & ":" & n
		n^=2
	wend

	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-math-pow2-test")
		ext.testly.addTest("ispow2test", @ispow2test)
	end sub

end namespace
