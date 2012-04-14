# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/math/random.bi"

namespace ext.tests.math

	private sub intRndRangetest

	dim as integer xx

	for n as integer = 1 to 30

		xx = ext.math.RndRange(1,5)

		TESTLY_ASSERT_TRUE( ( xx >= 1 ) )
		TESTLY_ASSERT_TRUE( ( xx<=5 ) )

	next

	end sub

	private sub doubleRndRangetest

	dim as double xx

	for n as integer = 1 to 30

		xx = ext.math.RndRange(1.0,5.0)

		TESTLY_ASSERT_TRUE( ( xx > 0.99 ) )
		TESTLY_ASSERT_TRUE( ( xx < 6.0 ) )

	next

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-math-random-test")
		ext.testly.addTest("intRndRange", @intRndRangetest)
		ext.testly.addTest("doubleRndRange", @doubleRndRangetest)
	end sub

end namespace
