#define fbext_NoBuiltinInstanciations() -1
# include once "ext/testly.bi"
# include once "ext/math/matrix.bi"

fbext_Instanciate(Vector3, ((single)))

namespace ext.tests.math

    using ext.math

    private function check_vector ( byref v as ext.math.vec3f, byval x as single, byval y as single, byval z as single) as bool

        var res = true
        if not (abs((v.x) - (x)) < 0.0000000001f) then
            res = false
        end if
        if not (abs((v.y) - (y)) < 0.0000000001f)  then
            res = false
        end if
        if not (abs((v.z) - (z)) < 0.0000000001f)  then
            res = false
        end if
        return res

    end function

    private sub test_matrix_identity

        var m = matrix(matrix.identity())
        m = m

        TESTLY_ASSERT_TRUE( check_vector(m.right,       1.0f, 0.0f, 0.0f) )
        TESTLY_ASSERT_TRUE( check_vector(m.up,          0.0f, 1.0f, 0.0f) )
        TESTLY_ASSERT_TRUE( check_vector(m.forward,     0.0f, 0.0f, 1.0f) )
        TESTLY_ASSERT_TRUE( check_vector(m.position,    0.0f, 0.0f, 0.0f) )

    end sub

    private sub test_matrix_translate

        var m = matrix(matrix.identity())
        m.translate( 1.0f, 2.0f, 3.0f )

        TESTLY_ASSERT_TRUE( check_vector(m.right,       1.0f, 0.0f, 0.0f) )
        TESTLY_ASSERT_TRUE( check_vector(m.up,          0.0f, 1.0f, 0.0f) )
        TESTLY_ASSERT_TRUE( check_vector(m.forward,     0.0f, 0.0f, 1.0f) )
        TESTLY_ASSERT_TRUE( check_vector(m.position,    1.0f, 2.0f, 3.0f) )

    end sub

    private sub test_matrix_rotate

        var m = matrix(matrix.identity())
        m.rotate( 90.0f, 180.0f, 270.0f )

        TESTLY_ASSERT_TRUE( check_vector(m.right,       3.65039e-08f,   -1.216797e-08f, -1.0f) )
        TESTLY_ASSERT_TRUE( check_vector(m.up,          -1,             2.433593e-08f,  -3.65039e-08f) )
        TESTLY_ASSERT_TRUE( check_vector(m.forward,     2.433593e-08f,  1.0f,           1.216796e-08f) )
        TESTLY_ASSERT_TRUE( check_vector(m.position,    0.0f,           0.0f,           0.0f) )

    end sub

    private sub test_matrix_invert

        var m = matrix( _
            type<vec3f>( 0.0f, 1.0f, 2.0f ), _
            type<vec3f>( 3.0f, 4.0f, 5.0f ), _
            type<vec3f>( 6.0f, 7.0f, 8.0f ), _
            type<vec3f>( 9.0f, 10.0f, 11.0f ) _
        )
        m.invert()

        TESTLY_ASSERT_TRUE( check_vector(m.right,       0f, 3f, 6f) )
        TESTLY_ASSERT_TRUE( check_vector(m.up,          1f, 4f, 7f) )
        TESTLY_ASSERT_TRUE( check_vector(m.forward,     2f, 5f, 8f) )
        TESTLY_ASSERT_TRUE( check_vector(m.position,    -32f, -122f, 212f) )

    end sub

    private sub test_matrix_multiply

        var m = matrix( _
            type<vec3f>( 0.0f, 1.0f, 2.0f ), _
            type<vec3f>( 3.0f, 4.0f, 5.0f ), _
            type<vec3f>( 6.0f, 7.0f, 8.0f ), _
            type<vec3f>( 9.0f, 10.0f, 11.0f ) _
        )
        m *= m

        TESTLY_ASSERT_TRUE( check_vector(m.right,       15f, 18f, 21f) )
        TESTLY_ASSERT_TRUE( check_vector(m.up,          42f, 54f, 66f) )
        TESTLY_ASSERT_TRUE( check_vector(m.forward,     69f, 90f, 111f) )
        TESTLY_ASSERT_TRUE( check_vector(m.position,    105f, 136f, 167f) )

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-math-matrix")
        ext.testly.addTest("test_matrix_identity", @test_matrix_identity)
        ext.testly.addTest("test_matrix_translate", @test_matrix_translate)
        ext.testly.addTest("test_matrix_rotate", @test_matrix_rotate)
        ext.testly.addTest("test_matrix_invert", @test_matrix_invert)
        ext.testly.addTest("test_matrix_multiply", @test_matrix_multiply)
    end sub

end namespace

