# include once "ext/testly.bi"
# include once "ext/math/vector3.bi"

namespace ext.tests.math

type Vector as ext.math.fbext_Vector3( ((double)) )

var shared origin = Vector( 0.0, 0.0, 0.0 )

# define TEST_DISTANCE_FROM_ORIGIN( v, d ) _
    TESTLY_ASSERT_TRUE( FBEXT_FLOAT_EQUAL( d, (v).Distance(origin) ) )

    private sub Test
    
        TEST_DISTANCE_FROM_ORIGIN( Vector( 3.0, 4.0, 0.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( 3.0, -4.0, 0.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( -3.0, 4.0, 0.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( -3.0, -4.0, 0.0 ), 5.0 )
        
        TEST_DISTANCE_FROM_ORIGIN( Vector( 3.0, 0.0, 4.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( 3.0, 0.0, -4.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( -3.0, 0.0, 4.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( -3.0, 0.0, -4.0 ), 5.0 )
        
        TEST_DISTANCE_FROM_ORIGIN( Vector( 0.0, 3.0, 4.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( 0.0, 3.0, -4.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( 0.0, -3.0, 4.0 ), 5.0 )
        TEST_DISTANCE_FROM_ORIGIN( Vector( 0.0, -3.0, -4.0 ), 5.0 )
    
    end sub
    
	private sub register constructor
		ext.testly.addSuite("ext-math-vector3-distance")
		ext.testly.addTest("Test", @Test)
	end sub

end namespace

