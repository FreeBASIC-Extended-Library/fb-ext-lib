# include once "ext/tests.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

	private function test_result (byref a as string, byref b as string, byref c as string, byref glue as string, byref result as string) as ext.bool
	
		static array(2) as string
		
		array(0) = a
		array(1) = b
		array(2) = c
		
		return result = ext.strings.join(array(), glue)
	
	end function
	
	private sub test_join
	
		'                               a    	b		c		glue	res
		ext_assert_TRUE(test_result( "",		"",		"",		"",		"" ))
		ext_assert_TRUE(test_result( "a",	"",		"",		"",		"a" ))
		ext_assert_TRUE(test_result( "",		"b",	"",		"",		"b" ))
		ext_assert_TRUE(test_result( "",		"",		"c",	"",		"c" ))
		ext_assert_TRUE(test_result( "",		"",		"",		" ",	"  " ))
		ext_assert_TRUE(test_result( "a",	"b",	"c",	" ",	"a b c" ))
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-strings-join")
		ext.tests.addTest("join", @test_join)
	end sub

end namespace
