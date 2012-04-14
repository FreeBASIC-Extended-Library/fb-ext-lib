# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/replace.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.tuple_.replace

	private sub test1
	
		# define TUPLE (a)
		
		TESTLY_ASSERT_TRUE( "(x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleReplace(1, 0, TUPLE, x)) )
	
	end sub
	
	private sub test2
	
		# define TUPLE (a, b)
		
		TESTLY_ASSERT_TRUE( "(x, b)" = FBEXT_PP_STRINGIZE(fbextPP_TupleReplace(2, 0, TUPLE, x)) )
		TESTLY_ASSERT_TRUE( "(a, x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleReplace(2, 1, TUPLE, x)) )
	
	end sub
	
	private sub test3
	
		# define TUPLE (a, b, c)
		
		TESTLY_ASSERT_TRUE( "(x, b, c)" = FBEXT_PP_STRINGIZE(fbextPP_TupleReplace(3, 0, TUPLE, x)) )
		TESTLY_ASSERT_TRUE( "(a, x, c)" = FBEXT_PP_STRINGIZE(fbextPP_TupleReplace(3, 1, TUPLE, x)) )
		TESTLY_ASSERT_TRUE( "(a, b, x)" = FBEXT_PP_STRINGIZE(fbextPP_TupleReplace(3, 2, TUPLE, x)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-tuple-replace")
		ext.testly.addTest("test1", @test1)
		ext.testly.addTest("test2", @test2)
		ext.testly.addTest("test3", @test3)
	end sub

end namespace
