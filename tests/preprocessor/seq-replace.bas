# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/replace.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
        TESTLY_ASSERT_TRUE( "(x)(b)(c)(d)" = FBEXT_PP_STRINGIZE(fbextPP_SeqReplace(SEQ, 0, x)) )
        TESTLY_ASSERT_TRUE( "(a)(x)(c)(d)" = FBEXT_PP_STRINGIZE(fbextPP_SeqReplace(SEQ, 1, x)) )
        TESTLY_ASSERT_TRUE( "(a)(b)(x)(d)" = FBEXT_PP_STRINGIZE(fbextPP_SeqReplace(SEQ, 2, x)) )
        TESTLY_ASSERT_TRUE( "(a)(b)(c)(x)" = FBEXT_PP_STRINGIZE(fbextPP_SeqReplace(SEQ, 3, x)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-elem")
		ext.testly.addTest("test", @test)
	end sub

end namespace
