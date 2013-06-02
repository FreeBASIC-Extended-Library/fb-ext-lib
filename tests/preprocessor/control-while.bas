# include once "ext/tests.bi"
# include once "ext/preprocessor/control/while.bi"
# include once "ext/preprocessor/comparison/notequal.bi"
# include once "ext/preprocessor/arithmetic/inc.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.control

    private sub test
    
        # define PRED(r, state) PRED_ state
        # define PRED_(value, limit) fbextPP_NotEqual(value, limit)
        
        # define OP(r, state) OP_ state
        # define OP_(value, limit) (fbextPP_Inc(value), limit)
        
        # define RESULT() RESULT_ fbextPP_While(PRED, OP, (1, 5))
        # define RESULT_(value, limit) value
        
        ext_assert_TRUE( 5 = RESULT() )
    
    end sub
    
    private sub testNoRepeat

        # define PRED(r, state) 0
        # define OP(r, state) 69
        # define RESULT() fbextPP_While(PRED, OP, 420)
        
        ext_assert_TRUE( 420 = RESULT() )
    
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-control-while")
		ext.tests.addTest("test", @test)
		ext.tests.addTest("testNoRepeat", @testNoRepeat)
	end sub

end namespace
