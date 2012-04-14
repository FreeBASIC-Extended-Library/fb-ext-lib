# include once "ext/testly.bi"
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
		TESTLY_ASSERT_TRUE(test_result( "",		"",		"",		"",		"" ))
		TESTLY_ASSERT_TRUE(test_result( "a",	"",		"",		"",		"a" ))
		TESTLY_ASSERT_TRUE(test_result( "",		"b",	"",		"",		"b" ))
		TESTLY_ASSERT_TRUE(test_result( "",		"",		"c",	"",		"c" ))
		TESTLY_ASSERT_TRUE(test_result( "",		"",		"",		" ",	"  " ))
		TESTLY_ASSERT_TRUE(test_result( "a",	"b",	"c",	" ",	"a b c" ))
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-strings-join")
		ext.testly.addTest("join", @test_join)
	end sub

end namespace
