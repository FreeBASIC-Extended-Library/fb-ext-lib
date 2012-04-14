# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/enum.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.tuple_.enum_

	private sub test1
	
		# define TUPLE (a)
		
		TESTLY_ASSERT_TRUE( "(a)" = FBEXT_PP_STRINGIZE((fbextPP_TupleEnum(1, TUPLE))) )
	
	end sub
	
	private sub test2
	
		# define TUPLE (a, b)
		
		TESTLY_ASSERT_TRUE( "(a, b)" = FBEXT_PP_STRINGIZE((fbextPP_TupleEnum(2, TUPLE))) )
	
	end sub
	
	private sub test3
	
		# define TUPLE (a, b, c)
		
		TESTLY_ASSERT_TRUE( "(a, b, c)" = FBEXT_PP_STRINGIZE((fbextPP_TupleEnum(3, TUPLE))) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-tuple-enum")
		ext.testly.addTest("test1", @test1)
		ext.testly.addTest("test2", @test2)
		ext.testly.addTest("test3", @test3)
	end sub

end namespace
