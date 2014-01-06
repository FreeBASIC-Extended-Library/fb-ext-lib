''Title: math/intersects.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_INCLUDED_MATH_INTERSECTS_BI__
# define FBEXT_INCLUDED_MATH_INTERSECTS_BI__ 1

# include once "ext/math/vector2.bi"
# include once "ext/math/line2.bi"

# macro fbext_Math_Intersects_Line2_Declare( T_)
:
fbext_TDeclare( fbext_Vector2, ( T_) )
fbext_TDeclare( fbext_Line2, ( T_) )

''Namespace: ext.math
namespace ext.math

    '' function: Intersects
    ''  Determines if two line segments intersect or overlap. If not, false is
    ''  returned. Otherwise, true is returned.
    declare function Intersects overload ( _
        byval a as fbext_Line2(( T_)),          _
        byval b as fbext_Line2(( T_))           _
    ) as bool

    '' function: Intersects
    ''  Determines if two line segments intersect or overlap. If not, false is
    ''  returned. Otherwise, if the line segments intersect at a point, then
    ''  `solution` is assigned this value. Otherwise, if the line segments
    ''  overlap (are coincident), then `solution` is assigned the value of the
    ''  midpoint of the overlap. In either case, true is returned.
    declare function Intersects overload ( _
        byval a as fbext_Line2(( T_)),          _
        byval b as fbext_Line2(( T_)),          _
        byref solution as fbext_Vector2(( T_))  _
    ) as bool

end namespace
:
# endmacro

# macro fbext_Math_Intersects_Line2_Define( linkage_, T_)
:
fbext_TDefine( fbext_Vector2, linkage_, ( T_) )
fbext_TDefine( fbext_Line2, linkage_, ( T_) )

namespace ext.math

    '' :::::
    linkage_ function Intersects overload ( _
        byval a as fbext_Line2(( T_)),          _
        byval b as fbext_Line2(( T_))           _
    ) as bool

        var v1 = a.b - a.a
        var v2 = b.b - b.a
        var v3 = b.a - a.a
        var cp = (v1.x * v2.y) - (v1.y * v2.x)

        if cp <> 0 then
            var d1 = ((v3.x * v2.y) - (v3.y * v2.x)) / cp
            if 0 <= d1 andalso d1 <= 1 then
                var d2 = ((v3.x * v1.y) - (v3.y * v1.x)) / cp
                if 0 <= d2 andalso d2 <= 1 then
                    return -1
                end if
            end if
        end if

        return 0

    end function

    '' :::::
    linkage_ function Intersects overload ( _
        byval a as fbext_Line2(( T_)),          _
        byval b as fbext_Line2(( T_)),          _
        byref solution as fbext_Vector2(( T_))  _
    ) as bool

        var v1 = a.b - a.a
        var v2 = b.b - b.a
        var v3 = b.a - a.a
        var cp = (v1.x * v2.y) - (v1.y * v2.x)

        if cp <> 0 then
            var d1 = ((v3.x * v2.y) - (v3.y * v2.x)) / cp
            if 0 <= d1 andalso d1 <= 1 then
                var d2 = ((v3.x * v1.y) - (v3.y * v1.x)) / cp
                if 0 <= d2 andalso d2 <= 1 then
                    var m1 = iif( v1.x <> 0.0, v1.y / v1.x, 10000000000.0 )
                    var m2 = iif( v2.x <> 0.0, v2.y / v2.x, 10000000000.0 )

                    var c1 = a.a.y - (m1 * a.a.x)
                    var c2 = b.a.y - (m2 * b.a.x)
                    var ant = 1 / -(m1 - m2)
                    solution.x = -(c2 - c1) * ant
                    solution.y = ((m2 * c1) - (m1 * c2)) * ant

                    return -1
                end if
            end if
        end if

        return 0

    end function

end namespace
:
# endmacro

fbext_InstanciateMulti( fbext_Math_Intersects_Line2, fbext_NumericTypes() )

namespace ext.math

    '' ::::: (it puts the lotion in the basket, Dr_D)
    private function LinesIntersect ( _
        byref ip as vec2f, _
        byval p1 as vec2f, _
        byval p2 as vec2f, _
        byval p3 as vec2f, _
        byval p4 as vec2f _
    ) as integer

        var v1 = p2 - p1
        var v2 = p4 - p3
        var v3 = p3 - p1
        var cp = (v1.x * v2.y) - (v1.y * v2.x)

        if cp <> 0 then
            var d1 = ((v3.x * v2.y) - (v3.y * v2.x)) / cp
            if 0 <= d1 andalso d1 <= 1 then
                var d2 = ((v3.x * v1.y) - (v3.y * v1.x)) / cp
                if 0 <= d2 andalso d2 <= 1 then
                    var m1 = iif( v1.x <> 0.0, v1.y / v1.x, 10000000000.0 )
                    var m2 = iif( v2.x <> 0.0, v2.y / v2.x, 10000000000.0 )

                    var c1 = p1.y - (m1 * p1.x)
                    var c2 = p3.y - (m2 * p3.x)
                    var ant = 1 / -(m1 - m2)
                    ip.x = -(c2 - c1) * ant
                    ip.y = ((m2 * c1) - (m1 * c2)) * ant

                    return -1
                end if
            end if
        end if

        return 0

    end function

end namespace

# endif ' include guard

