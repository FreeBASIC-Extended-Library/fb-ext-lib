# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/fromvalue.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.tuple_.fromvalue

	private sub test
	
		ext_assert_TRUE( "(x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleFromValue(1, x)) )
		ext_assert_TRUE( "(x,x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleFromValue(2, x)) )
		ext_assert_TRUE( "(x,x,x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleFromValue(3, x)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-tuple-fromvalue")
		ext.tests.addTest("test", @test)
	end sub

end namespace
