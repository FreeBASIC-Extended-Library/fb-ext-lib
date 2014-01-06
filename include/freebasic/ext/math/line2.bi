''Title: math/line2.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_INCLUDED_MATH_LINE2_BI__
# define FBEXT_INCLUDED_MATH_LINE2_BI__ 1

# include once "ext/math/vector2.bi"

# define fbext_Line2( targs_) fbext_TemplateID( Line2, targs_, (__) )

# macro fbext_Line2_Declare( T_)
:
fbext_TDeclare( fbext_Vector2, ( T_) )

''Namespace: ext.math
namespace ext.math

	''Class: Line2
	''Represents a Line segment defined by 2 Vector2( type )s
	''
    type fbext_Line2(( T_))

		''Variable: a
		''Vector2( type ) representing the start of the line segment.
		''
        a as fbext_Vector2(( T_))

        ''Variable: b
        ''Vector2( type ) representing the end of the line segment.
        b as fbext_Vector2(( T_))

        '' sub: default constructor
        declare constructor ( _
        )

        '' sub: component constructor
        declare constructor ( _
            byval a as fbext_Vector2(( T_)), _
            byval b as fbext_Vector2(( T_))  _
        )

        '' sub: copy constructor
        declare constructor ( _
            byref l as const fbext_Line2(( T_)) _
        )

        '' sub: copy operator let
        declare operator let ( _
            byref l as const fbext_Line2(( T_)) _
        )

    end type

end namespace
:
# endmacro

# macro fbext_Line2_Define( linkage_, T_)
:
fbext_TDefine( fbext_Vector2, linkage_, ( T_) )

namespace ext.math

    '' :::::
    linkage_ constructor fbext_Line2(( T_)) ( _
    )
        dim p as fbext_Vector2(( T_))
        this.a = p
        this.b = p
    end constructor

    '' :::::
    linkage_ constructor fbext_Line2(( T_)) ( _
        byval a as fbext_Vector2(( T_)),         _
        byval b as fbext_Vector2(( T_))          _
    )
        this.a = a
        this.b = b
    end constructor

    '' :::::
    linkage_ constructor fbext_Line2(( T_)) ( _
        byref l as const fbext_Line2(( T_)) _
    )
        this.a = l.a
        this.b = l.b
    end constructor

    '' :::::
    linkage_ operator fbext_Line2(( T_)).let ( _
        byref l as const fbext_Line2(( T_)) _
    )
        this.a = l.a
        this.b = l.b
    end operator

end namespace
:
# endmacro

fbext_InstanciateMulti( fbext_Line2, fbext_NumericTypes() )

# endif ' include guard
