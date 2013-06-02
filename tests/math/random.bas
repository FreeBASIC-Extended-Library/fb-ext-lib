# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/math/random.bi"

namespace ext.tests.math

	private sub intRndRangetest

	dim as integer xx

	for n as integer = 1 to 30

		xx = ext.math.RndRange(1,5)

		ext_assert_TRUE( ( xx >= 1 ) )
		ext_assert_TRUE( ( xx<=5 ) )

	next

	end sub

	private sub doubleRndRangetest

	dim as double xx

	for n as integer = 1 to 30

		xx = ext.math.RndRange(1.0,5.0)

		ext_assert_TRUE( ( xx > 0.99 ) )
		ext_assert_TRUE( ( xx < 6.0 ) )

	next

	end sub

	private sub register constructor
		ext.tests.addSuite("ext-math-random-test")
		ext.tests.addTest("intRndRange", @intRndRangetest)
		ext.tests.addTest("doubleRndRange", @doubleRndRangetest)
	end sub

end namespace
