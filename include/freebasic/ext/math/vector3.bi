''Title: math/vector3.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MATH_VECTOR3_BI__
# define FBEXT_MATH_VECTOR3_BI__ -1

# include once "ext/math/detail/common.bi"

# define fbext_Vector3( targs_) fbext_TemplateID( Vector3, targs_, (__) )

# macro fbext_Vector3_Declare( T_)
:
namespace ext.math
	''Class: Vector3
	''Represents a 3 dimensional point of type.
    type fbext_Vector3(( T_))
        x as fbext_TypeName( T_)
        y as fbext_TypeName( T_)
        z as fbext_TypeName( T_)
        
        '' sub: default constructor
        declare constructor ( _
        )
        
        '' sub: component constructor
        declare constructor ( _
            byval x as fbext_TypeName( T_), _
            byval y as fbext_TypeName( T_), _
            byval z as fbext_TypeName( T_)  _
        )
        
        '' sub: copy constructor
        declare constructor ( _
            byref v as const fbext_Vector3(( T_)) _
        )
        
        '' sub: copy operator let
        declare operator let ( _
            byref v as const fbext_Vector3(( T_)) _
        )
		
		'' sub: operator cast as string
		declare operator cast () as string
        
        '' function: Magnitude
        declare const function Magnitude ( _
        ) as double
        
        '' sub: Normalize
        declare sub Normalize ( _
        )
        
        '' function: Normal
        declare const function Normal ( _
        ) as fbext_Vector3(( T_))
        
        '' function: Dot
        declare const function Dot ( _
            byref v as const fbext_Vector3(( T_)) _
        ) as double
        
        '' function: Cross
        declare const function Cross ( _
            byref v as const fbext_Vector3(( T_)) _
        ) as fbext_Vector3(( T_))
        
        declare operator += ( byval v as fbext_Vector3(( T_)) )
        declare operator += ( byval k as fbext_TypeName( T_) )
        declare operator -= ( byval v as fbext_Vector3(( T_)) )
        declare operator -= ( byval k as fbext_TypeName( T_) )
        declare operator *= ( byval v as fbext_Vector3(( T_)) )
        declare operator *= ( byval k as fbext_TypeName( T_) )
        declare operator /= ( byval v as fbext_Vector3(( T_)) )
        declare operator /= ( byval k as fbext_TypeName( T_) )
        
        '' function: Distance
        ''  Returns the distance between the endpoints of the vector and
        ''  another.
        declare const function Distance ( byref v as const fbext_Vector3(( T_)) ) as double
        
        '' function: AngleBetween
        ''  Returns the angle between the vector and another.
        declare const function AngleBetween ( byref v as const fbext_Vector3(( T_)) ) as double
    
    end type
    
    '' function: Distance
    ''  Returns the distance between the endpoints of two vectors.
    declare function Distance overload ( _
        byref a as const fbext_Vector3(( T_)),    _
        byref b as const fbext_Vector3(( T_))     _
    ) as double
    
    '' function: AngleBetween
    ''  Returns the angle between two vectors.
    declare function AngleBetween overload ( _
        byref a as const fbext_Vector3(( T_)),    _
        byref b as const fbext_Vector3(( T_))     _
    ) as double
    
    '' function: global operator - (negate)
    ''  Returns a * -1.
    declare operator - ( _
        byval a as fbext_Vector3(( T_))     _
    ) as fbext_Vector3(( T_))
    
    '' function: global operator +
    ''  Returns a vector whose components are the sum of the corresponding
    ''  components of two vectors.
    declare operator + ( _
        byval a as fbext_Vector3(( T_)),    _
        byval b as fbext_Vector3(( T_))     _
    ) as fbext_Vector3(( T_))
    
    '' function: global operator +
    ''  Returns a vector whose components are the sum of the corresponding
    ''  components of a vector and a scalar.
    declare operator + ( _
        byval a as fbext_Vector3(( T_)),    _
        byval k as fbext_TypeName( T_)      _
    ) as fbext_Vector3(( T_))
    
    '' function: global operator -
    ''  Returns a vector whose components are the difference of the
    ''  corresponding components of two vectors.
    declare operator - ( _
        byval a as fbext_Vector3(( T_)),    _
        byval b as fbext_Vector3(( T_))     _
    ) as fbext_Vector3(( T_))
    
    '' function: global operator -
    ''  Returns a vector whose components are the difference of the
    ''  corresponding components of a vector and a scalar.
    declare operator - ( _
        byval a as fbext_Vector3(( T_)),    _
        byval k as fbext_TypeName( T_)      _
    ) as fbext_Vector3(( T_))
    
    '' function: global operator *
    ''  Returns a vector whose components are the product of the
    ''  corresponding components of two vectors.
    declare operator * ( _
        byval a as fbext_Vector3(( T_)),    _
        byval b as fbext_Vector3(( T_))     _
    ) as fbext_Vector3(( T_))
    
    '' function: global operator *
    ''  Returns a vector whose components are the product of the
    ''  corresponding components of a vector and a scalar.
    declare operator * ( _
        byval a as fbext_Vector3(( T_)),    _
        byval k as fbext_TypeName( T_)      _
    ) as fbext_Vector3(( T_))
    
    '' function: global operator /
    ''  Returns a vector whose components are the quotient of the
    ''  corresponding components of two vectors.
    declare operator / ( _
        byval a as fbext_Vector3(( T_)),    _
        byval b as fbext_Vector3(( T_))     _
    ) as fbext_Vector3(( T_))
    
    '' function: global operator /
    ''  Returns a vector whose components are the quotient of the
    ''  corresponding components of a vector and a scalar.
    declare operator / ( _
        byval a as fbext_Vector3(( T_)),    _
        byval k as fbext_TypeName( T_)      _
    ) as fbext_Vector3(( T_))
    
end namespace
:
# endmacro

# macro fbext_Vector3_Define( linkage_, T_)
:
namespace ext.math

	'' :::::
	linkage_ operator fbext_Vector3(( T_)).cast() as string
		return "{x:" & this.x & ", y:" & this.y & ", z:" & this.z & "}"
	end operator

    '' :::::
    linkage_ constructor fbext_Vector3(( T_)) ( _
    )
        dim value as fbext_TypeName( T_)
        this.x = value
        this.y = value
        this.z = value
    end constructor
    
    '' :::::
    linkage_ constructor fbext_Vector3(( T_)) ( _
        byval x as fbext_TypeName( T_),         _
        byval y as fbext_TypeName( T_),         _
        byval z as fbext_TypeName( T_)          _
    )
        this.x = x
        this.y = y
        this.z = z
    end constructor
    
    '' :::::
    linkage_ constructor fbext_Vector3(( T_)) ( _
        byref v as const fbext_Vector3(( T_)) _
    )
        this.x = v.x
        this.y = v.y
        this.z = v.z
    end constructor
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_)).let ( _
        byref v as const fbext_Vector3(( T_)) _
    )
        this.x = v.x
        this.y = v.y
        this.z = v.z
    end operator
    
    '' :::::
    linkage_ function fbext_Vector3(( T_)).Magnitude ( _
    ) as double
        function = sqr( this.x^2 + this.y^2 + this.z^2 )
    end function
    
    '' :::::
    linkage_ sub fbext_Vector3(( T_)).Normalize ( _
    )
        var m = this.Magnitude()
        if ( m <> 0 ) then
            this.x /= m
            this.y /= m
            this.z /= m
        end if
    end sub
    
    '' :::::
    linkage_ function fbext_Vector3(( T_)).Normal ( _
    ) as fbext_Vector3(( T_))
        dim tmp as fbext_Vector3(( T_)) = this
        tmp.Normalize()
        return tmp
    end function
    
    '' :::::
    linkage_ function fbext_Vector3(( T_)).Dot ( _
        byref v as const fbext_Vector3(( T_))   _
    ) as double
        function = this.x * v.x + this.y * v.y + this.z * v.z
    end function
    
    '' :::::
    linkage_ function fbext_Vector3(( T_)).Cross ( _
        byref v as const fbext_Vector3(( T_))   _
    ) as fbext_Vector3(( T_))
    
        return fbext_Vector3(( T_))( _
            (this.y * v.z) - (v.y * this.z), _
            (this.z * v.x) - (v.z * this.x), _
            (this.x * v.y) - (v.x * this.y) _
        )
    end function
    
    '' :::::
    linkage_ function fbext_Vector3(( T_)).Distance ( _
        byref v as const fbext_Vector3(( T_))   _
    ) as double
        function = ext.math.Distance( this, v )
    end function
    
    '' :::::
    linkage_ function fbext_Vector3(( T_)).AngleBetween ( _
        byref v as const fbext_Vector3(( T_))   _
    ) as double
        function = ext.math.AngleBetween( this, v )
    end function
    
    '' :::::
    linkage_ function Distance ( _
        byref a as const fbext_Vector3(( T_)),  _
        byref b as const fbext_Vector3(( T_))   _
    ) as double
        function = sqr( (b.x - a.x)^2 + (b.y - a.y)^2 + (b.z - a.z)^2 )
    end function
    
    '' :::::
    linkage_ function AngleBetween ( _
        byref a as const fbext_Vector3(( T_)),        _
        byref b as const fbext_Vector3(( T_))         _
    ) as double
        function = acos( a.dot(b) / (a.Magnitude() * b.Magnitude()) )
    end function
    
    '' :::::
    linkage_ operator - ( _
        byval a as fbext_Vector3(( T_))     _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( -a.x, -a.y, -a.z )
    end operator
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_)).+= ( _
        byval v as fbext_Vector3(( T_))         _
    )
        this.x += v.x
        this.y += v.y
        this.z += v.z
    end operator
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_)).+= ( _
        byval k as fbext_TypeName( T_)          _
    )
        this.x += k
        this.y += k
        this.z += k
    end operator
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_)).-= ( _
        byval v as fbext_Vector3(( T_))         _
    )
        this.x -= v.x
        this.y -= v.y
        this.z -= v.z
    end operator
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_)).-= ( _
        byval k as fbext_TypeName( T_)          _
    )
        this.x -= k
        this.y -= k
        this.z -= k
    end operator
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_)).*= ( _
        byval v as fbext_Vector3(( T_))         _
    )
        this.x *= v.x
        this.y *= v.y
        this.z *= v.z
    end operator
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_)).*= ( _
        byval k as fbext_TypeName( T_)          _
    )
        this.x *= k
        this.y *= k
        this.z *= k
    end operator
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_))./= ( _
        byval v as fbext_Vector3(( T_))         _
    )
        this.x /= v.x
        this.y /= v.y
        this.z /= v.z
    end operator
    
    '' :::::
    linkage_ operator fbext_Vector3(( T_))./= ( _
        byval k as fbext_TypeName( T_)          _
    )
        this.x /= k
        this.y /= k
        this.z /= k
    end operator
    
    '' :::::
    linkage_ operator + ( _
        byval a as fbext_Vector3(( T_)),        _
        byval b as fbext_Vector3(( T_))         _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( a.x + b.x, a.y + b.y, a.z + b.z )
    end operator
    
    '' :::::
    linkage_ operator + ( _
        byval a as fbext_Vector3(( T_)),        _
        byval k as fbext_TypeName( T_)          _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( a.x + k, a.y + k, a.z + k )
    end operator
    
    '' :::::
    linkage_ operator - ( _
        byval a as fbext_Vector3(( T_)),        _
        byval b as fbext_Vector3(( T_))         _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( a.x - b.x, a.y - b.y, a.z - b.z )
    end operator
    
    '' :::::
    linkage_ operator - ( _
        byval a as fbext_Vector3(( T_)),        _
        byval k as fbext_TypeName( T_)          _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( a.x - k, a.y - k, a.z - k )
    end operator

    '' :::::
    linkage_ operator * ( _
        byval a as fbext_Vector3(( T_)),        _
        byval b as fbext_Vector3(( T_))         _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( a.x * b.x, a.y * b.y, a.z * b.z )
    end operator
    
    '' :::::
    linkage_ operator * ( _
        byval a as fbext_Vector3(( T_)),        _
        byval k as fbext_TypeName( T_)          _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( a.x * k, a.y * k, a.z * k )
    end operator

    '' :::::
    linkage_ operator / ( _
        byval a as fbext_Vector3(( T_)),        _
        byval b as fbext_Vector3(( T_))         _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( a.x / b.x, a.y / b.y, a.z / b.z )
    end operator
    
    '' :::::
    linkage_ operator / ( _
        byval a as fbext_Vector3(( T_)),        _
        byval k as fbext_TypeName( T_)          _
    ) as fbext_Vector3(( T_))
        return fbext_Vector3(( T_))( a.x / k, a.y / k, a.z / k )
    end operator

end namespace
:
# endmacro

fbext_InstanciateMulti( fbext_Vector3, fbext_NumericTypes() )

namespace ext.math

    ' OpenGL-friendly type aliases.. should probably put
    ' these elsewhere.. "ext/opengl.bi" ?
    type vec3i as fbext_Vector3( ((integer)) )
    type vec3f as fbext_Vector3( ((single)) )
    type vec3d as fbext_Vector3( ((double)) )

end namespace

# endif ' include guard
