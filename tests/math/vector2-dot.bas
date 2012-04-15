# include once "ext/testly.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

type Vector as ext.math.fbext_Vector2( ((double)) )

    private sub Test
    
        var a = Vector( 2.0, 3.0 )
        var b = Vector( 4.0, 5.0 )
        
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 23.0, a.Dot(b) ) )
    
    end sub
    
	private sub register constructor
		ext.testly.addSuite("ext-math-vector2-magnitude")
		ext.testly.addTest("Test", @Test)
	end sub

end namespace
