# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/tuple/eat.bi"
# include once "ext/preprocessor/stringize.bi"
# include once "ext/preprocessor/cat.bi"

namespace ext.tests.preprocessor.tuple_.eat

	private sub test1
	
		# define TUPLE (a)
        
		ext_assert_TRUE( ":" = FBEXT_PP_STRINGIZE(:FBEXT_PP_CAT(fbextPP_TupleEat(1), TUPLE)))
	
	end sub
	
	private sub test2
	
		# define TUPLE (a, b)
		
		ext_assert_TRUE( ":" = FBEXT_PP_STRINGIZE(:FBEXT_PP_CAT(fbextPP_TupleEat(2), TUPLE)))
	
	end sub
	
	private sub test3
	
		# define TUPLE (a, b, c)
        
		ext_assert_TRUE( ":" = FBEXT_PP_STRINGIZE(:FBEXT_PP_CAT(fbextPP_TupleEat(3), TUPLE)))
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-tuple-eat")
		ext.tests.addTest("test1", @test1)
		ext.tests.addTest("test2", @test2)
		ext.tests.addTest("test3", @test3)
	end sub

end namespace
