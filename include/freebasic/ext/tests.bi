''Title: tests.bi
''
''About: About this Module
''This is the Extended Library's built-in Unit Testing Framework.
''You can find more information about unit testing in general at http://en.wikipedia.org/wiki/Unit_testing
''
''The best example of how to use this framework is to see how
''ext uses it. All of the tests are located in directories at https://code.google.com/p/fb-extended-lib/source/browse/tests/.
''The main.bas in the root directory is a just a simple main function that runs the tests.
''
''About: Code License
''Contains code contributed and Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
''
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License
''
# pragma once
#ifndef __EXT_TESTS_BI__
#define __EXT_TESTS_BI__ -1

#if not __FB_MT__
    #inclib "ext-testly"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-testly.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

#include once "ext/detail/common.bi"

''namespace: ext.tests
namespace ext.tests

    ''Type: test_func_t
    ''Function prototype for testcases.
    ''
    type test_func_t as sub()

    ''Enum: Hook
    ''Used with addSuiteHook to run a procedure on certain events.
    ''
    ''before_all - runs this procedure before running any testcases.
    ''before_each - runs this procedure before running each testcase.
    ''after_all - runs this procedure after running all testcases.
    ''after_each - runs this procedure after each testcase.
    ''
    enum Hook explicit
        before_all
        before_each
        after_all
        after_each
    end enum

    ''Function: customAssertion
    ''Used by the helper macros below. Generally not needed to call directly.
    ''
    ''Parameters:
    ''test - boolean value indicating whether assertion was sucessful.
    ''file - string containing the file the testcase is in.
    ''line - uinteger containing the line number of the assertion.
    ''msg - string containing the message to be passed to the user if assertion fails.
    ''error - boolean value indicating true if there is an error and the suite should stop. defaults to false.
    ''
    ''Returns:
    ''boolean value indicating false if there is a fatal error. Usually ignored.
    ''
    declare function customAssertion(byval as ext.bool, byref as string, byval as uinteger, _
                                        byref as string, byval as ext.bool = false) as ext.bool

    '# Helpers simplify the addition of suites and new test to each suite.
    '# you could call them directly, but is recomended (and shorter)
    '# use the defines below in this file.

    ''Function: addSuite
    ''Add a test Suite.
    ''
    ''Parameters:
    ''name - string containing the name of the test suite to add, used in error reporting.
    ''
    ''Returns:
    ''True if sucessful.
    ''
    declare function addSuite(byref as string) as ext.bool

    ''Function: addSuiteHook
    ''Assign a function to run at certain points in the suite.
    ''
    ''Parameters:
    ''hooktype - see <Hook>
    ''proc - function to run at specified time.
    ''
    ''Returns:
    ''True if procedure is added.
    ''
    declare function addSuiteHook(byval as Hook, byref as sub()) as ext.bool

    ''function: addTest
    ''Adds a testcase to the testsuite.
    ''
    ''Parameters:
    ''name - string containing the name of the testcase.
    ''proc - procedure containing the testcase.
    ''
    ''Returns:
    ''True if testcase is added.
    ''
    declare function addTest(byref as string, byref as test_func_t) as ext.bool

    ''Function: runTests
    ''Runs the testcases for all registered Suites.
    ''
    ''Returns:
    ''True on success.
    ''
    declare function runTests() as ext.bool

end namespace


''Macro: ext_assert_true
#define ext_assert_true(__value__) _
        ext.tests.customAssertion((__value__) = (true), __FILE__, __LINE__, ("{" #__value__ "} is not true."))

''Macro: ext_assert_true_error
#define ext_assert_true_error(__value__) _
        if (ext.tests.customAssertion((__value__) = (true), __FILE__, __LINE__, ("{" #__value__ "} is not true."), true) = false) then exit sub

''Macro: ext_assert_false
#define ext_assert_false(__value__) _
        ext.tests.customAssertion((__value__) = (false), __FILE__, __LINE__, ("{" #__value__ "} is not false."))

''macro: ext_assert_false_error
#define ext_assert_false_error(__value__) _
        if (ext.tests.customAssertion((__value__) = (false), __FILE__, __LINE__, ("{" #__value__ "} is not false."), true) = false) then exit sub

'# EQU, NEQ (general)
''macro: ext_assert_equal
#define ext_assert_equal(__expected__, __actual__) _
        ext.tests.customAssertion((__actual__) = (__expected__), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"))

''macro: ext_assert_equal_error
#define ext_assert_equal_error(__expected__, __actual__) _
        if (ext.tests.customAssertion((__actual__) = (__expected__), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"), true) = false) then exit sub

''macro: ext_assert_not_equal
#define ext_assert_not_equal(__expected__, __actual__) _
        ext.tests.customAssertion((__actual__) <> (__expected__), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"))

''macro: ext_assert_not_equal_error
#define ext_assert_not_equal_error(__expected__, __actual__) _
        if (ext.tests.customAssertion((__actual__) <> (__expected__), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"), true) = false) then exit sub

'# EQU, NEQ (strings)
''macro: ext_assert_string_equal
#define ext_assert_string_equal(__expected__, __actual__) _
        ext.tests.customAssertion((str(__actual__) = str(__expected__)), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"))

''macro: ext_assert_string_equal_error
#define ext_assert_string_equal_error(__expected__, __actual__) _
        if (ext.tests.customAssertion((str(__actual__) = str(__expected__)), __FILE__, __LINE__, ("expected {" #__expected__ "} but was {" #__actual__ "}"), true) = false) then exit sub

''macro: ext_assert_string_not_equal
#define ext_assert_string_not_equal(__expected__, __actual__) _
        ext.tests.customAssertion((str(__actual__) <> str(__expected__)), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"))

''macro: ext_assert_string_not_equal_error
#define ext_assert_string_not_equal_error(__expected__, __actual__) _
        if (ext.tests.customAssertion((str(__actual__) <> str(__expected__)), __FILE__, __LINE__, ("{" #__actual__ "} expected to be != to {" #__expected__ "}"), true) = false) then exit sub

''macro: ext_assert_pass
#define ext_assert_pass(__message__) _
        ext.tests.customAssertion((true), __FILE__, __LINE__, __message__)

''macro: ext_assert_fail
#define ext_assert_fail(__message__) _
        ext.tests.customAssertion((false), __FILE__, __LINE__, __message__)

''macro: ext_assert_error
#define ext_assert_error(__message__) _
        if (ext.tests.customAssertion((false), __FILE__, __LINE__, __message__, true) = false) then exit sub

#endif '__ext_BI__
