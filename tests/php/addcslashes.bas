# include once "ext/tests.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    '' :::::
    private sub API
        dim result as string = ext.php.AddCSlashes("", "")
    end sub
    
    '' :::::
    private sub TestNoEscCharsGiven
    
        ext_assert_TRUE( "" = ext.php.AddCSlashes("", "") )
        ext_assert_TRUE( "abc" = ext.php.AddCSlashes("abc", "") )
    
    end sub
    
    '' :::::
    private sub TestEscCharNotFound
    
        ext_assert_TRUE( "" = ext.php.AddCSlashes("", "*") )
        ext_assert_TRUE( "text" = ext.php.AddCSlashes("text", "*") )
        
        ext_assert_TRUE( "\:" = ext.php.AddCSlashes(":", ":*") )
        ext_assert_TRUE( "\:" = ext.php.AddCSlashes(":", "*:") )
    
    end sub
    
    '' :::::
    private sub TestSingleEscChar
        ext_assert_TRUE( "\:a\:\:bc\:" = ext.php.AddCSlashes(":a::bc:", ":") )
    end sub
    
    '' :::::
    private sub TestMultipleEscChars
    
        ' inner, escaped to avoid "possible escape sequence" warning..
        ext_assert_TRUE( !"[\\a][\\b\\c]" = ext.php.AddCSlashes("[a][bc]", "abc") )
        ext_assert_TRUE( !"[\\a][\\b\\c]" = ext.php.AddCSlashes("[a][bc]", "cba") )
        
        ' outer..
        ext_assert_TRUE( "\[a\]" = ext.php.AddCSlashes("[a]", "[]") )
        ext_assert_TRUE( "\[a\]" = ext.php.AddCSlashes("[a]", "][") )
    
    end sub
    
    '' :::::
	private sub register constructor
		ext.tests.addSuite("ext-php-addcslashes")
		ext.tests.addTest("API", @API)
		ext.tests.addTest("TestNoEscCharsGiven", @TestNoEscCharsGiven)
		ext.tests.addTest("TestEscCharNotFound", @TestEscCharNotFound)
		ext.tests.addTest("TestSingleEscChar", @TestSingleEscChar)
		ext.tests.addTest("TestMultipleEscChars", @TestMultipleEscChars)
	end sub

end namespace
