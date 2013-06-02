# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/insert.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "(x)(a)(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_INSERT(SEQ, 0, x)) )
		ext_assert_TRUE( "(a)(x)(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_INSERT(SEQ, 1, x)) )
		ext_assert_TRUE( "(a)(b)(x)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_INSERT(SEQ, 2, x)) )
		ext_assert_TRUE( "(a)(b)(c)(x)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_INSERT(SEQ, 3, x)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-insert")
		ext.tests.addTest("test", @test)
	end sub

end namespace
