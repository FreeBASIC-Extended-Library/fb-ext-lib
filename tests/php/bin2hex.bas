# include once "ext/testly.bi"
# include once "ext/detail/common.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    '' :::::
    private sub API
        dim result as string = ext.php.Bin2Hex("")
    end sub
    
    '' :::::
    private sub TestEmptyString
        TESTLY_ASSERT_TRUE( "" = ext.php.Bin2Hex("") )
    end sub
    
    '' :::::
    private sub TestSimple
    
        TESTLY_ASSERT_TRUE( "61" = ext.php.Bin2Hex(!"\&h61") )
        TESTLY_ASSERT_TRUE( "6162" = ext.php.Bin2Hex(!"\&h61\&h62") )
        TESTLY_ASSERT_TRUE( "616263" = ext.php.Bin2Hex(!"\&h61\&h62\&h63") )
    
    end sub
    
    '' :::::
    private sub TestLessThan10
    
        TESTLY_ASSERT_TRUE( "01" = ext.php.Bin2Hex(!"\&h1") )
        TESTLY_ASSERT_TRUE( "0102" = ext.php.Bin2Hex(!"\&h1\&h2") )
        TESTLY_ASSERT_TRUE( "01200340" = ext.php.Bin2Hex(!"\&h1\&h20\&h3\&h40") )
        TESTLY_ASSERT_TRUE( "10023004" = ext.php.Bin2Hex(!"\&h10\&h2\&h30\&h4") )
    
    end sub
    
    '' :::::
	private sub register constructor
		ext.testly.addSuite("ext-php-bin2hex")
		ext.testly.addTest("API", @API)
		ext.testly.addTest("TestSimple", @TestSimple)
		ext.testly.addTest("TestEmptyString", @TestEmptyString)
		ext.testly.addTest("TestLessThan10", @TestLessThan10)
	end sub

end namespace
