# include once "ext/tests.bi"
# include once "ext/math/vector2.bi"

namespace ext.tests.math

type Vector as ext.math.fbext_Vector2( ((double)) )

    private sub Test
    
        var a = Vector( 2.0, 3.0 )
        var b = Vector( 4.0, 5.0 )
        
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 23.0, a.Dot(b) ) )
    
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-math-vector2-magnitude")
		ext.tests.addTest("Test", @Test)
	end sub

end namespace
