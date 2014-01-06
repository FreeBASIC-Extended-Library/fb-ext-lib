''Title: math/matrix.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MATH_MATRIX_BI__
# define FBEXT_MATH_MATRIX_BI__ -1

# include once "ext/math/detail/common.bi"
# include once "ext/math/vector3.bi"
# include once "ext/math/vector2.bi"
# include once "ext/math/vector4.bi"

''Namespace: ext.math

namespace ext.math

    ''Class: matrix
    ''Standard OpenGL style (column major) matrix class for 3D programming.
    ''
    ''Usage:
    ''For simplicity, any reference to plane, will be vec4f for this library.
    ''
    type matrix

         public:
        ''Sub: constructor
        ''Default constructor initializing the matrix to 0
        ''
        ''Parameters:
        ''c - optional value to initialize the matrix to, defaults to 0.
        ''
        declare constructor( byref c as single = 0)

        ''Sub: constructor
        ''Constructor used to set matrix values to a set of vectors.
        ''
        ''Parameters:
        ''r - the "right" vector.
        ''u - the "up" vector.
        ''f - the "forward" vector.
        ''p - the "position" vector.
        ''
        declare constructor( byref r as vec3f, byref u as vec3f, byref f as vec3f, byref p as vec3f )

        ''Sub: constructor
        ''Constructs a matrix from another.
        ''
        declare constructor( byref x as matrix )

        ' TODO: remove this ? ...

        ''Sub: LoadIdentity
        ''"Resets" a transformation matrix with no rotation, translation, scaling or skewing.
        ''
        declare sub LoadIdentity()

        ' TODO: ... and keep this ?

        ''Function: Identity
        ''Returns the identity matrix, a matrix whose axis are normalized on
        ''the x, y and z axis, and whose position is at the origin (0, 0, 0).
        ''
        ''Returns:
        ''Returns the identity matrix.
        ''
        declare static function Identity ( ) as matrix

        ''Sub: LookAt
        ''Simplifies the construction of camera systems commonly used in 3d games.
        ''
        ''Parameters:
        ''v1 - center of rotation: an example would be to send the player's position vector
        ''v2 - view vector: an example would be to send the player's forward vector
        ''vup - up vector: in a first person shooter, this would amost always be a <vec3f>(0,1,0)
        ''
        declare sub LookAt( byref v1 as vec3f, byref v2 as vec3f, byref vup as vec3f )

        ''Sub: PointAt
        ''Simplifies the creation of aligned matrices
        ''
        ''Parameters:
        ''v1 - center of rotation: an example would be to send the player's position vector
        ''v2 - arbitrary point in space to align the matrices forward vector with
        ''
        declare sub PointAt( byref v1 as vec3f, byref v2 as vec3f )


        ' TODO: remove this ? ...

        ''Function: Inverse
        ''This function is useful if you need the inverse matrix for calculating the local position of a vector, such as a light source.
        ''It's commonly used for such things as shadow volume projection and bump mapping in 3d scenes.
        ''This function is especially useful because the OpenGL API does not provide an inverse matrix function.
        ''
        ''Returns:
        ''The inverse of the matrix.
        ''
        declare function Inverse() as matrix

        ' TODO: ... and keep these ?

        ''Function: Invert
        ''Inverts the matrix. The new matrix value, when multiplied by it's
        ''previous value, results in the identity matrix.
        ''
        ''Description:
        ''This function is useful if you need the inverse matrix for calculating the local position of a vector, such as a light source.
        ''It's commonly used for such things as shadow volume projection and bump mapping in 3d scenes.
        ''This function is especially useful because the OpenGL API does not provide an inverse matrix function.
        ''
        declare sub Invert()

        ''Function: Invert_copy
        ''Returns the inverse of the matrix.
        ''
        ''Returns:
        ''Returns the inverse of the matrix.
        ''
        declare function Invert_copy() as matrix

        ''Function: PlanarProjection
        ''Builds a planar projection matrix using vec4f and plane(vec4f).
        ''For simplicity, this library has no "plane" type, it uses vec4f.
        ''
        ''Parameters:
        ''lightpos - position of light source(vec4f)
        ''plane - plane to project onto.
        ''
        ''Returns:
        ''the new planar projection matrix
        ''
        declare function PlanarProjection( byref lightpos as vec4f, byref plane as vec4f ) as matrix


        ''Sub: InfiniteProjection
        ''Builds an infinite projection matrix using fov(field of view), aspectratio( aspect ratio ) and znear( znear )
        ''
        ''Parameters:
        ''fov field of view... in opengl, use the same value you would bnormally build your projection matrix with
        ''aspectratio... again, in opengl, use the same value you would normally build your projection matrix with
        ''znear... and again, in opengl, use the same value you would normally build your projection matrix with
        ''
        ''Returns:
        ''nothing
        ''
        declare sub InfiniteProjection( byref fov as single, byref aspectratio as single, byref znear as single )

        ''Sub: AxisAngle
        ''
        declare sub AxisAngle( byref v as vec3f, byref angle as single )

        ''Sub: Translate
        ''generic translation function
        ''
        ''Parameters:
        ''X - translate to x position
        ''Y - translate to y position
        ''Z - translate to z position
        ''
        declare sub Translate( byref x as single, byref y as single, byref z as single )
        declare sub Translate( byref x as Integer, byref y as Integer, byref z as Integer )


        ''Sub: Rotate
        ''generic rotation function
        ''
        ''Parameters:
        ''anglex - angle to rotate about the x axis
        ''angley - angle to rotate about the y axis
        ''anglez - angle to rotate about the z axis
        ''
        declare sub Rotate( byref anglex as single, byref angley as single, byref anglez as single )

        ''Sub: Rotate
        ''generic rotation function
        ''
        ''Parameters:
        ''anglex - angle to rotate about the x axis
        ''angley - angle to rotate about the y axis
        ''anglez - angle to rotate about the z axis
        ''
        declare sub Rotate( byref anglex as integer, byref angley as integer, byref anglez as integer )

        ''Sub: Scale
        ''Scales each axis of the matrix by scalar
        ''
        ''Parameters:
        ''scalar - amount to scale by.
        ''
        declare sub Scale( byref scalar as single )

        ''Sub: Scale
        ''Scales each axis of the matrix independently
        ''
        ''Parameters:
        ''scalarx - amount to scale the x axis by.
        ''scalary - amount to scale the y axis by.
        ''scalarz - amount to scale the z axis by.
        ''
        declare sub Scale( byref scalarx as single, byref scalary as single, byref scalarz as single )

        ''Sub: Gram_Scmidt
        ''Calculates an orthonormal matrix with the forward vector aligned with vector "d", while "vectors "up" and "right" are calculated using the "Gram Schmidt" method.
        ''
        ''Parameters:
        ''d - the vector to use for forward
        ''
        declare sub Gram_Schmidt( byref d as vec3f )

        'setters
        ''Property: Right
        ''setter for the right vector component
        ''
        ''Parameters:
        ''v - sets the right vector components of the matrix
        ''
        declare property Right( byref v as vec3f )

        ''Property: Up
        ''setter for the up vector component
        ''
        ''Parameters:
        ''v - sets the up vector components of the matrix
        ''
        declare property Up( byref v as vec3f )

        ''Property: Forward
        ''setter for the forward vector component
        ''
        ''Parameters:
        ''v - sets the forward vector components of the matrix
        ''
        declare property Forward( byref v as vec3f )

        ''Property: Position
        ''setter for the position vector component
        ''
        ''Parameters:
        ''v - sets the position vector components of the matrix
        ''
        declare property Position( byref v as vec3f )


        'getters
        ''Property: Right
        ''getter for the right vector component
        ''
        ''Returns:
        ''the right vector components of the matrix
        ''
        declare property Right() as vec3f

        ''Property: Up
        ''getter for the up vector component
        ''
        ''Returns:
        ''the up vector components of the matrix
        ''
        declare property Up() as vec3f

        ''Property: Forward
        ''getter for the forward vector component
        ''
        ''Returns:
        ''the forward vector components of the matrix
        ''
        declare property Forward() as vec3f

        ''Property: Position
        ''getter for the position vector component
        ''
        ''Returns:
        ''the position vector components of the matrix
        ''
        declare property Position() as vec3f

        ''Property: GetArrayData
        ''Returns a pointer to the matrix data for passing to OpenGL functions.
        ''
            declare property GetArrayData() as single ptr

        'operators
        declare operator *= ( byref mat as matrix )
        declare operator cast() as string
            declare operator cast() as single ptr

        private:
        m(16) as single = any

    end type

    'global operators
    declare operator * ( byref lhs as matrix, byref rhs as matrix ) as matrix
    declare operator * ( byref lhs as vec2f, byref rhs as matrix ) as vec2f
    declare operator * ( byref lhs as vec3f, byref rhs as matrix ) as vec3f
    declare operator * ( byref lhs as vec4f, byref rhs as matrix ) as vec4f

end namespace 'ext.math

# endif 'include guard
