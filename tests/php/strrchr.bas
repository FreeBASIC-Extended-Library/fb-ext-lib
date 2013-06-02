# include once "ext/tests.bi"
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
        ext_assert_TRUE( ":123" = ext.php.StrRChr(":abc:123", asc(":")) )
        ext_assert_TRUE( ":123" = ext.php.StrRChr(":abc:123", "::") )
    end sub
    
    '' :::::
    private sub TestEmptyChars
        ext_assert_TRUE( "" = ext.php.StrRChr("abc", "") )
    end sub
    
    '' :::::
    private sub TestEmptyText
        ext_assert_TRUE( "" = ext.php.StrRChr("", asc(":")) )
    end sub
    
    '' :::::
    private sub TestCharNotFound
        ext_assert_TRUE( "" = ext.php.StrRChr("abc", asc("x")) )
    end sub
    
    '' :::::
    private sub register constructor
        ext.tests.addSuite("ext-php-strrchr")
        ext.tests.addTest("API", @API)
        ext.tests.addTest("TestSimple", @TestSimple)
        ext.tests.addTest("TestEmptyChars", @TestEmptyChars)
        ext.tests.addTest("TestEmptyText", @TestEmptyText)
        ext.tests.addTest("TestCharNotFound", @TestCharNotFound)
    end sub

end namespace
