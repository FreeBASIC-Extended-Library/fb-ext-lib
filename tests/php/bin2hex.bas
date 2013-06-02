# include once "ext/tests.bi"
# include once "ext/detail/common.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    '' :::::
    private sub API
        dim result as string = ext.php.Bin2Hex("")
    end sub
    
    '' :::::
    private sub TestEmptyString
        ext_assert_TRUE( "" = ext.php.Bin2Hex("") )
    end sub
    
    '' :::::
    private sub TestSimple
    
        ext_assert_TRUE( "61" = ext.php.Bin2Hex(!"\&h61") )
        ext_assert_TRUE( "6162" = ext.php.Bin2Hex(!"\&h61\&h62") )
        ext_assert_TRUE( "616263" = ext.php.Bin2Hex(!"\&h61\&h62\&h63") )
    
    end sub
    
    '' :::::
    private sub TestLessThan10
    
        ext_assert_TRUE( "01" = ext.php.Bin2Hex(!"\&h1") )
        ext_assert_TRUE( "0102" = ext.php.Bin2Hex(!"\&h1\&h2") )
        ext_assert_TRUE( "01200340" = ext.php.Bin2Hex(!"\&h1\&h20\&h3\&h40") )
        ext_assert_TRUE( "10023004" = ext.php.Bin2Hex(!"\&h10\&h2\&h30\&h4") )
    
    end sub
    
    '' :::::
	private sub register constructor
		ext.tests.addSuite("ext-php-bin2hex")
		ext.tests.addTest("API", @API)
		ext.tests.addTest("TestSimple", @TestSimple)
		ext.tests.addTest("TestEmptyString", @TestEmptyString)
		ext.tests.addTest("TestLessThan10", @TestLessThan10)
	end sub

end namespace
