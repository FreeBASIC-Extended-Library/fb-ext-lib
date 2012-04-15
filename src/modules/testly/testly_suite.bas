'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly_suite.bi"
#include once "testly_case.bi"

namespace ext.Testly
    '#############################################################
    '# Suite
    '# default ctor()
    constructor Suite(byref new_name as string = "")
        '# assign the suite properties
        suite_name = new_name
        
        tests_list = new List
    end constructor
    
    '# dtor()
    destructor Suite()
        dim test as TestCase ptr
        
        '# remove the Suite tests
        do while (tests_list->count > 0)
            test = cast(TestCase ptr, tests_list->shift())
            delete test
        loop
    end destructor
    
    '# property tests_count as uinteger
    property Suite.tests_count as uinteger
        return tests_list->count
    end property
    
end namespace 'Testly
