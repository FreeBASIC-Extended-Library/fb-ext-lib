# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/fromvalue.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.tuple_.fromvalue

	private sub test
	
		TESTLY_ASSERT_TRUE( "(x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleFromValue(1, x)) )
		TESTLY_ASSERT_TRUE( "(x,x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleFromValue(2, x)) )
		TESTLY_ASSERT_TRUE( "(x,x,x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleFromValue(3, x)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-tuple-fromvalue")
		ext.testly.addTest("test", @test)
	end sub

end namespace
