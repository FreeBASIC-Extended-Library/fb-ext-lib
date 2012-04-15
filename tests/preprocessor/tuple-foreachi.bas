# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/foreachi.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.tuple_.foreachi

# define M(n, elem) [elem##n]

	private sub test1
	
		# define TUPLE (a)
		
		TESTLY_ASSERT_TRUE( "[a0]" = FBEXT_PP_STRINGIZE(fbextPP_TupleForEachI(1, TUPLE, M)) )
	
	end sub
	
	private sub test2
	
		# define TUPLE (a, b)
		
		TESTLY_ASSERT_TRUE( "[a0] [b1]" = FBEXT_PP_STRINGIZE(fbextPP_TupleForEachI(2, TUPLE, M)) )
	
	end sub
	
	private sub test3
	
		# define TUPLE (a, b, c)
		
		TESTLY_ASSERT_TRUE( "[a0] [b1] [c2]" = FBEXT_PP_STRINGIZE(fbextPP_TupleForEachI(3, TUPLE, M)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-tuple-foreachi")
		ext.testly.addTest("test1", @test1)
		ext.testly.addTest("test2", @test2)
		ext.testly.addTest("test3", @test3)
	end sub

end namespace
