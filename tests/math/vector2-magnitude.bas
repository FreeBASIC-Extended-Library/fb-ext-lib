# include once "ext/tests.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

type Vector as ext.math.fbext_Vector2( ((double)) )

    private sub Test
    
        var a = Vector( 5.0, 0.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, a.Magnitude() ) )
        
        var b = Vector( -5.0, 0.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, b.Magnitude() ) )
        
        var c = Vector( 0.0, 5.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, c.Magnitude() ) )
        
        var d = Vector( 0.0, -5.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, d.Magnitude() ) )
    
        var e = Vector( 3.0, 4.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, e.Magnitude() ) )
    
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-math-vector2-magnitude")
		ext.tests.addTest("Test", @Test)
	end sub

end namespace

