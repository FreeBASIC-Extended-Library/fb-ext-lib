# include once "ext/testly.bi"
# include once "ext/algorithms/quicksort.bi"

namespace ext.tests.algorithms

	
	private sub test_quicksort
	
		dim as integer testarray1(0 to 9)

		for n as integer = 0 to 9

			testarray1(n) = 10 - n

		next

		ext.QuickSort( testarray1() )

		for n as integer = 1 to 10

			TESTLY_ASSERT_TRUE( testarray1(n-1) = n )

		next
		
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-algorithms-quicksort")
		ext.testly.addTest("test_quicksort", @test_quicksort)
	end sub

end namespace
