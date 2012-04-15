# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/insert.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( "(x)(a)(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_INSERT(SEQ, 0, x)) )
		TESTLY_ASSERT_TRUE( "(a)(x)(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_INSERT(SEQ, 1, x)) )
		TESTLY_ASSERT_TRUE( "(a)(b)(x)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_INSERT(SEQ, 2, x)) )
		TESTLY_ASSERT_TRUE( "(a)(b)(c)(x)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_INSERT(SEQ, 3, x)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-insert")
		ext.testly.addTest("test", @test)
	end sub

end namespace
