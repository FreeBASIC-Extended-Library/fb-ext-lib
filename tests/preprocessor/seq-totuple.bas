# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/totuple.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( "(a, b, c, d)" = FBEXT_PP_STRINGIZE( FBEXT_PP_SEQ_TOTUPLE(SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-totuple")
		ext.testly.addTest("test", @test)
	end sub

end namespace
