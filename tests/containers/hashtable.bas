/'# include once "ext/testly.bi"
# include once "ext/containers/hashtable.bi"

namespace ext.tests.containers

	private sub test_insert_count

		var ht = FBEXT_HASHTABLE(integer)(15)

		for n as integer = 1 to 15
			TESTLY_ASSERT_TRUE( ht.count = (n-1) )

			ht.Insert( "Test" & space(n) & n, n )

			TESTLY_ASSERT_TRUE( ht.count = n )
		next

	end sub

	private sub test_collisions

		var ht = FBEXT_HASHTABLE(integer)(15)

		ht.Insert("Testing1", 42)
		ht.Insert("Testing2", 32)

		TESTLY_ASSERT_TRUE( ht.count = 2 )

		ht.Insert("Testing1", 12)

		TESTLY_ASSERT_TRUE( *ht.Find("Testing1") <> 12 )

		TESTLY_ASSERT_TRUE( ht.count = 2 )

	end sub

	private sub test_verify_bykey

		var ht = FBEXT_HASHTABLE(integer)(15)

		for n as integer = 1 to 15

			ht.Insert( "Test" & space(n) & n, n )

		next

		for n as integer = 1 to 15

			var x = *ht.Find( "Test" & space(n) & n )

			TESTLY_ASSERT_TRUE( n = x )

		next

		TESTLY_ASSERT_TRUE( ext.null = ht.Find("FBEXT Rocks") )

	end sub

	private sub test_verify_byval

		var ht = FBEXT_HASHTABLE(integer)(15)

		for n as integer = 1 to 15

			ht.Insert( "Test" & space(n) & n, n )

		next

		var y = 0

		for n as integer = 1 to 15

			y = n

			dim as string x = ht.Find( y )

			TESTLY_ASSERT_TRUE( x = "Test" & space(n) & n)

		next

		y = 16

		TESTLY_ASSERT_TRUE( "" = ht.Find(y) )

	end sub

	private sub register 'constructor
		ext.testly.addSuite("ext-containers-hashtable")
		ext.testly.addTest("test_insert_count", @test_insert_count)
		ext.testly.addTest("test_verify_bykey", @test_verify_bykey)
		ext.testly.addTest("test_verify_byval", @test_verify_byval)
		ext.testly.addTest("test_collisions", @test_collisions)
	end sub

end namespace

'/
