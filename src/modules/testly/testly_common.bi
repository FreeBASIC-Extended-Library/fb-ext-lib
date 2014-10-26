'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#ifndef __TESTLY_COMMON_BI__
#define __TESTLY_COMMON_BI__

#include once "testly_list.bi"
#include once "testly_case.bi"
#include once "testly_suite.bi"

namespace ext.tests
    '# FailureLog is used to record the assertion problems (either failures or errors)
    '# in case of errors (as fatal) the is_error flag must be true
    type FailureLog
        suite_name as string
        test_name as string
        filename as string
        linenumber as uinteger
        message as string
        is_error as ext.bool
    end type

    '# library constructors
    declare sub initialize() 'constructor
    declare sub terminate() 'destructor

    declare function log_failure(byref as string, byref as string, byref as string, _
                    byval as uinteger, byref as string, byval as ext.bool = false) as ext.bool

    '# custom_assertion is already defined in testly.bi

    '# generic find_ functions
    declare function find_suite(byval as List ptr, byref as string) as Suite ptr
    declare function find_test(byval as List ptr, byref as string) as TestCase ptr

    '# EXTERNS
    '# SUITE_LIST
    extern SUITES_LIST as List ptr

    '# FAILURES/ERROR LIST
    extern FAILURES_LIST as List ptr

    '# RUNNING_SUITE
    extern RUNNING_SUITE as Suite ptr

    '# RUNNING_TEST
    extern RUNNING_TEST as TestCase ptr

end namespace 'Testly

#endif '__TESTLY_COMMON_BI__
