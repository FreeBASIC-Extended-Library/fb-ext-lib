# include once "ext/tests.bi"
# include once "ext/preprocessor/logical.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.logical.bitops

	private sub testBool
	
		ext_assert_EQUAL( fbextPP_Bool(0), 0 )
		ext_assert_EQUAL( fbextPP_Bool(1), 1 )
		ext_assert_EQUAL( fbextPP_Bool(2), 1 )
		ext_assert_EQUAL( fbextPP_Bool(256), 1 )
	
	end sub
	
	private sub testBitAnd
	
		ext_assert_EQUAL( fbextPP_BitAnd(0, 0), 0 )
		ext_assert_EQUAL( fbextPP_BitAnd(0, 1), 0 )
		ext_assert_EQUAL( fbextPP_BitAnd(1, 0), 0 )
		ext_assert_EQUAL( fbextPP_BitAnd(1, 1), 1 )
	
	end sub
	
	private sub testBitOr
	
		ext_assert_EQUAL( fbextPP_BitOr(0, 0), 0 )
		ext_assert_EQUAL( fbextPP_BitOr(0, 1), 1 )
		ext_assert_EQUAL( fbextPP_BitOr(1, 0), 1 )
		ext_assert_EQUAL( fbextPP_BitOr(1, 1), 1 )
	
	end sub
	
	private sub testBitXor
	
		ext_assert_EQUAL( fbextPP_BitXor(0, 0), 0 )
		ext_assert_EQUAL( fbextPP_BitXor(0, 1), 1 )
		ext_assert_EQUAL( fbextPP_BitXor(1, 0), 1 )
		ext_assert_EQUAL( fbextPP_BitXor(1, 1), 0 )
	
	end sub
	
	private sub testBitNot
	
		ext_assert_EQUAL( fbextPP_BitNot(0), 1 )
		ext_assert_EQUAL( fbextPP_BitNot(1), 0 )
	
	end sub
	
	private sub register constructor
		ext.tests.addSuite("ext-preprocessor-logical-bitops")
		ext.tests.addTest("testBool", @testBool)
		ext.tests.addTest("testBitAnd", @testBitAnd)
		ext.tests.addTest("testBitOr", @testBitOr)
		ext.tests.addTest("testBitXor", @testBitXor)
		ext.tests.addTest("testBitNot", @testBitNot)
	end sub

end namespace
