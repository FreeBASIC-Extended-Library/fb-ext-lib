# include once "ext/testly.bi"
# include once "ext/memory/allocator.bi"

static shared s_defctor_count as ext.SizeType = 0
static shared s_copyctor_count as ext.SizeType = 0
static shared s_dtor_count as ext.SizeType = 0

type T
    declare constructor ( byval n as integer = 0 )
    declare constructor ( byref x as const T )
    declare destructor ( )
    n as integer
end type

private constructor T ( byval n as integer )
    s_defctor_count += 1
    this.n = n
end constructor

private constructor T ( byref x as const T )
    s_copyctor_count += 1
end constructor

private destructor T ( )
    s_dtor_count += 1
end destructor

fbext_Instanciate(fbext_Allocator, ((T)))

namespace ext.tests.memory

	private sub test

	    var alloc = ext.fbext_Allocator(((T)))

	    var p = alloc.Allocate(3)

	    TESTLY_ASSERT_TRUE( s_defctor_count = 0 )
	    TESTLY_ASSERT_EQUAL( s_copyctor_count, 0 )
	    TESTLY_ASSERT_EQUAL( s_dtor_count, 0 )

	    var tmp = T(420)

	    for i as integer = 0 to 3-1
    	    alloc.Construct(@p[i], tmp)
	    next i

	    TESTLY_ASSERT_EQUAL( s_defctor_count, 1 )
	    TESTLY_ASSERT_EQUAL( s_copyctor_count, 3 )
	    TESTLY_ASSERT_EQUAL( s_dtor_count, 0 )

	    for i as integer = 0 to 3-1
    	    alloc.Destroy(@p[i])
	    next i

	    TESTLY_ASSERT_EQUAL( s_defctor_count, 1 )
	    TESTLY_ASSERT_EQUAL( s_copyctor_count, 3 )
	    TESTLY_ASSERT_EQUAL( s_dtor_count, 3 )

	    alloc.DeAllocate(p, 3)

	    TESTLY_ASSERT_EQUAL( s_defctor_count, 1 )
	    TESTLY_ASSERT_EQUAL( s_copyctor_count, 3 )
	    TESTLY_ASSERT_EQUAL( s_dtor_count, 3 )

	end sub

	private sub register constructor
		ext.testly.addSuite("ext-memory-allocator")
		ext.testly.addTest("test", @test)
	end sub

end namespace
