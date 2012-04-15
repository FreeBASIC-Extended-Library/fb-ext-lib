# include once "ext/testly.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

	private sub testStringResult
	
		dim test_strings(4, 1) as string = _
		{ _
			{ "", "" }, _
			{ "a", "a" }, _
			{ "ab", "ba" }, _
			{ "abc", "cba" }, _
			{ "abcd", "dcba" } _
		}
		
		for i as integer = lbound(test_strings) to ubound(test_strings)
			var res = test_strings(i, 0)
			TESTLY_ASSERT_EQUAL(test_strings(i, 1), ext.strings.ReverseCopy(res))
		next
	
	end sub
	
	private sub testVarLenArrayResult
	
		dim test_strings(4) as const string = { "", "a", "ab", "abc", "abcd" }
		dim target_strings(4) as string = { "", "a", "ba", "cba", "dcba" }
		dim result() as string
		
		ext.strings.ReverseCopy(test_strings(), result())
		
		for i as integer = lbound(test_strings) to ubound(test_strings)
			TESTLY_ASSERT_EQUAL(target_strings(i), result(i))
		next
	
	end sub
	
	private sub testVarLenArrayResultWithIndex
	
		dim test_strings(4) as const string = { "", "a", "ab", "abc", "abcd" }
		dim target_strings(4) as string = { "", "a", "ba", "cba", "dcba" }
		dim result(9) as string
		
		dim index as integer = 5
		ext.strings.ReverseCopy(test_strings(), result(), index)
		
		for i as integer = lbound(test_strings) to ubound(test_strings)
			TESTLY_ASSERT_EQUAL(target_strings(i), result(index))
			index += 1
		next
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-strings-ReverseCopy")
		ext.testly.addTest("testStringResult", @testStringResult)
		ext.testly.addTest("testVarLenArrayResult", @testVarLenArrayResult)
		ext.testly.addTest("testVarLenArrayResultWithIndex", @testVarLenArrayResultWithIndex)
	end sub

end namespace
