'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#include once "testly_list.bi"

namespace ext.tests
    '#############################################################
    '# List
    '# dtor()
    destructor List()
        this.clear()
    end destructor

    '# add(byval as any ptr)
    sub List.add(byval value as any ptr)
        dim new_node as ListNode ptr

        new_node = new ListNode

        '# to head of tail?
        if (first = 0) then
            first = new_node
        else
            last->next = new_node
        end if

        '# assign the node values
        with *new_node
            .previous = last
            .value = value
            .next = 0               '# this is the last node!
        end with

        '# increment counter
        _counter += 1

        '# set tail
        last = new_node
    end sub

    '# add(byval as any ptr)
    function List.shift() as any ptr
        dim result as any ptr
        dim new_next as ListNode ptr

        '# empty list?
        if (first = 0) then
            result = 0
        else
            '# get values
            with *first
                result = .value
                new_next = .next
            end with

            '# assign the new first
            delete first
            first = new_next

            '# emtpy nodes? fix the last one then
            if (first = 0) then
                last = 0
            end if

            '# decrement counter
            _counter -= 1
        end if

        return result
    end function

    '# count as uinteger
    property List.count as uinteger
        return _counter
    end property

    '# clear()
    sub List.clear()
        dim value as any ptr

        value = shift()
        do while not (value = 0)
            value = shift()
        loop
    end sub

end namespace 'Testly
