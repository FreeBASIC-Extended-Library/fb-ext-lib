# include once "ext/testly.bi"
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
        
        TESTLY_ASSERT_TRUE( 5 = RESULT() )
    
    end sub
    
    private sub testNoRepeat

        # define PRED(r, state) 0
        # define OP(r, state) 69
        # define RESULT() fbextPP_While(PRED, OP, 420)
        
        TESTLY_ASSERT_TRUE( 420 = RESULT() )
    
    end sub
    
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-control-while")
		ext.testly.addTest("test", @test)
		ext.testly.addTest("testNoRepeat", @testNoRepeat)
	end sub

end namespace
