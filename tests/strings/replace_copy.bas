# include once "ext/testly.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

	private sub test_string_replacecopy
	
		var res = ""
		
		res = ext.strings.replacecopy("a", "a", "x")
		TESTLY_ASSERT_STRING_EQUAL("x", res)
		
		res = ext.strings.replacecopy("ab", "ab", "x")
		TESTLY_ASSERT_STRING_EQUAL("x", res)
	
		res = ext.strings.replacecopy("abab", "ab", "x")
		TESTLY_ASSERT_STRING_EQUAL("xx", res)
		
		res = ext.strings.replacecopy("abab", "abab", "x")
		TESTLY_ASSERT_STRING_EQUAL("x", res)
		
		res = ext.strings.replacecopy("ababab", "abab", "x")
		TESTLY_ASSERT_STRING_EQUAL("xab", res)
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-strings-replacecopy")
		ext.testly.addTest("string-replacecopy", @test_string_replacecopy)
	end sub

end namespace
