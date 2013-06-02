# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/seq/foreachi.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor

	private sub test
	
		# define SEQ (a)(b)(c)(d)
		# define M(data, i, elem) data##i##elem
		
		ext_assert_TRUE( "x0a x1b x2c x3d" = FBEXT_PP_STRINGIZE(FBEXT_PP_SEQ_FOREACHI(M, x, SEQ)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-foreachi")
		ext.tests.addTest("test", @test)
	end sub

end namespace
