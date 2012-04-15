# define fbext_NoBuiltinInstanciations() 1

# include once "ext/testly.bi"
# include once "ext/containers/list.bi"

type UDT
public:
	' elements of ext.List:

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

private constructor UDT ( )
end constructor

private constructor UDT ( byref x as const UDT )
	this.s = x.s
end constructor

private constructor UDT ( byref s as const string )
	this.s = s
end constructor

fbext_Instanciate(fbext_List, ((UDT)))

namespace ext.tests.containers

	private sub test_ListPushBack

		var list = fbext_List( ((UDT)) )

		list.PushBack(UDT("one"))
		TESTLY_ASSERT_TRUE( 1 = list.Size() )
		TESTLY_ASSERT_TRUE( "one" = list.Front()->s )
		TESTLY_ASSERT_TRUE( "one" = list.Back()->s )

		list.PushBack(UDT("two"))
		TESTLY_ASSERT_TRUE( 2 = list.Size() )
		TESTLY_ASSERT_TRUE( "one" = list.Front()->s )
		TESTLY_ASSERT_TRUE( "two" = list.Back()->s )

		list.PushBack(UDT("three"))
		TESTLY_ASSERT_TRUE( 3 = list.Size() )
		TESTLY_ASSERT_TRUE( "one" = list.Front()->s )
		TESTLY_ASSERT_TRUE( "three" = list.Back()->s )

	end sub

	private sub test_ListInsert

		var list = fbext_List( ((UDT)) )

		list.Insert(list.End_(), 5, UDT("x"))
		TESTLY_ASSERT_TRUE( 5 = list.Size() )

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-containers-list-udt")
		ext.testly.addTest("test_ListPushBack", @test_ListPushBack)
		ext.testly.addTest("test_ListInsert", @test_ListInsert)
	end sub

end namespace
