''Title: math/projections.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_INCLUDED_MATH_PROJECTIONS_BI__
# define FBEXT_INCLUDED_MATH_PROJECTIONS_BI__ 1

# include once "ext/math/line2.bi"

# macro fbext_GetProjectedPoint_Line2_Declare( T_)
:
fbext_TDeclare( fbext_Line2, ( T_))

''Namespace: ext.math
namespace ext.math

    '' function: GetProjectedPoint
    ''  Finds the closest point on a line from a point in 2D space.
    ''
    '' parameters:
    ''  l - a line.
    ''  p - a point.
    declare function GetProjectedPoint overload ( _
        byval l as fbext_Line2(( T_)), _
        byval p as fbext_Vector2(( T_)) _
    ) as fbext_Vector2(( T_))

end namespace
:
# endmacro

# macro fbext_ClampProjectedPoint_Line2_Declare( T_)
:
fbext_TDeclare( fbext_Line2, ( T_))

namespace ext.math

    '' function: ClampProjectedPoint
    ''  Finds the closest point on a line segment from a point in 2D space.
    ''
    '' parameters:
    ''  l - a line segment.
    ''  p - a point.
    declare function ClampProjectedPoint overload ( _
        byval l as fbext_Line2(( T_)), _
        byval p as fbext_Vector2(( T_)) _
    ) as fbext_Vector2(( T_))

end namespace
:
# endmacro

# macro fbext_GetProjectedPoint_Line2_Define( linkage_, T_)
:
fbext_TDefine( fbext_Line2, linkage_, ( T_))

namespace ext.math

    '' :::::
    linkage_ function GetProjectedPoint overload ( _
        byval l as fbext_Line2(( T_)), _
        byval p as fbext_Vector2(( T_)) _
    ) as fbext_Vector2(( T_))

        var a = l.a, b = l.b

        var AP = p - a
        var ABNormal = (b - a).Normal()

        var d = a.Distance( b )
        var t = ABNormal.Dot( AP )

        return a + ABNormal * t

    end function

end namespace
:
# endmacro

# macro fbext_ClampProjectedPoint_Line2_Define( linkage_, T_)
:
fbext_TDefine( fbext_Line2, linkage_, ( T_))

namespace ext.math

    '' :::::
    linkage_ function ClampProjectedPoint overload ( _
        byval l as fbext_Line2(( T_)), _
        byval p as fbext_Vector2(( T_)) _
    ) as fbext_Vector2(( T_))

        var a = l.a, b = l.b

        var AP = P - a
        var ABNormal = (b - a).Normal()

        var d = a.Distance( b )
        var t = ABNormal.Dot( AP )

        ' projected point (pp) is outside the line ?
        ' [pp a------b   ] ?
        if t <= 0 then return a
        ' [   a------b pp] ?
        if t >= d then return b

        ' projected point is on the line.
        ' [   a--pp--b   ]
        return a + ABNormal * t

    end function

end namespace
:
# endmacro

fbext_InstanciateMulti( fbext_GetProjectedPoint_Line2, fbext_NumericTypes() )
fbext_InstanciateMulti( fbext_ClampProjectedPoint_Line2, fbext_NumericTypes() )

# endif ' include guard
