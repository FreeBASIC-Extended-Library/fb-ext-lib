# include once "ext/testly.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

    private sub TestSimple
    
        var a = ext.math.fbext_Vector2( ((double)) )( 100.0, 0.0 )
        a.Normalize()
        
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( a.x, 1.0 ) )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( a.y, 0.0 ) )
        
        var b = ext.math.fbext_Vector2( ((double)) )( 0.0, 100.0 )
        b.Normalize()
        
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( b.x, 0.0 ) )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( b.y, 1.0 ) )
        
        var c = ext.math.fbext_Vector2( ((double)) )( -100.0, 0.0 )
        c.Normalize()
        
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( c.x, -1.0 ) )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( c.y, 0.0 ) )
        
        var d = ext.math.fbext_Vector2( ((double)) )( 0.0, -100.0 )
        d.Normalize()
        
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( d.x, 0.0 ) )
        TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( d.y, -1.0 ) )
        
    end sub
    
	private sub register constructor
		ext.testly.addSuite("ext-math-vector2-normalize")
		ext.testly.addTest("TestSimple", @TestSimple)
	end sub

end namespace
