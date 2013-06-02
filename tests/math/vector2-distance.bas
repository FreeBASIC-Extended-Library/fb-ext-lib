# include once "ext/tests.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

var shared origin = ext.math.fbext_Vector2( ((double)) )( 0.0, 0.0 )

    private sub Test
    
        var a = ext.math.fbext_Vector2( ((double)) )( 3.0, 4.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, a.Distance(origin) ) )
        
        var b = ext.math.fbext_Vector2( ((double)) )( 3.0, -4.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, b.Distance(origin) ) )
        
        var c = ext.math.fbext_Vector2( ((double)) )( -3.0, 4.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, c.Distance(origin) ) )
        
        var d = ext.math.fbext_Vector2( ((double)) )( -3.0, -4.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, d.Distance(origin) ) )
    
    end sub
    
    private sub TestZeroX
    
        var c = ext.math.fbext_Vector2( ((double)) )( 0.0, 3.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 3.0, c.Distance(origin) ) )
        
        var d = ext.math.fbext_Vector2( ((double)) )( 0.0, -3.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 3.0, d.Distance(origin) ) )
    
    end sub
    
    private sub TestZeroY
    
        var a = ext.math.fbext_Vector2( ((double)) )( 4.0, 0.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 4.0, a.Distance(origin) ) )
        
        var b = ext.math.fbext_Vector2( ((double)) )( -4.0, 0.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 4.0, b.Distance(origin) ) )
    
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-math-vector2-distance")
		ext.tests.addTest("Test", @Test)
		ext.tests.addTest("TestZeroX", @TestZeroX)
		ext.tests.addTest("TestZeroY", @TestZeroY)
	end sub

end namespace

