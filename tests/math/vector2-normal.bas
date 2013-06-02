# include once "ext/tests.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

type Vector as ext.math.fbext_Vector2( ((double)) )

    private sub Test
    
        var a = Vector( 10.0, 0.0 )
        a.Normalize()
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 1.0, a.x ) )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 0.0, a.y ) )
        
        var b = Vector( 0.0, 10.0 )
        b.Normalize()
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 0.0, b.x ) )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 1.0, b.y ) )
        
        var c = Vector( -10.0, 0.0 )
        c.Normalize()
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( -1.0, c.x ) )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 0.0, c.y ) )
        
        var d = Vector( 0.0, -10.0 )
        d.Normalize()
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 0.0, d.x ) )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( -1.0, d.y ) )
    
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-math-vector2-normal")
		ext.tests.addTest("Test", @Test)
	end sub

end namespace
