# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/pushfront.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "(x)(a)(b)(c)(d)" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_PUSHFRONT(SEQ, x)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-pushfront")
		ext.tests.addTest("test", @test)
	end sub

end namespace
