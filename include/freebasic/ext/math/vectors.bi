''Title: math/vectors.bi
''This header has been marked deprecated.
''
''All new programs should use ext/math/vector2.bi for <Vector2> or ext/math/vector3.bi for <Vector3> instead.
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MATH_VECTORS_BI__
# define FBEXT_MATH_VECTORS_BI__ -1
#ifndef FBEXT_USE_DEPRECATED
#error "ERROR: ext/math/vectors.bi is being deprecated. You should check into the Vector2, Vector3 and Vector4 replacement classes."
#else
#print "WARNING: ext/math/vectors.bi is being deprecated. You should check into the Vector2, Vector3 and Vector4 replacement classes."
#endif
# include once "ext/math/detail/common.bi"

''Namespace: ext.math

namespace ext.math

type matrix_ as matrix

''Class: vector2d
''Simple 2 dimensional vector.
''
''This class is being deprecated in favor of <Vector2>.
''
type vector2d

    declare constructor ( byval x as single, byval y as single )
    declare constructor ( byref v2d as vector2d )
    declare constructor ( )

   ''Variable: x
   x as single

   ''Variable: y
   y as single

   declare operator Cast() as string

   ''Function: dot
   ''vector dot product function
   ''
   ''Parameters:
   ''v - second vector for dot product operation.
   ''
   ''Returns:
   ''single precision dot product of vector "this"  and vector "v"
   ''
   declare function dot ( byref v As vector2D ) as single

   ''Function: magnitude
   ''vector magnitude function
   ''
   ''Returns:
   ''magnitude of "this" vector
   ''
   declare function magnitude() as single

   ''Sub: normalize
   ''normalizes "this" vector
   ''
   declare sub normalize()

   ''Function: cross
   ''vector cross product function
   ''
   ''Parameters:
   ''v - second vector for cross product operation
   ''
   ''Returns:
   ''cross product of vector "this" and vector "v"
   ''
   declare function cross( byref v as vector2d ) as vector2d

   ''Function: distance
   ''vector distance function (euler)
   ''
   ''Parameters:
   ''v - second vector for distance operation
   ''
   ''Returns:
   ''the distance between vector "this" and vector "v"
   ''
   declare function distance( byref v as vector2d ) as single

   ''Function: AngleBetween
   ''angle between vectors function
   ''
   ''Parameters:
   ''v - second vector to find the angle between of.
   ''
   ''Returns:
   ''the angle (in radians) between vector "this" and vector "v"
   declare function AngleBetween( byref v as vector2d ) as single

   declare operator Let ( byref rhs as vector2d )

end type

''Class: vector3d
''Simple 3 dimensional vector.
''
type vector3d

    declare constructor ( byval x as single, byval y as single, byval z as single )
    declare constructor ( byref v3d as vector3d )
    declare constructor ( )

   ''Variable: x
   x as single

   ''Variable: y
   y as single

   ''Variable: z
   z as single

   declare operator Cast() as string
   declare operator Cast() as vector2d
   declare operator *= ( byref rhs as matrix_ )
   declare operator *= ( byref s as single )

   declare operator +=( byref rhs As vector3d )

   ''Function: dot
   ''vector dot product function
   ''
   ''Parameters:
   ''v - second vector for dot product operation.
   ''
   ''Returns:
   ''single precision dot product of vector "this"  and vector "v"
   ''
   declare function dot ( byref v As vector3D ) as single

   ''Function: magnitude
   ''vector magnitude function
   ''
   ''Returns:
   ''magnitude of "this" vector
   ''
   declare function magnitude() as single

   ''Sub: normalize
   ''normalizes "this" vector
   ''
   declare sub normalize()

   ''Function: cross
   ''vector cross product function
   ''
   ''Parameters:
   ''v - second vector for cross product operation
   ''
   ''Returns:
   ''cross product of vector "this" and vector "v"
   ''
   declare function cross( byref v as vector3d ) as vector3d

   ''Function: distance
   ''vector distance function (euler)
   ''
   ''Parameters:
   ''v - second vector for distance operation
   ''
   ''Returns:
   ''the distance between vector "this" and vector "v"
   ''
   declare function distance( byref v as vector3d ) as single

   ''Function: AngleBetween
   ''angle between vectors function
   ''
   ''Parameters:
   ''v - second vector for AngleBetween operation
   ''
   ''Returns:
   ''the angle (in radians) between vector "this" and vector "v"
   ''
   declare function AngleBetween( byref v As vector3d ) As single
end type

''Class: vector4d
''Simple 4 dimensional vector.
type vector4d

    declare constructor ( byval x as single, byval y as single, byval z as single, byval w as double )
    declare constructor ( byref v4d as vector4d )
    declare constructor ( )

   ''Variable: x
   x as single

   ''Variable: y
   y as single

   ''Variable: z
   z as single

   ''Variable: w
   w as single

   declare operator Cast() as string
   declare operator Cast() as vector3d
   declare operator *= ( byref rhs as matrix_ )


   ''Function: dot
   ''vector dot product function
   ''
   ''Parameters:
   ''v - second vector for dot product operation.
   ''
   ''Returns:
   ''single precision dot product of vector "this"  and vector "v"
   ''
   declare function dot ( byref v As vector4D ) as single

   ''Function: magnitude
   ''vector magnitude function
   ''
   ''Returns:
   ''magnitude of "this" vector
   ''
   declare function magnitude() as single

   ''Sub: normalize
   ''normalizes "this" vector
   ''
   declare sub normalize()

   ''Function: cross
   ''vector cross product function
   ''
   ''Parameters:
   ''v - second vector for cross product operation
   ''
   ''Returns:
   ''cross product of vector "this" and vector "v"
   ''
   declare function cross( byref v as vector4d ) as vector4d

   ''Function: distance
   ''vector distance function (euler)
   ''
   ''Parameters:
   ''v - second vector for distance operation
   ''
   ''Returns:
   ''the distance between vector "this" and vector "v"
   ''
   declare function distance ( byref v as vector4d ) as single
end type


declare operator + ( Byref lhs As vector2d, Byref rhs As Single ) As vector2d
declare operator + ( byref lhs as vector2d, byref rhs as vector2d ) as vector2d



declare operator + ( Byref lhs As vector3d, Byref rhs As Single ) As vector3d
declare operator + ( Byref lhs As vector3d, Byref rhs As vector3d ) As vector3d

declare operator + ( byref lhs as vector3d, byref rhs as double ) as vector4d
declare operator + ( byref lhs as vector4d, byref rhs as vector4d ) as vector4d
declare operator + ( byref lhs as vector4d, byref rhs as single ) as vector4d



declare operator - ( byref lhs as vector2d, byref rhs as vector2d ) as vector2d

declare operator - ( Byref lhs As vector3d ) As vector3d
declare operator - ( Byref lhs As vector3d, Byref rhs As vector3d ) As vector3d
declare operator - ( Byref lhs As vector3d, Byref rhs As vector4d ) As vector3d
declare operator - ( Byref lhs As vector3d, Byref rhs As Single ) As vector3d

declare operator - ( byref lhs as vector4d, byref rhs as vector4d ) as vector4d



declare operator * ( Byref lhs As vector2d, Byref rhs As vector2d ) As vector2d
declare operator * ( Byref lhs As vector2d, Byref rhs As single ) As vector2d
declare operator * ( Byref lhs As vector2d, Byref rhs As double ) As vector2d

declare operator * ( Byref lhs As vector3d, Byref rhs As vector3d ) As vector3d
declare operator * ( Byref lhs As vector3d, Byref rhs As vector4d ) As vector3d
declare operator * ( Byref lhs As vector3d, Byref rhs As Double ) As vector3d
declare operator * ( Byref lhs As vector3d, Byref rhs As Single ) As vector3d

declare operator * ( Byref lhs As vector4d, Byref rhs As vector4d ) As vector4d
declare operator * ( Byref lhs As vector4d, Byref rhs As Single ) As vector4d



declare operator / ( Byref lhs As vector2d, Byref rhs As vector2d ) As vector2d
declare operator / ( Byref lhs As vector2d, Byref rhs As integer  ) As vector2d
declare operator / ( Byref lhs As vector2d, Byref rhs As single   ) As vector2d
declare operator / ( Byref lhs As vector2d, Byref rhs As double   ) As vector2d


declare operator / ( Byref lhs As vector3d, Byref rhs As vector3d ) As vector3d
declare operator / ( Byref lhs As vector3d, Byref rhs As Single ) As vector3d
declare operator / ( Byref lhs As vector3d, Byref rhs As Double ) As vector3d


declare operator / ( Byref lhs As vector4d, Byref rhs As vector4d ) As vector4d
declare operator / ( Byref lhs As vector4d, Byref rhs As single ) As vector4d



end namespace 'ext.math

# endif ' include guard
