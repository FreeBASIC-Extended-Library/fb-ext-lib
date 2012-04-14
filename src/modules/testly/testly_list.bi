'#--
'# Copyright (c) 2006-2008 Luis Lavena, Multimedia systems
'#
'# This source code is released under the MIT License.
'# See MIT-LICENSE file for details
'#++

#ifndef __TESTLY_LIST_BI__
#define __TESTLY_LIST_BI__

namespace ext.Testly
    '# ListNode represent one item in the linked list
    '# previous and next are used to navigate the
    '# list in both ways
    '# value could contain any kind of pointer
    type ListNode
        previous as ListNode ptr
        value as any ptr
        next as ListNode ptr
    end type
    
    '# Simple implementation of a Linked List
    '# this mimic the ruby Array class
    '# add will put the new element at last
    '# shift will "pop" the first element
    '# there is also first and last ListNodes so
    '# you could navigate it directly.
    '# we only define a destructor to clear()
    '# the nodes.
    type List
        declare destructor()
        
        first as ListNode ptr
        last as ListNode ptr
        
        declare sub add(byval as any ptr)
        declare function shift() as any ptr
        
        declare property count as uinteger
        
        declare sub clear()
        
        private:
            _counter as uinteger
    end type
    
end namespace 'Testly

#endif '__TESTLY_LIST_BI__
