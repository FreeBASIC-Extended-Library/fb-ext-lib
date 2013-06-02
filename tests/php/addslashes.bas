# include once "ext/tests.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    '' :::::
    private sub API
        dim result as string = ext.php.AddSlashes("")
    end sub
    
    '' :::::
    private sub Test
    
        ' this is just a call to ext.php.AddCSlashes, so only the characters
        ' passed to it need checking (quote, double-qoute and backslash)..
        ext_assert_TRUE( !"[\\'] [\\\"] [\\\\]" = ext.php.AddSlashes(!"['] [\"] [\\]") )
    
    end sub
    
    '' :::::
	private sub register constructor
		ext.tests.addSuite("ext-php-addslashes")
		ext.tests.addTest("API", @API)
		ext.tests.addTest("Test", @Test)
	end sub

end namespace
