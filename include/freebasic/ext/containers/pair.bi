'' Title: containers/pair.bi
''
'' This header is currently under development and is not ready for usage.
''
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONTAINERS_PAIR_BI__
# define FBEXT_CONTAINERS_PAIR_BI__ -1

# include once "ext/detail/common.bi"

#define fbext_Pair( targs) fbext_TemplateID( Pair, targs, fbext_Pair_DefaultTArgs() )
#define fbext_Pair_DefaultTArgs() (__)((__))

#macro fbext_Pair_Declare( T_, C_ )
:
type fbext_Pair((T_)(C_))ftype as FBEXT_PP_SEQ_ELEM(0, T_)
type fbext_Pair((T_)(C_))stype as FBEXT_PP_SEQ_ELEM(1, T_)

''namespace: ext
namespace ext

    '' Class: fbext_Pair(((T_)(C_)))
    ''  Macro template that generates classes used to store element values
    ''  of type *T_* and type *C_*.
    ''
    '' Parameters:
    ''  T_ - the first type of element value stored in the pair.
    ''  C_ - the second type of element value stored in the pair.
    type fbext_Pair((T_)(C_))
    public:
        ''Sub: default constructor
        ''Constructs a pair using the pair types default constructors.
        declare constructor()

        ''Sub: constructor
        ''Constructs a pair using the passed values.
        declare constructor( byref first as const fbext_Pair((T_)(C_))ftype, byref second as const fbext_Pair((T_)(C_))stype )

        ''Sub: copy constructor
        ''Constructs a pair as a copy of another pair.
        declare constructor( byref rhs as const fbext_Pair((T_)(C_)) )

        ''Sub: operator Let
        declare operator Let( byref rhs as const fbext_Pair((T_)(C_)) )

        ''Variable: first
        first as fbext_Pair((T_)(C_))ftype
        ''Variable: second
        second as fbext_Pair((T_)(C_))stype

        declare destructor()
    end type

    ' These should have const params, but can't for some lingering bug in fbc..
    declare operator < ( byref lhs as fbext_Pair((T_)(C_)), byref rhs as fbext_Pair((T_)(C_)) ) as bool
    declare operator > ( byref lhs as fbext_Pair((T_)(C_)), byref rhs as fbext_Pair((T_)(C_)) ) as bool
    declare operator <>( byref lhs as fbext_Pair((T_)(C_)), byref rhs as fbext_Pair((T_)(C_)) ) as bool
    declare operator = ( byref lhs as fbext_Pair((T_)(C_)), byref rhs as fbext_Pair((T_)(C_)) ) as bool

end namespace
:
# endmacro

# macro fbext_Pair_Define(linkage_, T_, C_)
:
namespace ext

    linkage_ constructor fbext_Pair((T_)(C_)) ( )
        ' Nothing to do
    end constructor

    linkage_ constructor fbext_Pair((T_)(C_)) ( byref first as const fbext_Pair((T_)(C_))ftype, byref second as const fbext_Pair((T_)(C_))stype )
        this.first = first
        this.second = second
    end constructor

    linkage_ constructor fbext_Pair((T_)(C_)) ( byref rhs as const fbext_Pair((T_)(C_)) )
        this.first = rhs.first
        this.second = rhs.second
    end constructor

    linkage_ destructor fbext_Pair((T_)(C_)) ( )
    ' <stylin> these are redundant; fbc will take care of it
    #if typeof(fbext_Pair((T_)(C_))ftype) = string
        this.first = ""
    #endif

    #if typeof(fbext_Pair((T_)(C_))stype) = string
        this.second = ""
    #endif
    end destructor

    linkage_ operator fbext_Pair((T_)(C_)).Let( byref rhs as const fbext_Pair((T_)(C_)) )
        this.first = rhs.first
        this.second = rhs.second
    end operator

    linkage_ operator < ( byref lhs as fbext_Pair((T_)(C_)), byref rhs as fbext_Pair((T_)(C_)) ) as bool

        if lhs.first < rhs.first ANDALSO lhs.second < rhs.second then
            return true
        end if

        return false

    end operator

    linkage_ operator > ( byref lhs as fbext_Pair((T_)(C_)), byref rhs as fbext_Pair((T_)(C_)) ) as bool

        return (not lhs < rhs)

    end operator

    linkage_ operator <>( byref lhs as fbext_Pair((T_)(C_)), byref rhs as fbext_Pair((T_)(C_)) ) as bool

        if lhs.first <> rhs.first ANDALSO lhs.second <> rhs.second then
            return true
        end if

        return false

    end operator

    linkage_ operator = ( byref lhs as fbext_Pair((T_)(C_)), byref rhs as fbext_Pair((T_)(C_)) ) as bool

        return (not lhs <> rhs)

    end operator

end namespace
:
# endmacro

'Not instanciated by default as would be code generated for a ton of combinations if done properly.

# endif ' include guard
