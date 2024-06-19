# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/foldright.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ ((a)(b)(c)(d))
		# define OP(state, elem) state##elem
		
		ext_assert_STRING_EQUAL( "xdcba", FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FOLDRIGHT(OP, x, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-foldright")
		ext.tests.addTest("test", @test)
	end sub

end namespace
