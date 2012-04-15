# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/firstn.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( "(a)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FIRSTN(1, SEQ)) )
		TESTLY_ASSERT_TRUE( "(a)(b)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FIRSTN(2, SEQ)) )
		TESTLY_ASSERT_TRUE( "(a)(b)(c)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FIRSTN(3, SEQ)) )
		TESTLY_ASSERT_TRUE( "(a)(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FIRSTN(4, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-firstn")
		ext.testly.addTest("test", @test)
	end sub

end namespace
