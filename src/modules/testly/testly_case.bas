'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly_case.bi"

namespace ext.Testly
    '#############################################################
    '# TestCase
    '# ctor()
    constructor TestCase(byref new_name as string = "", byref new_test_func as test_func_t = 0)
        '# assign the values
        test_name = new_name
        test_func = new_test_func
    end constructor
    
end namespace 'Testly
