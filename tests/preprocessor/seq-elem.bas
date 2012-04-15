# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/elem.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( "a" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_ELEM(0, SEQ)) )
		TESTLY_ASSERT_TRUE( "b" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_ELEM(1, SEQ)) )
		TESTLY_ASSERT_TRUE( "c" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_ELEM(2, SEQ)) )
		TESTLY_ASSERT_TRUE( "d" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_ELEM(3, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-elem")
		ext.testly.addTest("test", @test)
	end sub

end namespace
