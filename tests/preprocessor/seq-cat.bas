# include once "ext/tests.bi"
# include once "ext/preprocessor/seq/cat.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.sequence

	private sub testCat
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "abcd" = FBEXT_PP_STRINGIZE(fbextPP_SeqCat(SEQ)) )
	
	end sub
    
	private sub testCatWithGlue
	
		# define SEQ (a)(b)(c)(d)
		
		ext_assert_TRUE( "a:b:c:d" = FBEXT_PP_STRINGIZE(fbextPP_SeqCatWithGlue(SEQ, :)) )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-seq-cat")
		ext.tests.addTest("testCat", @testCat)
		ext.tests.addTest("testCatWithGlue", @testCatWithGlue)
	end sub

end namespace
