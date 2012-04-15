# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/elem.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.tuple_.elem

	private sub test1
	
		# define TUPLE (a)
		
		TESTLY_ASSERT_TRUE( "a" = FBEXT_PP_STRINGIZE(fbextPP_TupleElem(1, 0, TUPLE)) )
	
	end sub
	
	private sub test2
	
		# define TUPLE (a, b)
		
		TESTLY_ASSERT_TRUE( "a" = FBEXT_PP_STRINGIZE(fbextPP_TupleElem(2, 0, TUPLE)) )
		TESTLY_ASSERT_TRUE( "b" = FBEXT_PP_STRINGIZE(fbextPP_TupleElem(2, 1, TUPLE)) )
	
	end sub
	
	private sub test3
	
		# define TUPLE (a, b, c)
		
		TESTLY_ASSERT_TRUE( "a" = FBEXT_PP_STRINGIZE(fbextPP_TupleElem(3, 0, TUPLE)) )
		TESTLY_ASSERT_TRUE( "b" = FBEXT_PP_STRINGIZE(fbextPP_TupleElem(3, 1, TUPLE)) )
		TESTLY_ASSERT_TRUE( "c" = FBEXT_PP_STRINGIZE(fbextPP_TupleElem(3, 2, TUPLE)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-tuple-elem")
		ext.testly.addTest("test1", @test1)
		ext.testly.addTest("test2", @test2)
		ext.testly.addTest("test3", @test3)
	end sub

end namespace
