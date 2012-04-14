# include once "ext/testly.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

type Vector as ext.math.fbext_Vector2( ((double)) )

    private sub Test
    
        var a = Vector( 10.0, 0.0 )
        a.Normalize()
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 1.0, a.x ) )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 0.0, a.y ) )
        
        var b = Vector( 0.0, 10.0 )
        b.Normalize()
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 0.0, b.x ) )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 1.0, b.y ) )
        
        var c = Vector( -10.0, 0.0 )
        c.Normalize()
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( -1.0, c.x ) )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 0.0, c.y ) )
        
        var d = Vector( 0.0, -10.0 )
        d.Normalize()
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 0.0, d.x ) )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( -1.0, d.y ) )
    
    end sub
    
	private sub register constructor
		ext.testly.addSuite("ext-math-vector2-normal")
		ext.testly.addTest("Test", @Test)
	end sub

end namespace
