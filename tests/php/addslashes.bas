# include once "ext/testly.bi"
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
        TESTLY_ASSERT_TRUE( !"[\\'] [\\\"] [\\\\]" = ext.php.AddSlashes(!"['] [\"] [\\]") )
    
    end sub
    
    '' :::::
	private sub register constructor
		ext.testly.addSuite("ext-php-addslashes")
		ext.testly.addTest("API", @API)
		ext.testly.addTest("Test", @Test)
	end sub

end namespace
