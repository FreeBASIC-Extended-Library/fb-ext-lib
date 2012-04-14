# include once "ext/testly.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

var shared origin = ext.math.fbext_Vector2( ((double)) )( 0.0, 0.0 )

    private sub Test
    
        var a = ext.math.fbext_Vector2( ((double)) )( 3.0, 4.0 )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 5.0, a.Distance(origin) ) )
        
        var b = ext.math.fbext_Vector2( ((double)) )( 3.0, -4.0 )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 5.0, b.Distance(origin) ) )
        
        var c = ext.math.fbext_Vector2( ((double)) )( -3.0, 4.0 )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 5.0, c.Distance(origin) ) )
        
        var d = ext.math.fbext_Vector2( ((double)) )( -3.0, -4.0 )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 5.0, d.Distance(origin) ) )
    
    end sub
    
    private sub TestZeroX
    
        var c = ext.math.fbext_Vector2( ((double)) )( 0.0, 3.0 )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 3.0, c.Distance(origin) ) )
        
        var d = ext.math.fbext_Vector2( ((double)) )( 0.0, -3.0 )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 3.0, d.Distance(origin) ) )
    
    end sub
    
    private sub TestZeroY
    
        var a = ext.math.fbext_Vector2( ((double)) )( 4.0, 0.0 )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 4.0, a.Distance(origin) ) )
        
        var b = ext.math.fbext_Vector2( ((double)) )( -4.0, 0.0 )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( 4.0, b.Distance(origin) ) )
    
    end sub
    
	private sub register constructor
		ext.testly.addSuite("ext-math-vector2-distance")
		ext.testly.addTest("Test", @Test)
		ext.testly.addTest("TestZeroX", @TestZeroX)
		ext.testly.addTest("TestZeroY", @TestZeroY)
	end sub

end namespace

