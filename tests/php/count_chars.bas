# include once "ext/tests.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    private sub API
    
        dim result as string
        result = ext.php.Count_Chars("")
        result = ext.php.Count_Chars("", ext.php.used_chars)
        result = ext.php.Count_Chars("", ext.php.unused_chars)
    
    end sub
    
    private sub TestEmptyString
    
        ext_assert_TRUE( "" = ext.php.Count_Chars("") )
        ext_assert_TRUE( "" = ext.php.Count_Chars("", ext.php.used_chars) )
        
        var result = ""
        for c as integer = 0 to 255
            result += chr(c)
        next
        ext_assert_TRUE( result = ext.php.Count_Chars("", ext.php.unused_chars) )
    
    end sub
    
    private sub TestUsedChars
    
        ext_assert_TRUE( "abc" = ext.php.Count_Chars("ccbacbabccccbcbcbaababcacb") )
    
    end sub
    
    private sub TestUnusedChars
    
        var result = ""
        for c as integer = 0 to 255
            if (0 = instr("abc", chr(c))) then
                result += chr(c)
            end if
        next
        ext_assert_TRUE( result = ext.php.Count_Chars("ccbacbabccccbcbcbaababcacb", ext.php.unused_chars) )
   
    end sub
    
    private sub TestArrayOfUsedChars
    
        var text = "ccbacbabccccbcbcbaababcacb"
        dim result() as ext.php.Count_CharsInfo
        var count = ext.php.Count_Chars(text, result(), ext.php.used_chars)
        
        ext_assert_TRUE( count = 3 )
        ext_assert_TRUE( lbound(result) = 0 )
        ext_assert_TRUE( ubound(result) = 2 )
        
        ext_assert_TRUE( result(0).code = asc("a") )
        ext_assert_TRUE( result(1).code = asc("b") )
        ext_assert_TRUE( result(2).code = asc("c") )
    
        ext_assert_TRUE( result(0).count = 6 )
        ext_assert_TRUE( result(1).count = 9 )
        ext_assert_TRUE( result(2).count = 11 )
    
    end sub
    
    private sub TestArrayOfUnusedChars
    
        var text = "ccbacbabccccbcbcbaababcacb"
        dim result() as ext.php.Count_CharsInfo
        var count = ext.php.Count_Chars(text, result(), ext.php.unused_chars)
        
        ext_assert_TRUE( count = 253 )
        ext_assert_TRUE( lbound(result) = 0 )
        ext_assert_TRUE( ubound(result) = 252 )
        
        for c as integer = 0 to asc("a") - 1
            ext_assert_TRUE( result(c).code = c )
        next
        
        for c as integer = asc("c") + 1 to 255
            ext_assert_TRUE( result(c - 3).code = c )
        next
    
    end sub
    
    private sub TestArrayOfAllChars
    
        var text = "ccbacbabccccbcbcbaababcacb"
        dim result() as ext.php.Count_CharsInfo
        var count = ext.php.Count_Chars(text, result(), ext.php.all_chars)
        
        ext_assert_TRUE( count = 256 )
        ext_assert_TRUE( lbound(result) = 0 )
        ext_assert_TRUE( ubound(result) = 255 )
        
        for c as integer = 0 to asc("a") - 1
            ext_assert_TRUE( result(c).code = c )
            ext_assert_TRUE( result(c).count = 0 )
        next
        
        ext_assert_TRUE( result(asc("a")).code = asc("a") )
        ext_assert_TRUE( result(asc("a")).count = 6 )
        ext_assert_TRUE( result(asc("b")).code = asc("b") )
        ext_assert_TRUE( result(asc("b")).count = 9 )
        ext_assert_TRUE( result(asc("c")).code = asc("c") )
        ext_assert_TRUE( result(asc("c")).count = 11 )
        
        for c as integer = asc("c") + 1 to 255
            ext_assert_TRUE( result(c).code = c )
            ext_assert_TRUE( result(c).count = 0 )
        next
        
    end sub
	
    private sub register constructor
		ext.tests.addSuite("ext-php-count_chars")
		ext.tests.addTest("API", @API)
		ext.tests.addTest("TestEmptyString", @TestEmptyString)
		ext.tests.addTest("TestUsedChars", @TestUsedChars)
		ext.tests.addTest("TestUnusedChars", @TestUnusedChars)
		ext.tests.addTest("TestArrayOfUsedChars", @TestArrayOfUsedChars)
		ext.tests.addTest("TestArrayOfUnusedChars", @TestArrayOfUnusedChars)
		ext.tests.addTest("TestArrayOfAllChars", @TestArrayOfAllChars)
	end sub

end namespace
