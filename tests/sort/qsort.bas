# include once "ext/tests.bi"
# include once "ext/algorithms/quicksort.bi"

namespace ext.tests.algorithms

	
	private sub test_quicksort
	
		dim as integer testarray1(0 to 9)

		for n as integer = 0 to 9

			testarray1(n) = 10 - n

		next

		ext.QuickSort( testarray1() )

		for n as integer = 1 to 10

			ext_assert_TRUE( testarray1(n-1) = n )

		next
		
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-algorithms-quicksort")
		ext.tests.addTest("test_quicksort", @test_quicksort)
	end sub

end namespace
