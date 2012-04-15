# include once "ext/testly.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    '' :::::
    private sub API
        dim strings(0) as string
        dim result as string = ext.php.Implode("", strings())
    end sub
    
    '' :::::
    private sub TestSimple
    
        dim strings(2) as string
        strings(0) = "one"
        strings(1) = "two"
        strings(2) = "three"
        TESTLY_ASSERT_TRUE( "one::two::three" = ext.php.Implode("::", strings()) )
    
    end sub
    
    '' :::::
    private sub TestEmptyGlue
    
        dim strings(2) as string
        strings(0) = "one"
        strings(1) = "two"
        strings(2) = "three"
        TESTLY_ASSERT_TRUE( "onetwothree" = ext.php.Implode("", strings()) )
    
    end sub
    
    '' :::::
    private sub register constructor
        ext.testly.addSuite("ext-php-implode")
        ext.testly.addTest("API", @API)
        ext.testly.addTest("TestSimple", @TestSimple)
        ext.testly.addTest("TestEmptyGlue", @TestEmptyGlue)
    end sub

end namespace
