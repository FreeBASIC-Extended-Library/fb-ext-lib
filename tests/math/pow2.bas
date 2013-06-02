# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/math/pow2.bi"

namespace ext.tests.math

	private sub ispow2test
	
	dim as ulongint n 
	n = cast(ulongint, 2)
	while n < 2^32
		ext_assert_TRUE( ext.math.ispow2(n) )
		'print ext.math.ispow2(n) & ":" & n
		n^=2
	wend

	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-math-pow2-test")
		ext.tests.addTest("ispow2test", @ispow2test)
	end sub

end namespace
