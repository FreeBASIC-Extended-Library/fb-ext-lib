# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/restn.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "(a)(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_RESTN(0, SEQ)) )
		ext_assert_TRUE( "(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_RESTN(1, SEQ)) )
		ext_assert_TRUE( "(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_RESTN(2, SEQ)) )
		ext_assert_TRUE( "(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_RESTN(3, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-restn")
		ext.tests.addTest("test", @test)
	end sub

end namespace
