# include once "ext/testly.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    '' :::::
    private sub API
        dim result as string = ext.php.AddCSlashes("", "")
    end sub
    
    '' :::::
    private sub TestNoEscCharsGiven
    
        TESTLY_ASSERT_TRUE( "" = ext.php.AddCSlashes("", "") )
        TESTLY_ASSERT_TRUE( "abc" = ext.php.AddCSlashes("abc", "") )
    
    end sub
    
    '' :::::
    private sub TestEscCharNotFound
    
        TESTLY_ASSERT_TRUE( "" = ext.php.AddCSlashes("", "*") )
        TESTLY_ASSERT_TRUE( "text" = ext.php.AddCSlashes("text", "*") )
        
        TESTLY_ASSERT_TRUE( "\:" = ext.php.AddCSlashes(":", ":*") )
        TESTLY_ASSERT_TRUE( "\:" = ext.php.AddCSlashes(":", "*:") )
    
    end sub
    
    '' :::::
    private sub TestSingleEscChar
        TESTLY_ASSERT_TRUE( "\:a\:\:bc\:" = ext.php.AddCSlashes(":a::bc:", ":") )
    end sub
    
    '' :::::
    private sub TestMultipleEscChars
    
        ' inner, escaped to avoid "possible escape sequence" warning..
        TESTLY_ASSERT_TRUE( !"[\\a][\\b\\c]" = ext.php.AddCSlashes("[a][bc]", "abc") )
        TESTLY_ASSERT_TRUE( !"[\\a][\\b\\c]" = ext.php.AddCSlashes("[a][bc]", "cba") )
        
        ' outer..
        TESTLY_ASSERT_TRUE( "\[a\]" = ext.php.AddCSlashes("[a]", "[]") )
        TESTLY_ASSERT_TRUE( "\[a\]" = ext.php.AddCSlashes("[a]", "][") )
    
    end sub
    
    '' :::::
	private sub register constructor
		ext.testly.addSuite("ext-php-addcslashes")
		ext.testly.addTest("API", @API)
		ext.testly.addTest("TestNoEscCharsGiven", @TestNoEscCharsGiven)
		ext.testly.addTest("TestEscCharNotFound", @TestEscCharNotFound)
		ext.testly.addTest("TestSingleEscChar", @TestSingleEscChar)
		ext.testly.addTest("TestMultipleEscChars", @TestMultipleEscChars)
	end sub

end namespace
