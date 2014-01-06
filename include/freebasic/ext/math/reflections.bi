''Title: math/reflections.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_INCLUDED_MATH_REFLECTIONS_BI__
# define FBEXT_INCLUDED_MATH_REFLECTIONS_BI__ 1

# include once "ext/math/vector2.bi"
# include once "ext/math/line2.bi"

# macro fbext_GetReflectedVector_Declare( T_)
:
fbext_TDeclare( fbext_Vector2, ( T_))
fbext_TDeclare( fbext_Line2, ( T_))

''Namespace: ext.math
namespace ext.math

    '' function: GetReflectedVector
    declare function GetReflectedVector overload ( _
        byval v as fbext_Vector2(( T_)), _
        byval surfaceNormal as fbext_Vector2(( T_)) _
    ) as fbext_Vector2(( T_))

    '' function: GetReflectedVector
    declare function GetReflectedVector overload ( _
        byval v as fbext_Vector2(( T_)), _
        byval l as fbext_Line2(( T_)) _
    ) as fbext_Vector2(( T_))

end namespace
:
# endmacro

# macro fbext_GetReflectedVector_Define( linkage_, T_)
:
fbext_TDefine( fbext_Vector2, linkage_, ( T_))
fbext_TDefine( fbext_Line2, linkage_, ( T_))

namespace ext.math

    '' :::::
    linkage_ function GetReflectedVector overload ( _
        byval v as fbext_Vector2(( T_)), _
        byval surfaceNormal as fbext_Vector2(( T_)) _
    ) as fbext_Vector2(( T_))

        return surfaceNormal * 2 * v.Dot( surfaceNormal ) - v

    end function

    '' :::::
    linkage_ function GetReflectedVector overload ( _
        byval v as fbext_Vector2(( T_)), _
        byval l as fbext_Line2(( T_)) _
    ) as fbext_Vector2(( T_))

        return GetReflectedVector( v, l.b - l.a )

    end function

end namespace
:
# endmacro

fbext_InstanciateMulti( fbext_GetReflectedVector, fbext_NumericTypes() )

# endif ' include guard
