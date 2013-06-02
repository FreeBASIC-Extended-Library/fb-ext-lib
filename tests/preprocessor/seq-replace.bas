# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/replace.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
        ext_assert_TRUE( "(x)(b)(c)(d)" = FBEXT_PP_STRINGIZE(fbextPP_SeqReplace(SEQ, 0, x)) )
        ext_assert_TRUE( "(a)(x)(c)(d)" = FBEXT_PP_STRINGIZE(fbextPP_SeqReplace(SEQ, 1, x)) )
        ext_assert_TRUE( "(a)(b)(x)(d)" = FBEXT_PP_STRINGIZE(fbextPP_SeqReplace(SEQ, 2, x)) )
        ext_assert_TRUE( "(a)(b)(c)(x)" = FBEXT_PP_STRINGIZE(fbextPP_SeqReplace(SEQ, 3, x)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-elem")
		ext.tests.addTest("test", @test)
	end sub

end namespace
