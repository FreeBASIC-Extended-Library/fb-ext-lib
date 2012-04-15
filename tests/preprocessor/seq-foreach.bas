# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/foreach.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		# define M(data, elem) data##elem
		
		TESTLY_ASSERT_TRUE( "xa xb xc xd" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FOREACH(M, x, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-foreach")
		ext.testly.addTest("test", @test)
	end sub

end namespace
