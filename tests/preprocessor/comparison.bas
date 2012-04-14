# include once "ext/testly.bi"
# include once "ext/preprocessor/comparison.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.comparison

    private sub testEqual
    
        TESTLY_ASSERT_EQUAL( fbextPP_Equal(0, 0), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_Equal(0, 1), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_Equal(1, 1), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_Equal(1, 0), 0 )
    
    end sub
    
    private sub testNotEqual
    
        TESTLY_ASSERT_EQUAL( fbextPP_NotEqual(0, 0), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_NotEqual(0, 1), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_NotEqual(1, 1), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_NotEqual(1, 0), 1 )
    
    end sub

    private sub testLessThan
    
        TESTLY_ASSERT_EQUAL( fbextPP_LessThan(0, 0), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_LessThan(0, 1), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_LessThan(1, 1), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_LessThan(1, 0), 0 )
    
    end sub
    
    private sub testLessThanOrEqual
    
        TESTLY_ASSERT_EQUAL( fbextPP_LessThanOrEqual(0, 0), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_LessThanOrEqual(0, 1), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_LessThanOrEqual(1, 1), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_LessThanOrEqual(1, 0), 0 )
    
    end sub
    
    private sub testGreaterThan
    
        TESTLY_ASSERT_EQUAL( fbextPP_GreaterThan(0, 0), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_GreaterThan(0, 1), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_GreaterThan(1, 1), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_GreaterThan(1, 0), 1 )
    
    end sub
    
    private sub testGreaterThanOrEqual
    
        TESTLY_ASSERT_EQUAL( fbextPP_GreaterThanOrEqual(0, 0), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_GreaterThanOrEqual(0, 1), 0 )
        TESTLY_ASSERT_EQUAL( fbextPP_GreaterThanOrEqual(1, 1), 1 )
        TESTLY_ASSERT_EQUAL( fbextPP_GreaterThanOrEqual(1, 0), 1 )
    
    end sub
    
    private sub register constructor
        ext.testly.addSuite("ext-preprocessor-comparison")
        ext.testly.addTest("testEqual", @testEqual)
        ext.testly.addTest("testNotEqual", @testNotEqual)
        ext.testly.addTest("testLessThan", @testLessThan)
        ext.testly.addTest("testLessThanOrEqual", @testLessThanOrEqual)
        ext.testly.addTest("testGreaterThan", @testGreaterThan)
        ext.testly.addTest("testGreaterThanOrEqual", @testGreaterThanOrEqual)
    end sub

end namespace
