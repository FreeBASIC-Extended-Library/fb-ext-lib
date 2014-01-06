''Title: math/vector2.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MATH_VECTOR2_BI__
# define FBEXT_MATH_VECTOR2_BI__ -1

# include once "ext/math/detail/common.bi"

# define fbext_Vector2( targs_) fbext_TemplateID( Vector2, targs_, (__) )

# macro fbext_Vector2_Declare( T_)
:

''Namespace: ext.math
namespace ext.math

	''Class: Vector2
	''Represents a simple 2 dimensional point of type.
	''
    type fbext_Vector2(( T_))

		''Variable: x
        x as fbext_TypeName( T_)
        ''Variable: y
        y as fbext_TypeName( T_)

        '' sub: default constructor
        declare constructor ( _
        )

        '' sub: component constructor
        declare constructor ( _
            byval x as fbext_TypeName( T_), _
            byval y as fbext_TypeName( T_)  _
        )

        '' sub: copy constructor
        declare constructor ( _
            byref v as const fbext_Vector2(( T_)) _
        )

        '' sub: copy operator let
        declare operator let ( _
            byref v as const fbext_Vector2(( T_)) _
        )
		
		'' sub: cast to string operator
		declare operator cast ( ) as string

        '' function: Magnitude
        declare const function Magnitude ( _
        ) as double

        '' sub: Normalize
        declare sub Normalize ( _
        )

        '' function: Normal
        declare const function Normal ( _
        ) as fbext_Vector2(( T_))

        '' function: Dot
		''vector dot product function
		''
		''Parameters:
		''v - second vector for dot product operation.
		''
		''Returns:
		''double precision dot product of vector "this"  and vector "v"
		''
        declare const function Dot ( _
            byref v as const fbext_Vector2(( T_)) _
        ) as double

        '' function: Cross
		''vector cross product function
		''
		''Parameters:
		''v - second vector for cross product operation
		''
		''Returns:
		''cross product of vector "this" and vector "v"
		''
        declare const function Cross ( _
            byref v as const fbext_Vector2(( T_)) _
        ) as fbext_Vector2(( T_))

        declare operator += ( byval v as fbext_Vector2(( T_)) )
        declare operator += ( byval k as fbext_TypeName( T_) )
        declare operator -= ( byval v as fbext_Vector2(( T_)) )
        declare operator -= ( byval k as fbext_TypeName( T_) )
        declare operator *= ( byval v as fbext_Vector2(( T_)) )
        declare operator *= ( byval k as fbext_TypeName( T_) )
        declare operator /= ( byval v as fbext_Vector2(( T_)) )
        declare operator /= ( byval k as fbext_TypeName( T_) )

        '' function: Distance
        ''  Returns the distance between the endpoints of the vector and
        ''  another.
        declare const function Distance ( byref v as const fbext_Vector2(( T_)) ) as double

        '' function: AngleBetween
        ''  Returns the angle between the vector and another.
        declare const function AngleBetween ( byref v as const fbext_Vector2(( T_)) ) as double

    end type

    '' function: Distance
    ''  Returns the distance between the endpoints of two vectors.
    declare function Distance overload ( _
        byref a as const fbext_Vector2(( T_)),    _
        byref b as const fbext_Vector2(( T_))     _
    ) as double

    '' function: AngleBetween
    ''  Returns the angle between two vectors.
    declare function AngleBetween overload ( _
        byref a as const fbext_Vector2(( T_)),    _
        byref b as const fbext_Vector2(( T_))     _
    ) as double

    '' function: global operator - (negate)
    ''  Returns a * -1.
    declare operator - ( _
        byval a as fbext_Vector2(( T_))     _
    ) as fbext_Vector2(( T_))

    '' function: global operator +
    ''  Returns a vector whose components are the sum of the corresponding
    ''  components of two vectors.
    declare operator + ( _
        byval a as fbext_Vector2(( T_)),    _
        byval b as fbext_Vector2(( T_))     _
    ) as fbext_Vector2(( T_))

    '' function: global operator +
    ''  Returns a vector whose components are the sum of the corresponding
    ''  components of a vector and a scalar.
    declare operator + ( _
        byval a as fbext_Vector2(( T_)),    _
        byval k as fbext_TypeName( T_)      _
    ) as fbext_Vector2(( T_))

    '' function: global operator -
    ''  Returns a vector whose components are the difference of the
    ''  corresponding components of two vectors.
    declare operator - ( _
        byval a as fbext_Vector2(( T_)),    _
        byval b as fbext_Vector2(( T_))     _
    ) as fbext_Vector2(( T_))

    '' function: global operator -
    ''  Returns a vector whose components are the difference of the
    ''  corresponding components of a vector and a scalar.
    declare operator - ( _
        byval a as fbext_Vector2(( T_)),    _
        byval k as fbext_TypeName( T_)      _
    ) as fbext_Vector2(( T_))

    '' function: global operator *
    ''  Returns a vector whose components are the product of the
    ''  corresponding components of two vectors.
    declare operator * ( _
        byval a as fbext_Vector2(( T_)),    _
        byval b as fbext_Vector2(( T_))     _
    ) as fbext_Vector2(( T_))

    '' function: global operator *
    ''  Returns a vector whose components are the product of the
    ''  corresponding components of a vector and a scalar.
    declare operator * ( _
        byval a as fbext_Vector2(( T_)),    _
        byval k as fbext_TypeName( T_)      _
    ) as fbext_Vector2(( T_))

    '' function: global operator /
    ''  Returns a vector whose components are the quotient of the
    ''  corresponding components of two vectors.
    declare operator / ( _
        byval a as fbext_Vector2(( T_)),    _
        byval b as fbext_Vector2(( T_))     _
    ) as fbext_Vector2(( T_))

    '' function: global operator /
    ''  Returns a vector whose components are the quotient of the
    ''  corresponding components of a vector and a scalar.
    declare operator / ( _
        byval a as fbext_Vector2(( T_)),    _
        byval k as fbext_TypeName( T_)      _
    ) as fbext_Vector2(( T_))

end namespace
:
# endmacro

# macro fbext_Vector2_Define( linkage_, T_)
:
namespace ext.math

	'' :::::
	linkage_ operator fbext_Vector2(( T_)).cast() as string
		return "{x:" & this.x & ", y:" & this.y & "}"
	end operator

    '' :::::
    linkage_ constructor fbext_Vector2(( T_)) ( _
    )
        dim value as fbext_TypeName( T_)
        this.x = value
        this.y = value
    end constructor

    '' :::::
    linkage_ constructor fbext_Vector2(( T_)) ( _
        byval x as fbext_TypeName( T_),         _
        byval y as fbext_TypeName( T_)          _
    )
        this.x = x
        this.y = y
    end constructor

    '' :::::
    linkage_ constructor fbext_Vector2(( T_)) ( _
        byref v as const fbext_Vector2(( T_)) _
    )
        this.x = v.x
        this.y = v.y
    end constructor

    '' :::::
    linkage_ operator fbext_Vector2(( T_)).let ( _
        byref v as const fbext_Vector2(( T_)) _
    )
        this.x = v.x
        this.y = v.y
    end operator

    '' :::::
    linkage_ function fbext_Vector2(( T_)).Magnitude ( _
    ) as double
        function = sqr( x^2 + y^2 )
    end function

    '' :::::
    linkage_ sub fbext_Vector2(( T_)).Normalize ( _
    )
        var m = this.Magnitude()
        if ( m <> 0 ) then
            this.x /= m
            this.y /= m
        end if
    end sub

    '' :::::
    linkage_ function fbext_Vector2(( T_)).Normal ( _
    ) as fbext_Vector2(( T_))
        dim tmp as fbext_Vector2(( T_)) = this
        tmp.Normalize()
        return tmp
    end function

    '' :::::
    linkage_ function fbext_Vector2(( T_)).Dot ( _
        byref v as const fbext_Vector2(( T_))   _
    ) as double
        function = this.x * v.x + this.y * v.y
    end function

    '' :::::
    linkage_ function fbext_Vector2(( T_)).Cross ( _
        byref v as const fbext_Vector2(( T_))   _
    ) as fbext_Vector2(( T_))

        var x = v.x - this.x
        var y = v.y - this.y
        var m = sqr( x^2 + y^2 )
        return fbext_Vector2(( T_))( y / m, -x / m )

    end function

    '' :::::
    linkage_ function fbext_Vector2(( T_)).Distance ( _
        byref v as const fbext_Vector2(( T_))   _
    ) as double
        function = ext.math.Distance( this, v )
    end function

    '' :::::
    linkage_ function fbext_Vector2(( T_)).AngleBetween ( _
        byref v as const fbext_Vector2(( T_))   _
    ) as double
        function = ext.math.AngleBetween( this, v )
    end function

    '' :::::
    linkage_ function Distance ( _
        byref a as const fbext_Vector2(( T_)),  _
        byref b as const fbext_Vector2(( T_))   _
    ) as double
        function = sqr( (b.x - a.x)^2 + (b.y - a.y)^2 )
    end function

    '' :::::
    linkage_ function AngleBetween ( _
        byref a as const fbext_Vector2(( T_)),        _
        byref b as const fbext_Vector2(( T_))         _
    ) as double
        function = acos( a.dot(b) / (a.Magnitude() * b.Magnitude()) )
'        function = atan2( b.y, b.x ) - atan2( a.y, a.x )
    end function

    '' :::::
    linkage_ operator - ( _
        byval a as fbext_Vector2(( T_))     _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( -a.x, -a.y )
    end operator

    '' :::::
    linkage_ operator fbext_Vector2(( T_)).+= ( _
        byval v as fbext_Vector2(( T_))         _
    )
        this.x += v.x
        this.y += v.y
    end operator

    '' :::::
    linkage_ operator fbext_Vector2(( T_)).+= ( _
        byval k as fbext_TypeName( T_)          _
    )
        this.x += k
        this.y += k
    end operator

    '' :::::
    linkage_ operator fbext_Vector2(( T_)).-= ( _
        byval v as fbext_Vector2(( T_))         _
    )
        this.x -= v.x
        this.y -= v.y
    end operator

    '' :::::
    linkage_ operator fbext_Vector2(( T_)).-= ( _
        byval k as fbext_TypeName( T_)          _
    )
        this.x -= k
        this.y -= k
    end operator

    '' :::::
    linkage_ operator fbext_Vector2(( T_)).*= ( _
        byval v as fbext_Vector2(( T_))         _
    )
        this.x *= v.x
        this.y *= v.y
    end operator

    '' :::::
    linkage_ operator fbext_Vector2(( T_)).*= ( _
        byval k as fbext_TypeName( T_)          _
    )
        this.x *= k
        this.y *= k
    end operator

    '' :::::
    linkage_ operator fbext_Vector2(( T_))./= ( _
        byval v as fbext_Vector2(( T_))         _
    )
        this.x /= v.x
        this.y /= v.y
    end operator

    '' :::::
    linkage_ operator fbext_Vector2(( T_))./= ( _
        byval k as fbext_TypeName( T_)          _
    )
        this.x /= k
        this.y /= k
    end operator

    '' :::::
    linkage_ operator + ( _
        byval a as fbext_Vector2(( T_)),        _
        byval b as fbext_Vector2(( T_))         _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( a.x + b.x, a.y + b.y )
    end operator

    '' :::::
    linkage_ operator + ( _
        byval a as fbext_Vector2(( T_)),        _
        byval k as fbext_TypeName( T_)          _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( a.x + k, a.y + k )
    end operator

    '' :::::
    linkage_ operator - ( _
        byval a as fbext_Vector2(( T_)),        _
        byval b as fbext_Vector2(( T_))         _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( a.x - b.x, a.y - b.y )
    end operator

    '' :::::
    linkage_ operator - ( _
        byval a as fbext_Vector2(( T_)),        _
        byval k as fbext_TypeName( T_)          _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( a.x - k, a.y - k )
    end operator

    '' :::::
    linkage_ operator * ( _
        byval a as fbext_Vector2(( T_)),        _
        byval b as fbext_Vector2(( T_))         _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( a.x * b.x, a.y * b.y )
    end operator

    '' :::::
    linkage_ operator * ( _
        byval a as fbext_Vector2(( T_)),        _
        byval k as fbext_TypeName( T_)          _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( a.x * k, a.y * k )
    end operator

    '' :::::
    linkage_ operator / ( _
        byval a as fbext_Vector2(( T_)),        _
        byval b as fbext_Vector2(( T_))         _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( a.x / b.x, a.y / b.y )
    end operator

    '' :::::
    linkage_ operator / ( _
        byval a as fbext_Vector2(( T_)),        _
        byval k as fbext_TypeName( T_)          _
    ) as fbext_Vector2(( T_))
        return fbext_Vector2(( T_))( a.x / k, a.y / k )
    end operator

end namespace
:
# endmacro

fbext_InstanciateMulti( fbext_Vector2, fbext_NumericTypes() )

namespace ext.math

    ' OpenGL-friendly type aliases.. should probably put
    ' these elsewhere.. "ext/opengl.bi" ?
    type vec2i as fbext_Vector2( ((integer)) )
    type vec2f as fbext_Vector2( ((single)) )
    type vec2d as fbext_Vector2( ((double)) )

end namespace

# endif ' include guard
