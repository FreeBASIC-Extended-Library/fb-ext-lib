# include once "ext/tests.bi"
# include once "ext/preprocessor/comparison.bi"
# include once "ext/preprocessor/stringize.bi"

namespace ext.tests.preprocessor.comparison

    private sub testEqual
    
        ext_assert_EQUAL( fbextPP_Equal(0, 0), 1 )
        ext_assert_EQUAL( fbextPP_Equal(0, 1), 0 )
        ext_assert_EQUAL( fbextPP_Equal(1, 1), 1 )
        ext_assert_EQUAL( fbextPP_Equal(1, 0), 0 )
    
    end sub
    
    private sub testNotEqual
    
        ext_assert_EQUAL( fbextPP_NotEqual(0, 0), 0 )
        ext_assert_EQUAL( fbextPP_NotEqual(0, 1), 1 )
        ext_assert_EQUAL( fbextPP_NotEqual(1, 1), 0 )
        ext_assert_EQUAL( fbextPP_NotEqual(1, 0), 1 )
    
    end sub

    private sub testLessThan
    
        ext_assert_EQUAL( fbextPP_LessThan(0, 0), 0 )
        ext_assert_EQUAL( fbextPP_LessThan(0, 1), 1 )
        ext_assert_EQUAL( fbextPP_LessThan(1, 1), 0 )
        ext_assert_EQUAL( fbextPP_LessThan(1, 0), 0 )
    
    end sub
    
    private sub testLessThanOrEqual
    
        ext_assert_EQUAL( fbextPP_LessThanOrEqual(0, 0), 1 )
        ext_assert_EQUAL( fbextPP_LessThanOrEqual(0, 1), 1 )
        ext_assert_EQUAL( fbextPP_LessThanOrEqual(1, 1), 1 )
        ext_assert_EQUAL( fbextPP_LessThanOrEqual(1, 0), 0 )
    
    end sub
    
    private sub testGreaterThan
    
        ext_assert_EQUAL( fbextPP_GreaterThan(0, 0), 0 )
        ext_assert_EQUAL( fbextPP_GreaterThan(0, 1), 0 )
        ext_assert_EQUAL( fbextPP_GreaterThan(1, 1), 0 )
        ext_assert_EQUAL( fbextPP_GreaterThan(1, 0), 1 )
    
    end sub
    
    private sub testGreaterThanOrEqual
    
        ext_assert_EQUAL( fbextPP_GreaterThanOrEqual(0, 0), 1 )
        ext_assert_EQUAL( fbextPP_GreaterThanOrEqual(0, 1), 0 )
        ext_assert_EQUAL( fbextPP_GreaterThanOrEqual(1, 1), 1 )
        ext_assert_EQUAL( fbextPP_GreaterThanOrEqual(1, 0), 1 )
    
    end sub
    
    private sub register constructor
        ext.tests.addSuite("ext-preprocessor-comparison")
        ext.tests.addTest("testEqual", @testEqual)
        ext.tests.addTest("testNotEqual", @testNotEqual)
        ext.tests.addTest("testLessThan", @testLessThan)
        ext.tests.addTest("testLessThanOrEqual", @testLessThanOrEqual)
        ext.tests.addTest("testGreaterThan", @testGreaterThan)
        ext.tests.addTest("testGreaterThanOrEqual", @testGreaterThanOrEqual)
    end sub

end namespace
