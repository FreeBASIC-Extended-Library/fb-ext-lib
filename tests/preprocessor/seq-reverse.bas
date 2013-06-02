# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/reverse.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "(d)(c)(b)(a)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_REVERSE(SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-reverse")
		ext.tests.addTest("test", @test)
	end sub

end namespace
