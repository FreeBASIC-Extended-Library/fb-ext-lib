# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/pushback.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( "(a)(b)(c)(d)(x)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_PUSHBACK(SEQ, x)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-pushback")
		ext.testly.addTest("test", @test)
	end sub

end namespace
