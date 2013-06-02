# include once "ext/tests.bi"
# include once "ext/math/vector3.bi"

namespace ext.tests.math

type Vector as ext.math.fbext_Vector3( ((double)) )

    private sub Test
    
        var a = Vector( 2.0, 3.0, 4.0 )
        var b = Vector( 5.0, 6.0, 7.0 )
        
        ext_assert_TRUE( FBEXT_FLOAT_EQUAL( 56.0, a.Dot(b) ) )
    
    end sub
    
	private sub register constructor
		ext.tests.addSuite("ext-math-vector3-dot")
		ext.tests.addTest("Test", @Test)
	end sub

end namespace
