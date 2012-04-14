# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/restn.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( "(a)(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_RESTN(0, SEQ)) )
		TESTLY_ASSERT_TRUE( "(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_RESTN(1, SEQ)) )
		TESTLY_ASSERT_TRUE( "(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_RESTN(2, SEQ)) )
		TESTLY_ASSERT_TRUE( "(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_RESTN(3, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-restn")
		ext.testly.addTest("test", @test)
	end sub

end namespace
