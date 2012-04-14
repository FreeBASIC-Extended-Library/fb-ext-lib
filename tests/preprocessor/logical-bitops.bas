# include once "ext/testly.bi"
# include once "ext/preprocessor/logical.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.logical.bitops

	private sub testBool
	
		TESTLY_ASSERT_EQUAL( fbextPP_Bool(0), 0 )
		TESTLY_ASSERT_EQUAL( fbextPP_Bool(1), 1 )
		TESTLY_ASSERT_EQUAL( fbextPP_Bool(2), 1 )
		TESTLY_ASSERT_EQUAL( fbextPP_Bool(256), 1 )
	
	end sub
	
	private sub testBitAnd
	
		TESTLY_ASSERT_EQUAL( fbextPP_BitAnd(0, 0), 0 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitAnd(0, 1), 0 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitAnd(1, 0), 0 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitAnd(1, 1), 1 )
	
	end sub
	
	private sub testBitOr
	
		TESTLY_ASSERT_EQUAL( fbextPP_BitOr(0, 0), 0 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitOr(0, 1), 1 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitOr(1, 0), 1 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitOr(1, 1), 1 )
	
	end sub
	
	private sub testBitXor
	
		TESTLY_ASSERT_EQUAL( fbextPP_BitXor(0, 0), 0 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitXor(0, 1), 1 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitXor(1, 0), 1 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitXor(1, 1), 0 )
	
	end sub
	
	private sub testBitNot
	
		TESTLY_ASSERT_EQUAL( fbextPP_BitNot(0), 1 )
		TESTLY_ASSERT_EQUAL( fbextPP_BitNot(1), 0 )
	
	end sub
	
	private sub register constructor
		ext.testly.addSuite("ext-preprocessor-logical-bitops")
		ext.testly.addTest("testBool", @testBool)
		ext.testly.addTest("testBitAnd", @testBitAnd)
		ext.testly.addTest("testBitOr", @testBitOr)
		ext.testly.addTest("testBitXor", @testBitXor)
		ext.testly.addTest("testBitNot", @testBitNot)
	end sub

end namespace
