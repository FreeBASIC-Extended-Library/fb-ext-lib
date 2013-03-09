# define fbext_NoBuiltinInstanciations() 1

# include once "ext/testly.bi"
# include once "ext/containers/array.bi"

type UDT
public:
    ' elements of ext.Array:

    ' 1. need to be publically default- and copy- constructible, and support
    ' the explicit syntax for those operations: var x = UDT(), y = UDT(x).
    '
    declare constructor ( )
    declare constructor ( byref x as const UDT )

    ' 2. need to be publically copy-assignable and destructible. the compiler-
    ' generated versions are fine for this UDT.
    '
    '   declare destructor ( )
    '   declare operator let ( byref x as const UDT )

    ' some fluff.
    '
    declare constructor ( byref s as const string )
    s as string
end type

' Array requires items to be < comparable to support sorting.
operator < ( byref lhs as const UDT, byref rhs as const UDT ) as ext.bool
    return lhs.s < rhs.s
end operator

private constructor UDT ( )
end constructor

private constructor UDT ( byref x as const UDT )
    this.s = x.s
end constructor

private constructor UDT ( byref s as const string )
    this.s = s
end constructor

fbext_Instanciate(fbext_Array, ((UDT)))

namespace ext.tests.containers

    private sub test_arraypushback

        var array = fbext_Array( ((UDT)) )

        array.PushBack(UDT("one"))
        TESTLY_ASSERT_TRUE( 1 = array.Size() )
        TESTLY_ASSERT_TRUE( "one" = array.Front()->s )
        TESTLY_ASSERT_TRUE( "one" = array.Back()->s )

        array.PushBack(UDT("two"))
        TESTLY_ASSERT_TRUE( 2 = array.Size() )
        TESTLY_ASSERT_TRUE( "one" = array.Front()->s )
        TESTLY_ASSERT_TRUE( "two" = array.Back()->s )

        array.PushBack(UDT("three"))
        TESTLY_ASSERT_TRUE( 3 = array.Size() )
        TESTLY_ASSERT_TRUE( "one" = array.Front()->s )
        TESTLY_ASSERT_TRUE( "three" = array.Back()->s )

    end sub

    private sub test_arrayinsert

        var array = fbext_Array( ((UDT)) )

        array.Insert(array.End_(), 5, UDT("x"))
        TESTLY_ASSERT_TRUE( 5 = array.Size() )

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-containers-array-udt")
        ext.testly.addTest("test_arraypushback", @test_arraypushback)
        ext.testly.addTest("test_arrayinsert", @test_arrayinsert)
    end sub

end namespace
