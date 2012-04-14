# include once "ext/testly.bi"
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
        TESTLY_ASSERT_TRUE( !"abc\r\n" = ext.php.Chunk_Split("abc") )
    end sub
    
    '' :::::
    private sub TestEmptyText
    
        TESTLY_ASSERT_TRUE( "" = ext.php.Chunk_Split("") )
        TESTLY_ASSERT_TRUE( "" = ext.php.Chunk_Split("", 0) )
        TESTLY_ASSERT_TRUE( "" = ext.php.Chunk_Split("", 1000) )
        TESTLY_ASSERT_TRUE( "" = ext.php.Chunk_Split("",, "") )
        TESTLY_ASSERT_TRUE( "" = ext.php.Chunk_Split("",, "abc") )
        
    end sub
    
    '' :::::
    private sub TestEvenSplit
    
        TESTLY_ASSERT_TRUE( "a.b.c." = ext.php.Chunk_Split("abc", 1, ".") )
        TESTLY_ASSERT_TRUE( "a..b..c.." = ext.php.Chunk_Split("abc", 1, "..") )
        
        TESTLY_ASSERT_TRUE( "abc.def." = ext.php.Chunk_Split("abcdef", 3, ".") )
        TESTLY_ASSERT_TRUE( "abc..def.." = ext.php.Chunk_Split("abcdef", 3, "..") )
    
    end sub
    
    '' :::::
    private sub TestLeftover
    
        TESTLY_ASSERT_TRUE( "ab.c." = ext.php.Chunk_Split("abc", 2, ".") )
        TESTLY_ASSERT_TRUE( "ab..c.." = ext.php.Chunk_Split("abc", 2, "..") )
    
    end sub
    
    '' :::::
	private sub register constructor
		ext.testly.addSuite("ext-php-chunk_split")
		ext.testly.addTest("API", @API)
		ext.testly.addTest("TestSimple", @TestSimple)
		ext.testly.addTest("TestEmptyText", @TestEmptyText)
		ext.testly.addTest("TestEvenSplit", @TestEvenSplit)
		ext.testly.addTest("TestLeftover", @TestLeftover)
	end sub

end namespace
