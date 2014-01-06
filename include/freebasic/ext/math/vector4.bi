''Title: math/vector4.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MATH_VECTOR4_BI__
# define FBEXT_MATH_VECTOR4_BI__ -1

# include once "ext/math/detail/common.bi"
# include once "ext/math/vector3.bi"

# define fbext_Vector4( targs_) fbext_TemplateID( Vector4, targs_, (__) )

# macro fbext_Vector4_Declare( T_)
:
fbext_TDeclare(fbext_Vector3, ( T_))

namespace ext.math
''Class: fbext_Vector4(( T_))
''Simple 4 dimensional vector.
type fbext_Vector4(( T_))

    declare constructor ( byval x as fbext_TypeName( T_), byval y as fbext_TypeName( T_), byval z as fbext_TypeName( T_), byval w as double )
    declare constructor ( byref v4d as fbext_Vector4(( T_)) )
    declare constructor ( )

   ''Variable: x
   x as fbext_TypeName( T_)

   ''Variable: y
   y as fbext_TypeName( T_)

   ''Variable: z
   z as fbext_TypeName( T_)

   ''Variable: w
   w as double

   declare operator Cast() as string
   declare operator Cast() as fbext_Vector3( (T_))
   'declare operator *= ( byref rhs as matrix_ )


   ''Function: dot
   ''vector dot product function
   ''
   ''Parameters:
   ''v - second vector for dot product operation.
   ''
   ''Returns:
   ''fbext_TypeName( T_) precision dot product of vector "this"  and vector "v"
   ''
   declare function dot ( byref v As fbext_Vector4(( T_)) ) as fbext_TypeName( T_)

   ''Function: magnitude
   ''vector magnitude function
   ''
   ''Returns:
   ''magnitude of "this" vector
   ''
   declare function magnitude() as fbext_TypeName( T_)

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
   declare function cross( byref v as fbext_Vector4(( T_)) ) as fbext_Vector4(( T_))

   ''Function: distance
   ''vector distance function (euler)
   ''
   ''Parameters:
   ''v - second vector for distance operation
   ''
   ''Returns:
   ''the distance between vector "this" and vector "v"
   ''
   declare function distance ( byref v as fbext_Vector4(( T_)) ) as fbext_TypeName( T_)

end type

declare operator + ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_Vector4((T_)) ) as fbext_Vector4((T_))
declare operator + ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_TypeName( T_) ) as fbext_Vector4((T_))
declare operator - ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_Vector4((T_)) ) as fbext_Vector4((T_))
declare operator * ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_Vector4((T_)) ) as fbext_Vector4((T_))
declare operator * ( Byref lhs As fbext_Vector4((T_)), Byref rhs As fbext_TypeName( T_) ) As fbext_Vector4((T_))
declare operator / ( Byref lhs As fbext_Vector4((T_)), Byref rhs As fbext_TypeName( T_) ) As fbext_Vector4((T_))
declare operator / ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_Vector4((T_)) ) as fbext_Vector4((T_))

end namespace
:
# endmacro

# macro fbext_Vector4_Define( linkage_, T_)
:
namespace ext.math

linkage_ constructor fbext_Vector4((T_)) ( byval x as fbext_TypeName( T_), byval y as fbext_TypeName( T_), byval z as fbext_TypeName( T_), byval w as double )

    this.x = x
    this.y = y
    this.z = z
    this.w = w

end constructor

linkage_ constructor fbext_Vector4((T_)) ( byref v4d as fbext_Vector4((T_)) )

    this.x = v4d.x
    this.y = v4d.y
    this.z = v4d.z
    this.w = v4d.w

end constructor

linkage_ constructor fbext_Vector4((T_)) ( )

    this.x = 0
    this.y = 0
    this.z = 0
    this.w = 0.0

end constructor


linkage_ function fbext_Vector4((T_)).dot ( byref v As fbext_Vector4((T_)) ) as fbext_TypeName( T_)
    Return  this.x * v.x + this.y * v.y + this.z * v.z + this.w * v.w
end function

linkage_ function fbext_Vector4((T_)).magnitude( ) As fbext_TypeName( T_)
     Dim Mag As Single = any
     mag = Sqr( this.x ^2 + this.y ^2 + this.z ^2 + this.w ^2 )
     If mag = 0 Then mag = 1
     return mag
end function

linkage_ sub fbext_Vector4((T_)).normalize()
    this = this / this.magnitude()
end sub

linkage_ function fbext_Vector4((T_)).cross( byref v as fbext_Vector4((T_)) ) as fbext_Vector4((T_))
    return Type<fbext_Vector4((T_))>((this.y * v.z) - (v.y * this.z), (this.z * v.x) - (v.z * this.x), (this.x * v.y) - (v.x * this.y), this.w)
end function

linkage_ function fbext_Vector4((T_)).distance( byref v as fbext_Vector4((T_)) ) as fbext_TypeName( T_)
    return Sqr((v.x - this.x)^2 + (v.y - this.y)^2 + (v.z - this.z)^2)
end function

linkage_ operator fbext_Vector4((T_)).cast() as string
    return "{x:" & this.x & ", y:" & this.y & ", z:" & this.z & ", w:" & this.w & "}"
end operator

linkage_ operator fbext_Vector4((T_)).cast() as fbext_Vector3((T_))
    return type<fbext_Vector3((T_))>(this.x, this.y, this.z)
end operator

linkage_ operator + ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_Vector4((T_)) ) as fbext_Vector4((T_))
    return type<fbext_Vector4((T_))>( lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w )
end operator

linkage_ operator + ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_TypeName( T_) ) as fbext_Vector4((T_))
    return type<fbext_Vector4((T_))>( lhs.x + rhs, lhs.y + rhs, lhs.z + rhs, lhs.w + rhs )
end operator

linkage_ operator - ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_Vector4((T_)) ) as fbext_Vector4((T_))

    return type<fbext_Vector4((T_))>( lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w )

end operator

linkage_ operator * ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_Vector4((T_)) ) as fbext_Vector4((T_))

    return type<fbext_Vector4((T_))>( lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w )

end operator


linkage_ operator * ( Byref lhs As fbext_Vector4((T_)), Byref rhs As fbext_TypeName( T_) ) As fbext_Vector4((T_))
    Return Type<fbext_Vector4((T_))>(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs )
End operator

'operator fbext_Vector4((T_)).*= ( byref rhs as matrix )
'    this = this * rhs
'end operator


linkage_ operator / ( Byref lhs As fbext_Vector4((T_)), Byref rhs As fbext_TypeName( T_) ) As fbext_Vector4((T_))
    Return Type<fbext_Vector4((T_))>(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs )
End operator

linkage_ operator / ( byref lhs as fbext_Vector4((T_)), byref rhs as fbext_Vector4((T_)) ) as fbext_Vector4((T_))
    return type<fbext_Vector4((T_))>( lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z, lhs.w / rhs.w )
end operator

end namespace
:
# endmacro

fbext_InstanciateMulti( fbext_Vector4, fbext_NumericTypes() )

namespace ext.math

    ' OpenGL-friendly type aliases.. should probably put
    ' these elsewhere.. "ext/opengl.bi" ?
    type vec4i as fbext_Vector4( ((integer)) )
    type vec4f as fbext_Vector4( ((single)) )
    type vec4d as fbext_Vector4( ((double)) )

end namespace

# endif ' include guard
