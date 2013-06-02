# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/elem.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "a" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_ELEM(0, SEQ)) )
		ext_assert_TRUE( "b" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_ELEM(1, SEQ)) )
		ext_assert_TRUE( "c" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_ELEM(2, SEQ)) )
		ext_assert_TRUE( "d" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_ELEM(3, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-elem")
		ext.tests.addTest("test", @test)
	end sub

end namespace
