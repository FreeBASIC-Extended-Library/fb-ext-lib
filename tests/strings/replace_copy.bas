# include once "ext/tests.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

	private sub test_string_replacecopy
	
		var res = ""
		
		res = ext.strings.replacecopy("a", "a", "x")
		ext_assert_STRING_EQUAL("x", res)
		
		res = ext.strings.replacecopy("ab", "ab", "x")
		ext_assert_STRING_EQUAL("x", res)
	
		res = ext.strings.replacecopy("abab", "ab", "x")
		ext_assert_STRING_EQUAL("xx", res)
		
		res = ext.strings.replacecopy("abab", "abab", "x")
		ext_assert_STRING_EQUAL("x", res)
		
		res = ext.strings.replacecopy("ababab", "abab", "x")
		ext_assert_STRING_EQUAL("xab", res)
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-strings-replacecopy")
		ext.tests.addTest("string-replacecopy", @test_string_replacecopy)
	end sub

end namespace
