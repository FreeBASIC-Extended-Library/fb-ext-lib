# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/fromvalue.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.seq.fromvalue

	private sub test
	
		TESTLY_ASSERT_TRUE( "(x)" = FBEXT_PP_STRINGIZE(fbextPP_SeqFromValue(1, x)) )
		TESTLY_ASSERT_TRUE( "(x)(x)" = FBEXT_PP_STRINGIZE(fbextPP_SeqFromValue(2, x)) )
		TESTLY_ASSERT_TRUE( "(x)(x)(x)" = FBEXT_PP_STRINGIZE(fbextPP_SeqFromValue(3, x)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-fromvalue")
		ext.testly.addTest("test", @test)
	end sub

end namespace
