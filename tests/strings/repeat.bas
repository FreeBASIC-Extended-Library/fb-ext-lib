# include once "ext/tests.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

	private sub test_string_repeat
	
		var res = ""
		
		res = ext.strings.repeat("abc", 0)
		ext_assert_STRING_EQUAL("", res)
	
		res = ext.strings.repeat("", 0)
		ext_assert_STRING_EQUAL("", res)
		
		res = ext.strings.repeat("", 3)
		ext_assert_STRING_EQUAL("", res)
		
		res = ext.strings.repeat("abc", 3)
		ext_assert_STRING_EQUAL("abcabcabc", res)
	
	end sub
	
	private sub test_char_repeat
	
		var res = ""
		
		res = ext.strings.repeat(asc("a"), 0)
		ext_assert_STRING_EQUAL("", res)
	
		res = ext.strings.repeat(asc("a"), 3)
		ext_assert_STRING_EQUAL("aaa", res)
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-strings-repeat")
		ext.tests.addTest("string-repeat", @test_string_repeat)
		ext.tests.addTest("char-repeat", @test_char_repeat)
	end sub

end namespace
