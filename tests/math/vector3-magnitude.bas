# include once "ext/tests.bi"
# include once "ext/math/vector3.bi"

namespace ext.tests.math

type Vector as ext.math.fbext_Vector3( ((double)) )

    private sub Test
    
        var a = Vector( 5.0, 0.0, 0.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, a.Magnitude() ) )
        
        var b = Vector( -5.0, 0.0, 0.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, b.Magnitude() ) )
        
        var c = Vector( 0.0, 5.0, 0.0  )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, c.Magnitude() ) )
        
        var d = Vector( 0.0, -5.0, 0.0  )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, d.Magnitude() ) )
    
        var e = Vector( 0.0, 0.0, 5.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, e.Magnitude() ) )
        
        var f = Vector( 0.0, 0.0, -5.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, f.Magnitude() ) )
        
        var g = Vector( 3.0, 4.0, 0.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, g.Magnitude() ) )
        
        var h = Vector( 0.0, 3.0, 4.0 )
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 5.0, h.Magnitude() ) )
    
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-math-vector3-magnitude")
		ext.tests.addTest("Test", @Test)
	end sub

end namespace

