# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/preprocessor/repetition/for.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.repetition.for_

	private sub test
    
        # define PRED(r, state) fbextPP_LessThan(state, 4)
        # define OP(r, state) fbextPP_Inc(state)
        # define M(r, state) [state]
        
        TESTLY_ASSERT_TRUE( "[1] [2] [3]" = FBEXT_PP_STRINGIZE(fbextPP_For(1, PRED, OP, M)) )
    
    end sub
    
    private sub register constructor
		ext.testly.addSuite("ext-preprocessor-repetition-for")
		ext.testly.addTest("test", @test)
	end sub

end namespace
