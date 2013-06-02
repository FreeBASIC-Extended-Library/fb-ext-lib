# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/foreachi.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.tuple_.foreachi

# define M(n, elem) [elem##n]

	private sub test1
	
		# define TUPLE (a)
		
		ext_assert_TRUE( "[a0]" = FBEXT_PP_STRINGIZE(fbextPP_TupleForEachI(1, TUPLE, M)) )
	
	end sub
	
	private sub test2
	
		# define TUPLE (a, b)
		
		ext_assert_TRUE( "[a0] [b1]" = FBEXT_PP_STRINGIZE(fbextPP_TupleForEachI(2, TUPLE, M)) )
	
	end sub
	
	private sub test3
	
		# define TUPLE (a, b, c)
		
		ext_assert_TRUE( "[a0] [b1] [c2]" = FBEXT_PP_STRINGIZE(fbextPP_TupleForEachI(3, TUPLE, M)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-tuple-foreachi")
		ext.tests.addTest("test1", @test1)
		ext.tests.addTest("test2", @test2)
		ext.tests.addTest("test3", @test3)
	end sub

end namespace
