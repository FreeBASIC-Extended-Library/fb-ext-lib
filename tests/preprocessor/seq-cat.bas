# include once "ext/testly.bi"
# include once "ext/preprocessor/seq/cat.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.sequence

	private sub testCat
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( "abcd" = FBEXT_PP_STRINGIZE(fbextPP_SeqCat(SEQ)) )
	
	end sub
    
	private sub testCatWithGlue
	
		# define SEQ (a)(b)(c)(d)
		
		TESTLY_ASSERT_TRUE( "a:b:c:d" = FBEXT_PP_STRINGIZE(fbextPP_SeqCatWithGlue(SEQ, :)) )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-seq-cat")
		ext.testly.addTest("testCat", @testCat)
		ext.testly.addTest("testCatWithGlue", @testCatWithGlue)
	end sub

end namespace
