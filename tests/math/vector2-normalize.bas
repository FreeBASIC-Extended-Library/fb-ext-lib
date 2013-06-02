# include once "ext/tests.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

    private sub TestSimple
    
        var a = ext.math.fbext_Vector2( ((double)) )( 100.0, 0.0 )
        a.Normalize()
        
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( a.x, 1.0 ) )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( a.y, 0.0 ) )
        
        var b = ext.math.fbext_Vector2( ((double)) )( 0.0, 100.0 )
        b.Normalize()
        
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( b.x, 0.0 ) )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( b.y, 1.0 ) )
        
        var c = ext.math.fbext_Vector2( ((double)) )( -100.0, 0.0 )
        c.Normalize()
        
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( c.x, -1.0 ) )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( c.y, 0.0 ) )
        
        var d = ext.math.fbext_Vector2( ((double)) )( 0.0, -100.0 )
        d.Normalize()
        
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( d.x, 0.0 ) )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( d.y, -1.0 ) )
        
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-math-vector2-normalize")
		ext.tests.addTest("TestSimple", @TestSimple)
	end sub

end namespace
