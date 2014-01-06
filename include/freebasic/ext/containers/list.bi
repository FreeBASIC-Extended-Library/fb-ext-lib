'' Title: ext/containers/list.bi
''
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONTAINERS_LIST_BI__
# define FBEXT_CONTAINERS_LIST_BI__ -1

# include once "ext/detail/common.bi"
# include once "ext/memory/allocator.bi"
# include once "ext/algorithms/detail/common.bi" ' for fbext_Predicate

namespace ext

    type ListNode__
        prev as ListNode__ ptr
        next as ListNode__ ptr
    end type

end namespace

# define fbext_ListNodeT__( T_)             fbext_TID(ListNodeT__, ( T_))
# define fbext_ListIterator__( T_)          fbext_TID(ListIterator__, ( T_))
# define fbext_ListIteratorToConst__( T_)   fbext_TID(ListIteratorToConst__, ( T_))

# define fbext_List( targs_)                fbext_TemplateID( List, targs_, fbext_List_DefaultTArgs() )
# define fbext_List_DefaultTArgs()          (__)((fbext_Allocator))

# macro fbext_ListNodeT___Declare( T_)
:
namespace ext
    type fbext_ListNodeT__( T_)
        rep as ListNode__
        obj as fbext_TypeName( T_)

        ' These merely satisfy Allocator_((fbext_ListNodeT__( T_)))
        ' construction members. They are never called.
        declare constructor ( byref as const fbext_ListNodeT__( T_) )
        declare destructor ( )
    end type
end namespace
:
# endmacro

# macro fbext_ListNodeT___Define(linkage_, T_)
:
namespace ext
    '' :::::
    linkage_ constructor fbext_ListNodeT__( T_) ( byref x as const fbext_ListNodeT__( T_) )
    end constructor

    '' :::::
    linkage_ destructor fbext_ListNodeT__( T_) ( )
    end destructor
end namespace
:
# endmacro

# macro fbext_ListIterator___Declare( T_)
:
namespace ext
    '' Class: ListIterator__
    type fbext_ListIterator__( T_)
    public:
        '' Sub: default constructor
        '' Constructs an iterator.
        ''
        '' Parameters:
        '' node - the List node to point to, used internally by List
        declare constructor ( byval node as ListNode__ ptr = null )

        '' Function: Get
        '' Returns a reference to the list element being pointed to.
        declare function Get ( ) as fbext_TypeName( T_) ptr

        '' Sub: Increment
        '' Moves the iterator forward in the list.
        declare sub Increment ( )

        '' Sub: Decrement
        '' Moves the iterator backward in the list.
        declare sub Decrement ( )

        '' Function: PostIncrement
        '' Moves the iterator forward in the list after returning its
        '' value.
        ''
        '' Returns:
        '' Returns the value of the iterator before being incremented.
        declare function PostIncrement ( ) as fbext_ListIterator__( T_)

        '' Function: PostDecrement
        '' Moves the iterator backward in the list after returning its
        '' value.
        ''
        '' Returns:
        '' Returns the value of the iterator before being decremented.
        declare function PostDecrement ( ) as fbext_ListIterator__( T_)

    public:
        ' public for easy List access..
        m_node as ListNode__ ptr
    end type

    '' Class: ListIteratorToConst__
    type fbext_ListIteratorToConst__( T_)
    public:
        '' Sub: conversion from ListIterator__ constructor
        '' Constructs an iterator.
        declare constructor ( byref x as const fbext_ListIterator__( T_) )

        '' Sub: default constructor
        '' Constructs an iterator.
        ''
        '' Parameters:
        '' node - the List node to point to, used internally by List
        declare constructor ( byval node as const ListNode__ ptr = null )

        '' Function: Get
        '' Gets a pointer that is constant to the referenced element.
        declare function Get ( ) as const fbext_TypeName( T_) ptr

        '' Sub: Increment
        '' Moves the iterator forward in the list.
        declare sub Increment ( )

        '' Sub: Decrement
        '' Moves the iterator backward in the list.
        declare sub Decrement ( )

        '' Function: PostIncrement
        '' Moves the iterator forward in the list after returning its
        '' value.
        ''
        '' Returns:
        '' Returns the value of the iterator before being incremented.
        declare function PostIncrement ( ) as fbext_ListIteratorToConst__( T_)

        '' Function: PostDecrement
        '' Moves the iterator backward in the list after returning its
        '' value.
        ''
        '' Returns:
        '' Returns the value of the iterator before being decremented.
        declare function PostDecrement ( ) as fbext_ListIteratorToConst__( T_)

    public:
        ' public for easy List access..
        m_node as ListNode__ ptr
    end type

    '' Operator: dereference
    '' Equivalent to `fbext_ListIterator__( T_).Get()`.
    declare operator * ( byref self as const fbext_ListIterator__( T_) ) as fbext_TypeName( T_) ptr
    '' Operator: dereference
    '' Equivalent to `fbext_ListIteratorToConst__( T_).Get()`.
    declare operator * ( byref self as const fbext_ListIteratorToConst__( T_) ) as const fbext_TypeName( T_) ptr

    '' Function: global operator =
    '' Compares two iterators for equality.
    ''
    '' Parameters:
    '' x - an iterator
    '' y - another iterator
    ''
    '' Returns:
    '' Returns true if the iterators point to the same element, false
    '' otherwise.
    declare operator = ( byref x as fbext_ListIterator__( T_), byref y as fbext_ListIterator__( T_) ) as bool
    declare operator = ( byref x as fbext_ListIteratorToConst__( T_), byref y as fbext_ListIteratorToConst__( T_) ) as bool

    '' Function: global operator <>
    '' Compares two iterators for inequality.
    ''
    '' Parameters:
    '' x - an iterator
    '' y - another iterator
    ''
    '' Returns:
    '' Returns true if the iterators do not point to the same element,
    '' false otherwise.
    declare operator <> ( byref x as fbext_ListIterator__( T_), byref y as fbext_ListIterator__( T_) ) as bool
    declare operator <> ( byref x as fbext_ListIteratorToConst__( T_), byref y as fbext_ListIteratorToConst__( T_) ) as bool
end namespace
:
# endmacro

# macro fbext_ListIterator___Define(linkage_, T_)
:
namespace ext
    '' :::::
    linkage_ constructor fbext_ListIterator__( T_) ( byval node as ListNode__ ptr )
        m_node = node
    end constructor

    '' :::::
    linkage_ operator * ( byref self as const fbext_ListIterator__( T_) ) as fbext_TypeName( T_) ptr
        return @cast(fbext_ListNodeT__( T_) ptr, self.m_node)->obj
    end operator

    '' :::::
    linkage_ function fbext_ListIterator__( T_).Get ( ) as fbext_TypeName( T_) ptr
        return @cast(fbext_ListNodeT__( T_) ptr, m_node)->obj
    end function

    '' :::::
    linkage_ sub fbext_ListIterator__( T_).Increment ( )
        m_node = m_node->next
    end sub

    '' :::::
    linkage_ sub fbext_ListIterator__( T_).Decrement ( )
        m_node = m_node->prev
    end sub

    '' :::::
    linkage_ function fbext_ListIterator__( T_).PostIncrement ( ) as fbext_ListIterator__( T_)
        var tmp = this
        this.Increment()
        return tmp
    end function

    '' :::::
    linkage_ function fbext_ListIterator__( T_).PostDecrement ( ) as fbext_ListIterator__( T_)
        var tmp = this
        this.Decrement()
        return tmp
    end function

    '' :::::
    linkage_ constructor fbext_ListIteratorToConst__( T_) ( byref x as const fbext_ListIterator__( T_) )
        m_node = x.m_node
    end constructor

    '' :::::
    linkage_ constructor fbext_ListIteratorToConst__( T_) ( byval node as const ListNode__ ptr )
        m_node = cast(ListNode__ ptr, cast(any ptr, node))
    end constructor

    '' :::::
    linkage_ operator * ( byref self as const fbext_ListIteratorToConst__( T_) ) as const fbext_TypeName( T_) ptr
        return cast(const fbext_TypeName( T_) ptr, self.m_node + 1)
    end operator

    '' :::::
    linkage_ function fbext_ListIteratorToConst__( T_).Get ( ) as const fbext_TypeName( T_) ptr
        return cast(const fbext_TypeName( T_) ptr, m_node + 1)
    end function

    '' :::::
    linkage_ sub fbext_ListIteratorToConst__( T_).Increment ( )
        m_node = m_node->next
    end sub

    '' :::::
    linkage_ sub fbext_ListIteratorToConst__( T_).Decrement ( )
        m_node = m_node->prev
    end sub

    '' :::::
    linkage_ function fbext_ListIteratorToConst__( T_).PostIncrement ( ) as fbext_ListIteratorToConst__( T_)
        var tmp = this
        this.Increment()
        return tmp
    end function

    '' :::::
    linkage_ function fbext_ListIteratorToConst__( T_).PostDecrement ( ) as fbext_ListIteratorToConst__( T_)
        var tmp = this
        this.Decrement()
        return tmp
    end function

    '' :::::
    linkage_ operator = ( byref x as fbext_ListIterator__( T_), byref y as fbext_ListIterator__( T_) ) as bool
        return x.m_node = y.m_node
    end operator

    '' :::::
    linkage_ operator = ( byref x as fbext_ListIteratorToConst__( T_), byref y as fbext_ListIteratorToConst__( T_) ) as bool
        return x.m_node = y.m_node
    end operator

    '' :::::
    linkage_ operator <> ( byref x as fbext_ListIterator__( T_), byref y as fbext_ListIterator__( T_) ) as bool
        return x.m_node <> y.m_node
    end operator

    '' :::::
    linkage_ operator <> ( byref x as fbext_ListIteratorToConst__( T_), byref y as fbext_ListIteratorToConst__( T_) ) as bool
        return x.m_node <> y.m_node
    end operator
end namespace
:
# endmacro

# macro fbext_List_Declare( T_, Allocator_)
:
fbext_TDeclare(fbext_ListNodeT__, ( T_))
fbext_TDeclare(fbext_ListIterator__, ( T_))
' for allocating nodes.
fbext_TDeclare(fbext_TypeName( Allocator_), ((fbext_ListNodeT__( T_))))
' for constructing elements.
fbext_TDeclare(fbext_TypeName( Allocator_), ( T_))

namespace ext

    '' Class: List
    type fbext_List(( T_)( Allocator_))
    public:
        declare static function Iterator as fbext_ListIterator__( T_)
        declare static function IteratorToConst as fbext_ListIteratorToConst__( T_)

        '' Sub: default constructor
        '' Constructs an empty list.
        declare constructor ( )

        '' Sub: copy constructor
        '' Constructs an empty list.
        declare constructor ( byref x as const fbext_List(( T_)( Allocator_)) )

        '' Sub: constructor
        '' Constructs a list of n blank elements.
        ''
        '' Parameters:
        '' n - <SizeType> specifing how many elements to create.
        declare constructor ( byval n as SizeType )

        '' Sub: constructor
        '' Constructs a list of n elements with the same value.
        ''
        '' Parameters:
        '' n - <SizeType> specifing how many elements to create.
        '' value - the value to assign to each element.
        declare constructor ( byval n as SizeType, byref valu as const fbext_TypeName(T_ ))

        '' Sub: constructor
        '' Constructs a list from a range of list element values.
        ''
        '' Parameters:
        '' first - an iterator to the first element in the range
        '' last - an iteratot to one-past the last element in the range
        declare constructor ( byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )

        '' Sub: destructor
        '' Destroys the list.
        declare destructor ( )

        '' Sub: operator let
        '' Assigns to the list from another.
        ''
        '' Parameters:
        '' x - the list to assign
        declare operator let ( byref x as const fbext_List(( T_)( Allocator_)) )

        '' Sub: Assign
        '' Assigns to the list from a range of list element values.
        ''
        '' Parameters:
        '' first - an iterator to the first element in the range
        '' last - an iteratot to one-past the last element in the range
        declare sub Assign ( byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )

        '' Sub: Assign
        '' Assigns to the list multiple copies of an element value.
        ''
        '' Parameters:
        '' n - the number of element values to assign
        '' x - the element value to assign
        declare sub Assign ( byval n as SizeType, byref x as const fbext_TypeName( T_) )

        '' Function: Size
        '' Gets the number of elements in the list.
        declare const function Size ( ) as SizeType

        '' Sub: Resize
        '' Changes the size of the list. If x is greater than the current size new items are given the default value, if smaller the overhanging items are removed.
        ''
        '' Parameters:
        '' x - <SizeType> specifing the number of elements the list will contain
        declare sub Resize ( byval x as SizeType )

        '' Sub: Resize
        '' Changes the size of the list. If x is greater than the current size then new items are assigned the value passed or removed.
        ''
        '' Parameters:
        '' x - <SizeType> specifing the number of elements the list will contain
        '' v - value any new items will contain
        declare sub Resize ( byval x as SizeType, byref v as const fbext_TypeName( T_) )

        '' Function: Empty
        '' Determines if the list contains no elements.
        declare const function Empty ( ) as bool

        '' Function: Begin
        '' Gets an iterator to the first element in the list.
        declare function Begin ( ) as typeof(Iterator)
        '' Function: cBegin
        '' Gets an iterator to the first element in the list.
        declare const function cBegin ( ) as typeof(IteratorToConst)

        '' Function: End_
        '' Gets an iterator to one-past the last element in the list.
        declare function End_ ( ) as typeof(Iterator)
        '' Function: cEnd
        '' Gets an iterator to one-past the last element in the list.
        declare const function cEnd ( ) as typeof(IteratorToConst)

        '' Function: Front
        '' Gets a reference to the first element in the list.
        declare function Front ( ) as fbext_TypeName( T_) ptr
        '' Function: cFront
        '' Gets a reference to the first element in the list.
        declare const function cFront ( ) as const fbext_TypeName( T_) ptr

        '' Function: Back
        '' Gets a reference to the last element in the list.
        declare function Back ( ) as fbext_TypeName( T_) ptr
        '' Function: cBack
        '' Gets a reference to the last element in the list.
        declare const function cBack ( ) as const fbext_TypeName( T_) ptr

        '' Sub: PushFront
        '' Inserts an element value at the beginning of the list.
        ''
        '' Parameters:
        '' x - the element value to insert
        declare sub PushFront ( byref x as const fbext_TypeName( T_) )

        '' Sub: PushBack
        '' Inserts an element value at the end of the list.
        ''
        '' Parameters:
        '' x - the element value to insert
        declare sub PushBack ( byref x as const fbext_TypeName( T_) )

        '' Sub: PopFront
        '' Removes the first element in the list.
        declare sub PopFront ( )

        '' Sub: PopBack
        '' Removes the last element in the list.
        declare sub PopBack ( )

        '' Function: Insert
        '' Inserts an element value into the list.
        ''
        '' Parameters:
        '' position - an iterator to where insertion will take place
        '' x - the element value to insert
        ''
        '' Returns:
        '' Returns an iterator to the newly inserted element.
        declare function Insert ( byval position as typeof(Iterator), byref x as const fbext_TypeName( T_) ) as typeof(Iterator)

        '' Sub: Insert
        '' Inserts a number of copies of an element value in the list.
        ''
        '' Parameters:
        '' position - an iterator to where insertion will take place
        '' n - the number of copies to insert
        '' x - the element value to insert
        declare sub Insert ( byval position as typeof(Iterator), byval n as SizeType, byref x as const fbext_TypeName( T_) )

        '' Sub: Insert
        '' Inserts a range of element values into the list.
        ''
        '' Parameters:
        '' position - an iterator to where insertion will take place
        '' first - an iterator to the first element in the range to insert
        '' last - an iterator to one-past the last element in the range to
        '' insert
        declare sub Insert ( byval position as typeof(Iterator), byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )

        '' Sub: Splice
        '' Moves the elements of the passed list into the list at the position specified.
        ''
        '' Parameters:
        '' position - an iterator where the list insertion will take place
        '' lst - the list to insert
        ''
        declare sub Splice ( byval position as typeof(Iterator), byref lst as fbext_List(( T_)( Allocator_)) )

        '' Sub: Splice
        '' Moves the elements of list "b" into list "a" at the position specified in list "a" starting at the position in the list "b".
        ''
        '' Parameters:
        '' position - an iterator where list "a" insertion will take place
        '' lst - the list to insert
        '' frst - an iterator where values from list "b" will be moved to list "a"
        ''
        declare sub Splice ( byval position as typeof(Iterator), byref lst as fbext_List(( T_)( Allocator_)), byval frst as typeof(Iterator) )

        '' Sub: Splice
        '' Moves the elements of list "b" into list "a" at the position specified in list "a" starting at the position in the list "b" and continuing until lastp.
        ''
        '' Parameters:
        '' position - an iterator where list "a" insertion will take place
        '' lst - the list to insert
        '' frst - an iterator where values from list "b" will be moved to list "a"
        '' lastp - an iterator where moving should end.
        ''
        declare sub Splice ( byval position as typeof(Iterator), byref lst as fbext_List(( T_)( Allocator_)), byval frst as typeof(Iterator), byval lastp as typeof(Iterator) )

        '' Function: Erase
        '' Removes an element from the list.
        ''
        '' Parameters:
        '' position - an iterator to the element to remove
        ''
        '' Returns:
        '' Returns an iterator to the element after the element removed, or
        '' List.End_() if the last element was removed.
        declare function Erase ( byval position as typeof(Iterator) ) as typeof(Iterator)

        '' Function: Erase
        '' Removes a range of elements from the list.
        ''
        '' Parameters:
        '' first - an iterator to the first element to remove
        '' last - an iterator to one-past the last element to remove
        ''

        '' Returns:
        '' Returns an iterator to the element after the elements removed,
        '' or List.End_() if the trailing elements were removed.
        declare function Erase ( byval first as typeof(Iterator), byval last as typeof(Iterator) ) as typeof(Iterator)

        '' Sub: Clear
        '' Removes all elements from the list.
        declare sub Clear ( )

        '' Sub: RemoveIf
        '' Removes elements from the list satisfying a predicate.
        ''
        '' Parameters:
        '' pred - a predicate that returns true if an element is to be
        '' removed, false otherwise.
        declare sub RemoveIf ( byval pred as function ( byref as const fbext_TypeName( T_) ) as bool )

    private:
        declare static function T_Allocator as fbext_TypeName( Allocator_)(( T_))
        declare function m_CreateNode ( ) as ListNode__ ptr
        declare function m_CreateNode ( byref x as const fbext_TypeName( T_) ) as ListNode__ ptr

        m_alloc as fbext_TypeName( Allocator_)( ((fbext_ListNodeT__( T_))) )
        m_node as ListNode__
    end type
end namespace
:
# endmacro

# macro fbext_List_Define(linkage_, T_, Allocator_)
:
fbext_TDefine(fbext_ListNodeT__, private, ( T_))
fbext_TDefine(fbext_ListIterator__, private, ( T_))

fbext_TDefine(fbext_TypeName( Allocator_), private, ((fbext_ListNodeT__( T_))))
fbext_TDefine(fbext_TypeName( Allocator_), private, ( T_))

namespace ext

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).m_CreateNode ( ) as ListNode__ ptr

        var newnode = m_alloc.Allocate(1)
        dim value as fbext_TypeName( T_)
        dim talloc as typeof(T_Allocator)
        talloc.Construct(@newnode->obj, value)
        return cast(ListNode__ ptr, newnode)

    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).m_CreateNode ( byref value as const fbext_TypeName( T_) ) as ListNode__ ptr

        var newnode = m_alloc.Allocate(1)
        dim talloc as typeof(T_Allocator)
        talloc.Construct(@newnode->obj, value)
        return cast(ListNode__ ptr, newnode)

    end function

    '' :::::
    linkage_ constructor fbext_List(( T_)( Allocator_)) ( )
        m_node.prev = @m_node
        m_node.next = @m_node
    end constructor

    '' :::::
    linkage_ constructor fbext_List(( T_)( Allocator_)) ( byref x as const fbext_List(( T_)( Allocator_)) )

        m_node.prev = @m_node
        m_node.next = @m_node
        this.Assign(x.cBegin(), x.cEnd())

    end constructor

    '' :::::
    linkage_ constructor fbext_List(( T_)( Allocator_)) ( byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )

        m_node.prev = @m_node
        m_node.next = @m_node
        this.Assign(first, last)

    end constructor

    '' :::::
    linkage_ constructor fbext_List(( T_)( Allocator_)) ( byval n as SizeType )

        for t as SizeType = 0 to n
            dim tmp as fbext_TypeName(T_)
            this.PushBack(tmp)
        next t

    end constructor

    '' :::::
    linkage_ constructor fbext_List(( T_)( Allocator_)) ( byval n as SizeType, byref valu as const fbext_TypeName(T_) )

        for t as SizeType = 0 to n
            this.PushBack(valu)
        next t

    end constructor

    '' :::::
    linkage_ destructor fbext_List(( T_)( Allocator_)) ( )
        this.Clear()
    end destructor

    '' :::::
    linkage_ operator fbext_List(( T_)( Allocator_)).let ( byref x as const fbext_List(( T_)( Allocator_)) )

        dim first as typeof(IteratorToConst) = x.m_node.next
        dim last as typeof(IteratorToConst) = @x.m_node
        this.Assign(first, last)

    end operator

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Assign ( byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )

        dim first1 as typeof(Iterator) = m_node.next
        dim last1 as typeof(Iterator) = @m_node
        var first2 = first
        var last2 = last

        ' re-assign any existing elements.
        do while (first1 <> last1) andalso (first2 <> last2)
            **(first1.PostIncrement()) = **(first2.PostIncrement())
        loop

        ' not enough existing elements ?
        if first2 <> last2 then
            this.Insert(last1, first2, last2)

        else
            var tmp = this.Erase(first1, last1)

        end if

    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Assign ( byval n as SizeType, byref value as const fbext_TypeName( T_) )

        dim first as typeof(Iterator) = m_node.next
        dim last as typeof(Iterator) = @m_node

        ' re-assign any existing elements.
        do while (first <> last) andalso n > 0
            **(first.PostIncrement()) = value
            n -= 1
        loop

        ' not enough existing elements ?
        if n > 0 then
            this.Insert(first, n, value)

        else
            var tmp = this.Erase(first, last)

        end if

    end sub

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).Size ( ) as SizeType

        dim first as typeof(IteratorToConst) = m_node.next
        dim last as typeof(IteratorToConst) = @m_node
        dim c as SizeType = 0

        do while first <> last
            c += 1
            first.Increment()
        loop
        return c

    end function

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Resize ( byval x as SizeType )

        dim tmp as fbext_TypeName( T_)
        this.Resize( x, tmp )

    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Resize ( byval x as SizeType, byref v as const fbext_TypeName( T_) )

        var s = this.Size()

        if x = s then return

        if x < s then

            var diff = s - x
            var it = this.End_()

            for n as uinteger = 1 to diff
                it.Decrement()
            next

            var unused = this.Erase(it,this.End_())

        else

            var diff = x - s

            for n as uinteger = 1 to diff
                this.PushBack(v)
            next

        end if

    end sub

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).Empty ( ) as bool
        return m_node.next = @m_node
    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).Begin ( ) as typeof(Iterator)
        return m_node.next
    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).cBegin ( ) as typeof(IteratorToConst)
        return m_node.next
    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).End_ ( ) as typeof(Iterator)
        return @m_node
    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).cEnd ( ) as typeof(IteratorToConst)
        return @m_node
    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).Front ( ) as fbext_TypeName( T_) ptr
        return @cast(fbext_ListNodeT__( T_) ptr, m_node.next)->obj
    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).cFront ( ) as const fbext_TypeName( T_) ptr
        return @cast(const fbext_ListNodeT__( T_) ptr, m_node.next)->obj
    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).Back ( ) as fbext_TypeName( T_) ptr
        return @cast(fbext_ListNodeT__( T_) ptr, m_node.prev)->obj
    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).cBack ( ) as const fbext_TypeName( T_) ptr
        return @cast(const fbext_ListNodeT__( T_) ptr, m_node.prev)->obj
    end function

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).PushFront ( byref x as const fbext_TypeName( T_) )
        var tmp = this.Insert(m_node.next, x)
    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).PushBack ( byref x as const fbext_TypeName( T_) )
        var tmp = this.Insert(@m_node, x)
    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).PopFront ( )
        var tmp = this.Erase(m_node.next)
    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).PopBack ( )
        var tmp = this.Erase(m_node.prev)
    end sub

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).Insert ( byval position as typeof(Iterator), byref x as const fbext_TypeName( T_) ) as typeof(Iterator)

        var newnode = m_CreateNode(x)

        newnode->prev = position.m_node->prev
        newnode->next = position.m_node
        newnode->prev->next = newnode
        newnode->next->prev = newnode

        ' auto-converts from a node to an iterator..
        return newnode

    end function

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Insert ( byval position as typeof(Iterator), byval n as SizeType, byref x as const fbext_TypeName( T_) )

        for n = n to 1 step - 1
            position = this.Insert(position, x)
        next

    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Insert ( byval position as typeof(Iterator), byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )

        do while first <> last
            var tmp = this.Insert(position, **first)
            first.Increment()
        loop

    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Splice ( byval position as typeof(Iterator), byref lst as fbext_List(( T_)( Allocator_)) )

        this.Splice(position,lst,lst.Begin(),lst.End_())

    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Splice ( byval position as typeof(Iterator), byref lst as fbext_List(( T_)( Allocator_)), byval frst as typeof(Iterator) )

        this.Splice(position,lst,frst,lst.End_())

    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Splice ( byval position as typeof(Iterator), byref lst as fbext_List(( T_)( Allocator_)), byval frst as typeof(Iterator), byval lastp as typeof(Iterator) )

        var this_iter = position
        var first = frst
        var last = lastp

        do while first <> last
            var tmp = this.Insert(this_iter,*first.get())
            this_iter = tmp
            this_iter.Increment()
            first.Increment()
        loop

        var unused = lst.Erase(frst,lastp)

    end sub


    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).Erase ( byval position as typeof(Iterator) ) as typeof(Iterator)

        var nextnode = position.m_node->next

        ' remove from node chain..
        position.m_node->prev->next = nextnode
        nextnode->prev = position.m_node->prev

        ' destroy object and free node memory..
        var node = cast(fbext_ListNodeT__( T_) ptr, position.m_node)
        var talloc = fbext_TypeName( Allocator_)(( T_))
        talloc.Destroy(@node->obj)
        m_alloc.DeAllocate(node, 1)

        ' auto-converts from a node to an iterator..
        return nextnode

    end function

    '' :::::
    linkage_ function fbext_List(( T_)( Allocator_)).Erase ( byval first as typeof(Iterator), byval last as typeof(Iterator) ) as typeof(Iterator)

        do while first <> last
            first = this.Erase(first)
        loop
        return first

    end function

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).Clear ( )
        var tmp = this.Erase(m_node.next, @m_node)
    end sub

    '' :::::
    linkage_ sub fbext_List(( T_)( Allocator_)).RemoveIf ( byval pred as function ( byref as const fbext_TypeName( T_) ) as bool )

        dim first as typeof(Iterator) = m_node.next
        dim last as typeof(Iterator) = @m_node

        do while first <> last
            var nextnode = first : nextnode.Increment()
            if pred(**first) then
                var tmp = this.Erase(first)
            end if
            first = nextnode
        loop

    end sub
end namespace
:
# endmacro

fbext_InstanciateForBuiltins__(fbext_List)

# endif ' include guard
