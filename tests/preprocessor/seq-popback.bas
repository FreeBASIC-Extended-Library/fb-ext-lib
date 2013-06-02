# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/popback.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "(a)(b)(c)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_POPBACK(SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-popback")
		ext.tests.addTest("test", @test)
	end sub

end namespace
