# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/fromvalue.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.seq.fromvalue

	private sub test
	
		ext_assert_TRUE( "(x)" = FBEXT_PP_STRINGIZE(fbextPP_SeqFromValue(1, x)) )
		ext_assert_TRUE( "(x)(x)" = FBEXT_PP_STRINGIZE(fbextPP_SeqFromValue(2, x)) )
		ext_assert_TRUE( "(x)(x)(x)" = FBEXT_PP_STRINGIZE(fbextPP_SeqFromValue(3, x)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-fromvalue")
		ext.tests.addTest("test", @test)
	end sub

end namespace
