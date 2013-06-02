# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/foreach.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		# define M(data, elem) data##elem
		
		ext_assert_TRUE( "xa xb xc xd" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FOREACH(M, x, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-foreach")
		ext.tests.addTest("test", @test)
	end sub

end namespace
