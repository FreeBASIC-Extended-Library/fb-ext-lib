# include once "ext/testly.bi"
# include once "ext/algorithms/gnomesort.bi"

namespace ext.tests.algorithms

	private sub test_gnome
	
		dim as integer testarray1(0 to 9)

		for n as integer = 0 to 9

			testarray1(n) = 10 - n

		next

		ext.GnomeSort( testarray1() )

		for n as integer = 1 to 10

			TESTLY_ASSERT_TRUE( testarray1(n-1) = n )

		next
		
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-algorithms-gnomesort")
		ext.testly.addTest("gnome", @test_gnome)
	end sub

end namespace
