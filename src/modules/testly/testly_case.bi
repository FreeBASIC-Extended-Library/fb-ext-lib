'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#ifndef __TESTLY_CASE_BI__
#define __TESTLY_CASE_BI__

#include once "ext/testly.bi"

namespace ext.Testly
    '# TestCase represent each test inside a Suite.
    type TestCase
        declare constructor(byref as string = "", byref as test_func_t = 0)
        
        test_name as string
        test_func as test_func_t
        test_passed as ext.bool
    end type
    
end namespace 'Testly

#endif '__TESTLY_CASE_BI__

