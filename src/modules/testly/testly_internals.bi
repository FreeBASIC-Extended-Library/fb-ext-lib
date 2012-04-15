'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#ifndef __TESTLY_INTERNALS_BI__
#define __TESTLY_INTERNALS_BI__

#include once "testly_case.bi"
#include once "testly_suite.bi"

namespace ext.Testly
    '# Helpers simplify the addition of suites and new test to each suite.
    '# you could call them directly, but is recomended (and shorter)
    '# use the defines below in this file.
    namespace InternalHelpers
        declare function suite_defined(byref as string) as ext.bool
        declare function test_defined(byref as string) as ext.bool
        declare function select_suite(byref as string) as Suite ptr
        declare function select_test(byref as string) as TestCase ptr
        
        declare function current_suite_name() as string
        declare function current_test_name() as string
        
        '# SELECTED_SUITE
        extern SELECTED_SUITE as Suite ptr
        
        '# SELECTED_TEST
        extern SELECTED_TEST as TestCase ptr
        
    end namespace 'InternalHelpers
end namespace 'Testly

#endif '__TESTLY_INTERNALS_BI__
