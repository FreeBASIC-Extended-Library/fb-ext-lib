'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly_common.bi"

namespace ext.Testly
    dim shared SUITES_LIST as List ptr
    dim shared FAILURES_LIST as List ptr
    dim shared RUNNING_SUITE as Suite ptr
    dim shared RUNNING_TEST as TestCase ptr
    
    
    '# initialize() prepare Testly to be used by the user
    '# it creates the List that will hold all the suites
    '# for safety, this was marked as private
    private sub initialize() constructor
        '# construct the list that will hold the suites
        SUITES_LIST = new List
        
        '# the failures list
        FAILURES_LIST = new List
    end sub
    
    
    '# terminate() ensures all the suites are removed from SUITES_LIST
    '# prior removing it.
    private sub terminate() destructor
        dim node_suite as Suite ptr
        dim node_failure as FailureLog ptr
        
        '# ensure all the Suites being removed
        do while (SUITES_LIST->count > 0)
            node_suite = cast(Suite ptr, SUITES_LIST->shift())
            delete node_suite
        loop
        
        '# ensure removing all the logged failures
        do while (FAILURES_LIST->count > 0)
            node_failure = cast(FailureLog ptr, FAILURES_LIST->shift())
            delete node_failure
        loop
        
        '# remove the global List
        delete SUITES_LIST
        
        '# remove failure list
        delete FAILURES_LIST
        
        '# cleanup, just in case
        RUNNING_SUITE = 0
        RUNNING_TEST = 0
    end sub
    
    
    function customassertion(byval assert_value as ext.bool, byref filename as string, byval linenumber as uinteger, _
                                byref message as string, byval fatal_error as ext.bool = false) as ext.bool
        dim result as ext.bool
        
        '# we must first ensure we aren't doing assertions like crazy,
        '# like outside of runTests()...
        if not (RUNNING_SUITE = 0) then
            '# increment the current suite assertions
            RUNNING_SUITE->stats.assertions += 1
            
            '# the assert_value is meet?
            if (assert_value = false) then
                '# no, log it.
                '# see if it is fatal and adjust the assertion stats
                if (fatal_error = true) then
                    RUNNING_SUITE->stats.errors += 1
                    result = false
                else
                    RUNNING_SUITE->stats.failures += 1
                    result = true
                end if
                
                '# log it only if CURRENT_SUITE is not excluded
                if not (RUNNING_SUITE->exclude = true) then
                    '# check if this assertion happens inside a test or in the setup/teardown mechanism
                    if not (RUNNING_TEST = 0) then
                        log_failure(RUNNING_SUITE->suite_name, RUNNING_TEST->test_name, filename, linenumber, message, fatal_error)
                    else
                        log_failure(RUNNING_SUITE->suite_name, "", filename, linenumber, message, fatal_error)
                    end if
                end if
            end if
        end if
        
        return result
    end function
    
    
    function log_failure(byref suite_name as string, byref test_name as string, byref filename as string, _
                    byval linenumber as uinteger, byref message as string, byval is_error as ext.bool = false) as ext.bool
        
        dim result as ext.bool
        dim failure as FailureLog ptr
        
        if not (FAILURES_LIST = 0) then
            '# create a new failure log
            failure = new FailureLog
            with *failure
                .suite_name = suite_name
                .test_name = test_name
                .filename = filename
                .linenumber = linenumber
                .message = message
                .is_error = is_error
            end with
            
            FAILURES_LIST->add(failure)
            result = true
        else
            result = false
        end if
        
        return result
    end function
    
    
    '#############################################################
    '# find_* helpers
    '# find_suite will look into 'in_list' List for suite_name
    '# if no suite is found, return 0
    function find_suite(byval in_list as List ptr, byref suite_name as string) as Suite ptr
        dim result as Suite ptr
        dim node as ListNode ptr
        dim item as Suite ptr
        dim found as ext.bool
        
        result = 0
        
        if not (in_list = 0) then
            node = in_list->first
            do until (node = 0) or (found = true)
                item = cast(Suite ptr, node->value)
                if (item->suite_name = suite_name) then
                    found = true
                else
                    node = node->next
                end if
            loop
            
            if (found = true) then
                result = item
            else
                result = 0
            end if
        end if
        
        return result
    end function
    
    
    '# find_test will look into 'in_list' List for test_name
    '# if no test is found, return 0
    function find_test(byval in_list as List ptr, byref test_name as string) as TestCase ptr
        dim result as TestCase ptr
        dim node as ListNode ptr
        dim item as TestCase ptr
        dim found as ext.bool
        
        result = 0
        
        if not (in_list = 0) then
            node = in_list->first
            do until (node = 0) or (found = true)
                item = cast(TestCase ptr, node->value)
                if (item->test_name = test_name) then
                    found = true
                else
                    node = node->next
                end if
            loop
            
            if (found = true) then
                result = item
            else
                result = 0
            end if
        end if
        
        return result
    end function
    
end namespace 'Testly
