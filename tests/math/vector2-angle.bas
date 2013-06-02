# include once "ext/tests.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

    private sub Test0
    
        var a = ext.math.fbext_Vector2( ((double)) )( 100.0, 0.0 )
        
        var theta = a.AngleBetween( a )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 0.0, FBEXT_RADIAN_TO_DEGREE( theta ) ) )
    
    end sub
    
    private sub Test90
    
        var a = ext.math.fbext_Vector2( ((double)) )( 100.0, 0.0 )
        var b = ext.math.fbext_Vector2( ((double)) )( 0.0, 100.0 )
        
        var theta = a.AngleBetween( b )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 90.0, FBEXT_RADIAN_TO_DEGREE( theta ) ) )
        
        theta = b.AngleBetween( a )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 90.0, FBEXT_RADIAN_TO_DEGREE( theta ) ) )
    
    end sub
    
    private sub Test180
    
        var a = ext.math.fbext_Vector2( ((double)) )( -100.0, 0.0 )
        var b = ext.math.fbext_Vector2( ((double)) )( 100.0, 0.0 )
        
        var theta = a.AngleBetween( b )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 180.0, FBEXT_RADIAN_TO_DEGREE( theta ) ) )
        
        theta = b.AngleBetween( a )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 180.0, FBEXT_RADIAN_TO_DEGREE( theta ) ) )
    
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-math-vector2-angle")
		ext.tests.addTest("Test0", @Test0)
		ext.tests.addTest("Test90", @Test90)
		ext.tests.addTest("Test180", @Test180)
	end sub

end namespace

