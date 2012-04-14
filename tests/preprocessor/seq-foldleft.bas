# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/foldleft.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		# define OP(state, elem) state##elem
		
		TESTLY_ASSERT_TRUE( "xabcd" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FOLDLEFT(OP, x, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-foldleft")
		ext.testly.addTest("test", @test)
	end sub

end namespace
