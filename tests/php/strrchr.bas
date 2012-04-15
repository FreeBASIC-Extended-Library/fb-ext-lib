# include once "ext/testly.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    '' :::::
    private sub API
        dim result as string
        result = ext.php.StrRChr("some text", "t")
        result = ext.php.StrRChr("some text", asc("t"))
    end sub
    
    '' :::::
    private sub TestSimple
        TESTLY_ASSERT_TRUE( ":123" = ext.php.StrRChr(":abc:123", asc(":")) )
        TESTLY_ASSERT_TRUE( ":123" = ext.php.StrRChr(":abc:123", "::") )
    end sub
    
    '' :::::
    private sub TestEmptyChars
        TESTLY_ASSERT_TRUE( "" = ext.php.StrRChr("abc", "") )
    end sub
    
    '' :::::
    private sub TestEmptyText
        TESTLY_ASSERT_TRUE( "" = ext.php.StrRChr("", asc(":")) )
    end sub
    
    '' :::::
    private sub TestCharNotFound
        TESTLY_ASSERT_TRUE( "" = ext.php.StrRChr("abc", asc("x")) )
    end sub
    
    '' :::::
    private sub register constructor
        ext.testly.addSuite("ext-php-strrchr")
        ext.testly.addTest("API", @API)
        ext.testly.addTest("TestSimple", @TestSimple)
        ext.testly.addTest("TestEmptyChars", @TestEmptyChars)
        ext.testly.addTest("TestEmptyText", @TestEmptyText)
        ext.testly.addTest("TestCharNotFound", @TestCharNotFound)
    end sub

end namespace
