# include once "ext/testly.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    private sub API
    
        dim result as string
        result = ext.php.Count_Chars("")
        result = ext.php.Count_Chars("", ext.php.used_chars)
        result = ext.php.Count_Chars("", ext.php.unused_chars)
    
    end sub
    
    private sub TestEmptyString
    
        TESTLY_ASSERT_TRUE( "" = ext.php.Count_Chars("") )
        TESTLY_ASSERT_TRUE( "" = ext.php.Count_Chars("", ext.php.used_chars) )
        
        var result = ""
        for c as integer = 0 to 255
            result += chr(c)
        next
        TESTLY_ASSERT_TRUE( result = ext.php.Count_Chars("", ext.php.unused_chars) )
    
    end sub
    
    private sub TestUsedChars
    
        TESTLY_ASSERT_TRUE( "abc" = ext.php.Count_Chars("ccbacbabccccbcbcbaababcacb") )
    
    end sub
    
    private sub TestUnusedChars
    
        var result = ""
        for c as integer = 0 to 255
            if (0 = instr("abc", chr(c))) then
                result += chr(c)
            end if
        next
        TESTLY_ASSERT_TRUE( result = ext.php.Count_Chars("ccbacbabccccbcbcbaababcacb", ext.php.unused_chars) )
   
    end sub
    
    private sub TestArrayOfUsedChars
    
        var text = "ccbacbabccccbcbcbaababcacb"
        dim result() as ext.php.Count_CharsInfo
        var count = ext.php.Count_Chars(text, result(), ext.php.used_chars)
        
        TESTLY_ASSERT_TRUE( count = 3 )
        TESTLY_ASSERT_TRUE( lbound(result) = 0 )
        TESTLY_ASSERT_TRUE( ubound(result) = 2 )
        
        TESTLY_ASSERT_TRUE( result(0).code = asc("a") )
        TESTLY_ASSERT_TRUE( result(1).code = asc("b") )
        TESTLY_ASSERT_TRUE( result(2).code = asc("c") )
    
        TESTLY_ASSERT_TRUE( result(0).count = 6 )
        TESTLY_ASSERT_TRUE( result(1).count = 9 )
        TESTLY_ASSERT_TRUE( result(2).count = 11 )
    
    end sub
    
    private sub TestArrayOfUnusedChars
    
        var text = "ccbacbabccccbcbcbaababcacb"
        dim result() as ext.php.Count_CharsInfo
        var count = ext.php.Count_Chars(text, result(), ext.php.unused_chars)
        
        TESTLY_ASSERT_TRUE( count = 253 )
        TESTLY_ASSERT_TRUE( lbound(result) = 0 )
        TESTLY_ASSERT_TRUE( ubound(result) = 252 )
        
        for c as integer = 0 to asc("a") - 1
            TESTLY_ASSERT_TRUE( result(c).code = c )
        next
        
        for c as integer = asc("c") + 1 to 255
            TESTLY_ASSERT_TRUE( result(c - 3).code = c )
        next
    
    end sub
    
    private sub TestArrayOfAllChars
    
        var text = "ccbacbabccccbcbcbaababcacb"
        dim result() as ext.php.Count_CharsInfo
        var count = ext.php.Count_Chars(text, result(), ext.php.all_chars)
        
        TESTLY_ASSERT_TRUE( count = 256 )
        TESTLY_ASSERT_TRUE( lbound(result) = 0 )
        TESTLY_ASSERT_TRUE( ubound(result) = 255 )
        
        for c as integer = 0 to asc("a") - 1
            TESTLY_ASSERT_TRUE( result(c).code = c )
            TESTLY_ASSERT_TRUE( result(c).count = 0 )
        next
        
        TESTLY_ASSERT_TRUE( result(asc("a")).code = asc("a") )
        TESTLY_ASSERT_TRUE( result(asc("a")).count = 6 )
        TESTLY_ASSERT_TRUE( result(asc("b")).code = asc("b") )
        TESTLY_ASSERT_TRUE( result(asc("b")).count = 9 )
        TESTLY_ASSERT_TRUE( result(asc("c")).code = asc("c") )
        TESTLY_ASSERT_TRUE( result(asc("c")).count = 11 )
        
        for c as integer = asc("c") + 1 to 255
            TESTLY_ASSERT_TRUE( result(c).code = c )
            TESTLY_ASSERT_TRUE( result(c).count = 0 )
        next
        
    end sub
	
    private sub register constructor
		ext.testly.addSuite("ext-php-count_chars")
		ext.testly.addTest("API", @API)
		ext.testly.addTest("TestEmptyString", @TestEmptyString)
		ext.testly.addTest("TestUsedChars", @TestUsedChars)
		ext.testly.addTest("TestUnusedChars", @TestUnusedChars)
		ext.testly.addTest("TestArrayOfUsedChars", @TestArrayOfUsedChars)
		ext.testly.addTest("TestArrayOfUnusedChars", @TestArrayOfUnusedChars)
		ext.testly.addTest("TestArrayOfAllChars", @TestArrayOfAllChars)
	end sub

end namespace
