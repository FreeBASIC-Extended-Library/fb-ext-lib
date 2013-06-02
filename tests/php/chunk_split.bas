# include once "ext/tests.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    '' :::::
    private sub API
    
        var result = ""
        result = ext.php.Chunk_Split("")
        result = ext.php.Chunk_Split("", 0)
        result = ext.php.Chunk_Split("", 0, "")
        result = ext.php.Chunk_Split("",, "")
    
    end sub
    
    '' :::::
    private sub TestSimple
        ext_assert_TRUE( !"abc\r\n" = ext.php.Chunk_Split("abc") )
    end sub
    
    '' :::::
    private sub TestEmptyText
    
        ext_assert_TRUE( "" = ext.php.Chunk_Split("") )
        ext_assert_TRUE( "" = ext.php.Chunk_Split("", 0) )
        ext_assert_TRUE( "" = ext.php.Chunk_Split("", 1000) )
        ext_assert_TRUE( "" = ext.php.Chunk_Split("",, "") )
        ext_assert_TRUE( "" = ext.php.Chunk_Split("",, "abc") )
        
    end sub
    
    '' :::::
    private sub TestEvenSplit
    
        ext_assert_TRUE( "a.b.c." = ext.php.Chunk_Split("abc", 1, ".") )
        ext_assert_TRUE( "a..b..c.." = ext.php.Chunk_Split("abc", 1, "..") )
        
        ext_assert_TRUE( "abc.def." = ext.php.Chunk_Split("abcdef", 3, ".") )
        ext_assert_TRUE( "abc..def.." = ext.php.Chunk_Split("abcdef", 3, "..") )
    
    end sub
    
    '' :::::
    private sub TestLeftover
    
        ext_assert_TRUE( "ab.c." = ext.php.Chunk_Split("abc", 2, ".") )
        ext_assert_TRUE( "ab..c.." = ext.php.Chunk_Split("abc", 2, "..") )
    
    end sub
    
    '' :::::
	private sub register constructor
		ext.tests.addSuite("ext-php-chunk_split")
		ext.tests.addTest("API", @API)
		ext.tests.addTest("TestSimple", @TestSimple)
		ext.tests.addTest("TestEmptyText", @TestEmptyText)
		ext.tests.addTest("TestEvenSplit", @TestEvenSplit)
		ext.tests.addTest("TestLeftover", @TestLeftover)
	end sub

end namespace
