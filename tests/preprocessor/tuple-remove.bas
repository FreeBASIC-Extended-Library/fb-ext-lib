# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/remove.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.tuple_.remove

	private sub test1
	
		# define TUPLE (a)
		
		TESTLY_ASSERT_TRUE( "()" = FBEXT_PP_STRINGIZE(fbextPP_TupleRemove(1, 0, TUPLE)) )
	
	end sub
	
	private sub test2
	
		# define TUPLE (a, b)
		
		TESTLY_ASSERT_TRUE( "(b)" = FBEXT_PP_STRINGIZE(fbextPP_TupleRemove(2, 0, TUPLE)) )
		TESTLY_ASSERT_TRUE( "(a)" = FBEXT_PP_STRINGIZE(fbextPP_TupleRemove(2, 1, TUPLE)) )
	
	end sub
	
	private sub test3
	
		# define TUPLE (a, b, c)
		
		TESTLY_ASSERT_TRUE( "(b, c)" = FBEXT_PP_STRINGIZE(fbextPP_TupleRemove(3, 0, TUPLE)) )
		TESTLY_ASSERT_TRUE( "(a, c)" = FBEXT_PP_STRINGIZE(fbextPP_TupleRemove(3, 1, TUPLE)) )
		TESTLY_ASSERT_TRUE( "(a, b)" = FBEXT_PP_STRINGIZE(fbextPP_TupleRemove(3, 2, TUPLE)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-tuple-remove")
		ext.testly.addTest("test1", @test1)
		ext.testly.addTest("test2", @test2)
		ext.testly.addTest("test3", @test3)
	end sub

end namespace
