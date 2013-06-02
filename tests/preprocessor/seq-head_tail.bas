# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/head.bi"
# include once "ext/preprocessor/seq/tail.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test_head
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "a" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_HEAD(SEQ)) )
	
	end sub
	
	private sub test_tail
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_TAIL(SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-head_tail")
		ext.tests.addTest("test_head", @test_head)
		ext.tests.addTest("test_tail", @test_tail)
	end sub

end namespace
