# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/size.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( 4 = FBEXT_PP_SEQ_SIZE(SEQ) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-size")
		ext.testly.addTest("test", @test)
	end sub

end namespace
