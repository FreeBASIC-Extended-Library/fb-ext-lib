'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#ifndef __TESTLY_HELPERS_BI__
#define __TESTLY_HELPERS_BI__

#include once "testly_case.bi"
#include once "testly_suite.bi"

namespace ext.Testly
    namespace Helpers
        '# CURRENT_SUITE
        extern CURRENT_SUITE as Suite ptr
        
        '# CURRENT_TEST
        extern CURRENT_TEST as TestCase ptr
        
    end namespace 'Helpers
end namespace 'Testly

#endif '__TESTLY_HELPERS_BI__
