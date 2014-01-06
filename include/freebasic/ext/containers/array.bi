'' Title: ext/containers/array.bi
''
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONTAINERS_ARRAY_BI__
# define FBEXT_CONTAINERS_ARRAY_BI__ -1

# include once "ext/detail/common.bi"
# include once "ext/memory/allocator.bi"
# include once "ext/memory/construct.bi"
# include once "ext/algorithms/uninitializedcopy.bi"
# include once "ext/algorithms/uninitializedfilln.bi"
# include once "ext/algorithms/copy.bi"
# include once "ext/algorithms/copybackward.bi"
# include once "ext/algorithms/fill.bi"
# include once "ext/algorithms/quicksort.bi"

'' Macro: fbext_Array
''  This macro expands to the name of the fbext_Array type. It expects a single
''  parameter which is a sequence of template arguments, which are described
''  below. Note that this is an unqualified name (no "ext." prefix).
''     elem 0: T_ - Element type stored in the array.
''     elem 1: Allocator_ - Name of allocator template. If not specified,
''             fbext_Allocator is used.
# define fbext_Array( targs_)       fbext_TemplateID( Array, targs_, fbext_Array_DefaultTArgs() )
# define fbext_Array_DefaultTArgs() (__)((fbext_Allocator))

'' Macro: fbext_Array_Declare
''  This macro expands to the definition of the fbext_Array class. It is not
''  intented to be used directly, but through a call to fbext_TDeclare.
# macro fbext_Array_Declare( T_, Allocator_)
:
fbext_TDeclare( fbext_TypeName( Allocator_), ( T_))

namespace ext

    '' Class: ext.fbext_Array(( T_)( Allocator_))
    ''  A generic variable-length array.
    type fbext_Array(( T_)( Allocator_))
    public:
        declare static function Iterator as fbext_TypeName( T_) ptr
        declare static function IteratorToConst as const fbext_TypeName( T_) ptr

        '' Group: Construction/Destruction/Assignment

        '' Sub: default constructor
        ''  Constructs an empty array (having zero elements).
        declare constructor ( )

        'does not work, needs allocator inheritable type
        ' Sub: constructor with allocator
        ' Constructs an empty array with a custom allocator.
        '
        ' Parameters:
        ' a - the <fbext_Allocator> to use.
        'declare constructor ( byref alloc as as fbext_TypeName( Allocator_)(( T_)) )

        '' Sub: copy constructor
        ''  Constructs an array consisting of copies of the elements from
        ''  another.
        ''
        '' Parameters:
        ''  x - an array containing the elements to copy.
        declare constructor ( byref x as const fbext_Array(( T_)( Allocator_)) )

        '' Sub: repeat constructor
        ''  Constructs an array consisting of copies of the default value.
        ''
        '' Parameters:
        ''  n - the number of copies to make.
        declare constructor ( byval n as SizeType )

        '' Sub: repeat constructor
        ''  Constructs an array consisting of copies of an element value.
        ''
        '' Parameters:
        ''  n - the number of copies to make.
        ''  value - the value to copy.
        declare constructor ( byval n as SizeType, byref value as const fbext_TypeName( T_) )

        '' Sub: ranged constructor
        ''  Constructs an array from a copy of a range of elements.
        ''
        '' Parameters:
        ''  first - an iterator to the first element in a range.
        ''  last - an iterator to one-passed the last element in a range.
        declare constructor ( byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )

        '' Sub: destructor
        ''  Destroys the array.
        declare destructor ( )

        '' Sub: copy operator let
        ''  Copy assigns to the array from another.
        ''
        '' Parameters:
        ''  x - The array to copy.
        declare operator let ( byref x as const fbext_Array(( T_)( Allocator_)) )

        '' Group: Capacity

        '' Function: Size
        ''  Gets the number of elements in the array.
        ''
        '' Returns:
        ''  Returns the number of elements.
        declare const function Size ( ) as SizeType

        '' Function: Capacity
        ''  Gets the maximum number of elements the array can store without
        ''  requiring additional memory.
        ''
        '' Returns:
        ''  Returns the number of elements.
        declare const function Capacity ( ) as SizeType

        '' Function: Empty
        ''  Determines if the array contains elements or not.
        ''
        '' Returns:
        ''  Returns true if the array has zero elements, false otherwise.
        declare const function Empty ( ) as bool

        '' Function: Reserve
        ''  Ensures that the capacity of the array is at least *n*. If *n*
        ''  is greater than <Capacity>, then the storage is reallocated.
        ''
        '' Parameters:
        ''  n - the requested minimum capacity.
        declare sub Reserve ( byval n as SizeType )

        '' Function: Resize
        ''  Changes the size of the array to *newsize* number of elements.
        ''
        '' Parameters:
        ''  newsize - the requested new size.
        declare sub Resize ( byval newsize as SizeType )
        '' Function: Resize
        ''  Changes the size of the array to *newsize* number of elements
        ''
        '' Parameters:
        ''  newsize - the requested new size.
        ''  value - if *newsize* is greater than <Size>, the new elements
        ''      are copied from this value.
        declare sub Resize ( byval newsize as SizeType, byref value as const fbext_TypeName( T_) )

        '' Group: Iterators

        '' Sub: sort
        ''  Sorts the array using the default type comparator.
        ''
        '' Parameters:
        '' first - the index to begin sorting at, defaults to the first element
        '' last - the last index to sort, defaults to the last element
        declare sub Sort ( byval first as fbext_TypeName( T_) ptr = 0, byval last as fbext_TypeName( T_) ptr = 0 )

        '' Function: Begin
        ''  Gets an iterator to the element at the front of the array.
        ''
        '' Returns:
        ''  Returns an iterator to the element.
        declare function Begin ( ) as typeof(Iterator)
        '' Function: cBegin
        ''  Gets an iterator to the element at the front of the array; the
        ''  element in immutable.
        ''
        '' Returns:
        ''  Returns an iterator to the element.
        declare const function cBegin ( ) as typeof(IteratorToConst)

        '' Function: End_
        ''  Gets an iterator to the element at the back of the array.
        ''
        '' Returns:
        ''  Returns an iterator to the element.
        declare function End_ ( ) as typeof(Iterator)
        '' Function: cEnd
        ''  Gets an iterator to the element at the back of the array; the
        ''  element is immutable.
        ''
        '' Returns:
        ''  Returns an iterator to the element.
        declare const function cEnd ( ) as typeof(IteratorToConst)

        '' Group: Elements

        '' Function: Front
        ''  Gets a pointer to the element at the front of the array.
        ''
        '' Returns:
        ''  Returns a pointer to the element.
        declare function Front ( ) as fbext_TypeName( T_) ptr
        '' Function: cFront
        ''  Gets a pointer to the element at the front of the array; the
        ''  element is immutable.
        ''
        '' Returns:
        ''  Returns a pointer to the element.
        declare const function cFront ( ) as const fbext_TypeName( T_) ptr

        '' Function: Back
        ''  Gets a pointer to the element at the back of the array.
        ''
        '' Returns:
        ''  Returns a pointer to the element.
        declare function Back ( ) as fbext_TypeName( T_) ptr
        '' Function: cBack
        ''  Gets a pointer to the element at the back of the array; the
        ''  element is immutable.
        ''
        '' Returns:
        ''  Returns a pointer to the element.
        declare const function cBack ( ) as const fbext_TypeName( T_) ptr

        '' Function: Index
        ''  Gets a pointer to the element at index *n* in the array.
        ''
        '' Parameters:
        ''  n - the index of the elements to retrieve.
        ''
        '' Returns:
        ''  Returns a pointer to the element. If *n* >= <Size>() then the
        ''  behavior is undefined.
        declare function Index ( byval n as SizeType ) as fbext_TypeName( T_) ptr
        '' Function: cIndex
        ''  Gets a pointer to the element at index *n* in the array; the
        ''  element is immutable.
        ''
        '' Parameters:
        ''  n - the index of the elements to retrieve.
        ''
        '' Returns:
        ''  Returns a pointer to the element. If *n* >= <Size>() then the
        ''  behavior is undefined.
        declare const function cIndex ( byval n as SizeType ) as const fbext_TypeName( T_) ptr
        ''Function: at
        '' Gets a pointer the element at index *n* in the array.
        ''
        ''Parameters:
        '' n - the index of the element to retrieve
        ''
        ''Returns:
        '' Returns a pointer to the element. If *n* >= <Size>() then the
        '' returned pointer is null.
        declare function at ( byval n as SizeType ) as fbext_TypeName( T_) ptr

        '' Group: Insertion/Erasure

        '' Sub: PushBack
        ''  Inserts an element value at the back of the array.
        ''
        '' Parameters:
        ''  value - the value to insert.
        declare sub PushBack ( byref value as const fbext_TypeName( T_) )

        '' Sub: PopBack
        ''  Erases the element at the back of the array.
        declare sub PopBack ( )

        '' Function: Insert
        ''  Inserts an element before a certain position in the array.
        ''
        '' Parameters:
        ''  position - an iterator to an element in the array; the new
        ''      element will be added before this element.
        ''  value - the value to add.
        ''
        '' Returns:
        ''  Returns an iterator to the newly inserted element.
        declare function Insert ( _
            byval position as typeof(Iterator),         _
            byref value as const fbext_TypeName( T_)    _
        ) as typeof(Iterator)

        '' Sub: Insert
        ''  Inserts a range of elements before a certain position in the
        ''  array.
        ''
        '' Parameters:
        ''  position - an iterator to an element in the array; the new
        ''      elements will be added before this element.
        ''  first - an iterator to the beginning of a range of elements to add.
        ''  last - an iterator to one-passed the last element of the range.
        declare sub Insert ( _
            byval position as typeof(Iterator),         _
            byval first as typeof(IteratorToConst),     _
            byval last as typeof(IteratorToConst)       _
        )

        '' Sub: Insert
        ''  Inserts a number of copies of an element value before a certain
        ''  position in the array.
        ''
        '' Parameters:
        ''  position - an iterator to an element in the array; the new
        ''      elements will be added before this element.
        ''  n - the number of copies to insert.
        ''  x - the value to insert.
        declare sub Insert ( _
            byval position as typeof(Iterator),         _
            byval n as SizeType,                        _
            byref value as const fbext_TypeName( T_)    _
        )

        '' Function: Erase
        ''  Removes an element from the array.
        ''
        '' Parameters:
        ''  position - an iterator to the element to be removed.
        ''
        '' Returns:
        ''  Returns an iterator to the next element in the array, or
        ''  `this.End_()` if there are no such elements.
        declare function Erase ( _
            byval position as typeof(Iterator)          _
        ) as typeof(Iterator)

        '' Function: Erase
        ''  Removes a range of elements from the array.
        ''
        '' Parameters:
        ''  first - an iterator to the first element to be removed.
        ''  last - an iterator to one-passed the last element to be removed.
        ''
        '' Returns:
        ''  Returns an iterator to the next element in the array, or
        ''  `this.End_()` if there are no such elements.
        declare function Erase ( _
            byval first as typeof(Iterator),            _
            byval last as typeof(Iterator)              _
        ) as typeof(Iterator)

        '' Sub: Clear
        ''  Removes all of the elements in the array.
        declare sub Clear ( )

        '' Group: Miscellaneous

        '' Sub: Swap_
        ''  Swaps the contents of the array with another in constant time.
        ''
        '' Parameters:
        ''  x - the array to swap.
        declare sub Swap_ ( byref x as typeof( fbext_Array(( T_)( Allocator_)) ) )

    private:
        declare sub m_InsertAux ( byval position as typeof(Iterator), byref x as const fbext_TypeName( T_) )
        declare sub m_EraseAtEnd ( byval position as typeof(Iterator) )

        m_alloc     as fbext_TypeName( Allocator_)(( T_))
        ' constructors make sure these are initialized..
        m_start     as fbext_TypeName( T_) ptr = any
        m_finish    as fbext_TypeName( T_) ptr = any
        m_eos       as fbext_TypeName( T_) ptr = any

        #ifdef FBEXT_MULTITHREADED
        m_mutex as any ptr
        #endif
    end type
end namespace
:
# endmacro

# define fbext_ArraySize__(a) (a.m_finish - a.m_start)

# macro fbext_Array_Define(linkage_, T_, Allocator_)
:
fbext_TDeclare(fbext_Array, ( T_)( Allocator_))

fbext_TDeclare(fbext_Construct, ( T_))
fbext_TDeclare(fbext_UninitializedCopy, ( T_))
fbext_TDeclare(fbext_UninitializedFillN, ( T_))
fbext_TDeclare(fbext_Copy, ( T_))
fbext_TDeclare(fbext_CopyBackward, ( T_))
fbext_TDeclare(fbext_Fill, ( T_))
fbext_TDeclare(fbext_quickSort, ( T_))

fbext_TDefine(fbext_Construct, private, ( T_))
fbext_TDefine(fbext_TypeName( Allocator_),   private, ( T_))
fbext_TDefine(fbext_UninitializedCopy, private, ( T_))
fbext_TDefine(fbext_UninitializedFillN, private, ( T_))
fbext_TDefine(fbext_Copy, private, ( T_))
fbext_TDefine(fbext_CopyBackward, private, ( T_))
fbext_TDefine(fbext_Fill, private, ( T_))
fbext_TDefine(fbext_quickSort, private, ( T_))

namespace ext

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).sort overload ( byval first as fbext_TypeName( T_) ptr, byval last as fbext_TypeName( T_) ptr )
        var fs = first
        var ls = last

        if fs = 0 then fs = Front()
        if ls = 0 then ls = Back() +1

        quickSort( fs, ls )
    end sub

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).at ( byval n as SizeType ) as fbext_TypeName( T_) ptr

    if n < (m_finish - m_start) then
        return @(m_start[n])
    else
        return null
    end if

    end function

    'linkage_ constructor fbext_Array(( T_)( Allocator_)) ( byref a as fbext_TypeName( Allocator_)(( T_)) )
    '    m_start = 0
    '    m_finish = 0
    '    m_eos = 0
    '    m_alloc = a

    '    #ifdef FBEXT_MULTITHREADED
    '    m_mutex = mutexcreate()
    '    #endif
    'end constructor

    '' :::::
    linkage_ constructor fbext_Array(( T_)( Allocator_)) ( )
        m_start = 0
        m_finish = 0
        m_eos = 0

        #ifdef FBEXT_MULTITHREADED
        m_mutex = mutexcreate()
        #endif
    end constructor

    '' :::::
    linkage_ constructor fbext_Array(( T_)( Allocator_)) ( byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )

        m_start = 0
        m_finish = 0
        m_eos = 0

        #ifdef FBEXT_MULTITHREADED
        m_mutex = mutexcreate()
        #endif

        do while first <> last
            this.PushBack(*first)
            first += 1
        loop

    end constructor

    '' :::::
    linkage_ constructor fbext_Array(( T_)( Allocator_)) ( byref x as const fbext_Array(( T_)( Allocator_)) )

        #ifdef FBEXT_MULTITHREADED
        m_mutex = mutexcreate()
        #endif

        var n = fbext_ArraySize__(x)

        if 0 < n then
            m_start = m_alloc.Allocate(n)
            m_finish = ext.UninitializedCopy(x.m_start, x.m_finish, m_start)
            m_eos = m_finish

        else
            m_start = 0
            m_finish = 0
            m_eos = 0

        end if

    end constructor

    '' :::::
    linkage_ constructor fbext_Array(( T_)( Allocator_)) ( byval n as SizeType )

    # if FBEXT_IS_STRING( fbext_TypeID( T_) )
        constructor(n, "")
    # elseif FBEXT_IS_SIMPLE( fbext_TypeID( T_) )
        constructor(n, 0)
    # else
        constructor(n, fbext_TypeName( T_)())
    # endif

    end constructor

    '' :::::
    linkage_ constructor fbext_Array(( T_)( Allocator_)) ( byval n as SizeType, byref value as const fbext_TypeName( T_) )

        #ifdef FBEXT_MULTITHREADED
        m_mutex = mutexcreate()
        #endif

        m_start = 0
        m_finish = 0
        m_eos = 0

        this.Insert(m_start, n, value)

    end constructor

    '' :::::
    linkage_ operator fbext_Array(( T_)( Allocator_)).let ( byref x as const fbext_Array(( T_)( Allocator_)) )

        if @this <> @x then
        ' fixme: use a more efficient algorithm than this..
            Clear()
            var first = x.cBegin(), last = x.cEnd()
            do while first <> last
                this.PushBack(*first)
                first += 1
            loop
        end if

    end operator

    '' :::::
    linkage_ destructor fbext_Array(( T_)( Allocator_)) ( )
        Clear()
        #ifdef FBEXT_MULTITHREADED
        mutexdestroy( m_mutex )
        #endif
    end destructor

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Size () as SizeType

        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        var x = fbext_ArraySize__(this)

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif

        return x

    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Capacity () as SizeType

        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        var x = m_eos - m_start

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif

        return x

    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Empty ( ) as bool

        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        var x = ( m_start = m_finish )

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif

        return x

    end function

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).Reserve ( byval n as SizeType )

        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        dim old_capacity as SizeType = m_eos - m_start
        if n > old_capacity then

            var old_size = m_finish - m_start
            var new_capacity = old_size + iif(old_size > n, old_size, n)

            var new_start = m_alloc.Allocate(new_capacity)
            var new_finish = ext.UninitializedCopy( _
                    m_start, m_start + old_size, new_start)

            var p = m_start
            do while p <> m_finish
                m_alloc.Destroy(p)
                p += 1
            loop
            m_alloc.DeAllocate(m_start, old_size)

            m_start = new_start
            m_finish = new_finish
            m_eos = new_start + new_capacity

        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif

    end sub

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).Resize ( byval newsize as SizeType )
        dim value as fbext_TypeName( T_)
        this.Resize(newsize, value)
    end sub

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).Resize ( byval newsize as SizeType, byref x as const fbext_TypeName( T_) )

        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        if newsize < fbext_ArraySize__(this) then

            m_EraseAtEnd(m_start + newsize)

        else
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
            Insert(m_finish, newsize - fbext_ArraySize__(this), x)

        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif

    end sub

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Begin ( ) as typeof(Iterator)
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif
        var x = m_start
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).cBegin ( ) as typeof(IteratorToConst)
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif
        var x = m_start
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).End_ ( ) as typeof(Iterator)
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif
        var x = m_finish
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).cEnd ( ) as typeof(IteratorToConst)
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif
        var x = m_finish
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Front ( ) as fbext_TypeName( T_) ptr
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif
        var x = m_start
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).cFront ( ) as const fbext_TypeName( T_) ptr
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif
        var x = m_start
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Back ( ) as fbext_TypeName( T_) ptr
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        var x = m_finish - 1

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif

        return x
    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).cBack ( ) as const fbext_TypeName( T_) ptr
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        var x = m_finish - 1

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    linkage_ function fbext_Array(( T_)( Allocator_)).Index ( byval n as SizeType ) as fbext_TypeName( T_) ptr
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        var x = m_start + n

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    linkage_ function fbext_Array(( T_)( Allocator_)).cIndex ( byval n as SizeType ) as const fbext_TypeName( T_) ptr
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        var x = m_start + n

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return x
    end function

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).PushBack ( byref x as const fbext_TypeName( T_) )
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        if m_finish <> m_eos then
            m_alloc.Construct(m_finish, x)
            m_finish += 1

        else
            m_InsertAux(m_finish, x)

        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
    end sub

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).PopBack ( )
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        m_finish -= 1
        m_alloc.Destroy(m_finish)

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
    end sub

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Insert ( byval position as typeof(Iterator), byref x as const fbext_TypeName( T_) ) as typeof(Iterator)
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        var n = cast(SizeType, position - m_start)

        if (m_finish <> m_eos) and (position = m_finish) then
            m_alloc.Construct(m_finish, x)
            m_finish += 1

        else
            m_InsertAux(position, x)

        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif

        return m_start + n

    end function

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).Insert ( byval position as typeof(Iterator), byval n as SizeType, byref x as const fbext_TypeName( T_) )

        if 0 = n then return

        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        if m_eos - m_finish >= n then
            var elems_after = cast(SizeType, m_finish - position)
            var old_finish = m_finish

            if elems_after > n then
                ' copy elements that will bleed into the void..
                ext.UninitializedCopy(m_finish - n, m_finish, m_finish)
                m_finish += n

                ' copy remaining elements..
                ext.CopyBackward(position, old_finish - n, old_finish)

                ' fill the gap with the copies..
                ext.Fill(position, position + n, x)

            else
                ' fill the void with copies..
                ext.UninitializedFillN(m_finish, n - elems_after, x)
                m_finish += n - elems_after

                ' copy remaining elements into the void..
                ext.UninitializedCopy(position, old_finish, m_finish)
                m_finish += elems_after

                ' fill the gap with copies..
                ext.Fill(position, old_finish, x)

            end if

        else
            var old_size = fbext_ArraySize__(this)
            var length = old_size + iif(old_size > n, old_size, n)

            var new_start = m_alloc.Allocate(length)

            ' copy up to position elements into new void..
            var new_finish = ext.UninitializedCopy( _
                    m_start, position, new_start)

            ' fill new void with copies..
            ext.UninitializedFillN(new_finish, n, x)
            new_finish += n

            ' copy remaining elements into the new void..
            new_finish = ext.UninitializedCopy(position, m_finish, new_finish)

            var p = m_start
            do while p <> m_finish
                m_alloc.Destroy(p)
                p += 1
            loop
            m_alloc.DeAllocate(m_start, old_size)

            m_start = new_start
            m_finish = new_finish
            m_eos = m_start + length
        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
    end sub

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).Insert ( byval position as typeof(Iterator), byval first as typeof(IteratorToConst), byval last as typeof(IteratorToConst) )
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        do while first <> last
            position = this.Insert(position, *first)
            position += 1
            first += 1
        loop

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
    end sub

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Erase ( byval position as typeof(Iterator) ) as typeof(Iterator)
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif

        ' remaining elements to copy ?
        if position + 1 <> m_finish then
            ext.Copy(position + 1, m_finish, position)
        end if
        m_finish -= 1
        m_alloc.Destroy(m_finish)

        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return position

    end function

    '' :::::
    linkage_ function fbext_Array(( T_)( Allocator_)).Erase ( byval first as typeof(Iterator), byval last as typeof(Iterator) ) as typeof(Iterator)
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif
        ' remaining elements to copy ?
        if last <> m_finish then
            ext.Copy(last, m_finish, first)
        end if

        m_EraseAtEnd(first + (m_finish - last))
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
        return first

    end function

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).Clear ( )
        #ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        #endif
        m_EraseAtEnd(m_start)
        #ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        #endif
    end sub

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).Swap_ ( byref x as typeof( fbext_Array(( T_)( Allocator_)) ) )
        swap m_start, x.m_start
        swap m_finish, x.m_finish
        swap m_eos, x.m_eos
    end sub

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).m_InsertAux ( byval position as typeof(Iterator), byref x as const fbext_TypeName( T_) )

        ' we have enough capacity for the new element (size <> capacity) ?
        if m_finish <> m_eos then
            ' copy last element into the void..
            m_alloc.Construct(m_finish, *(m_finish - 1))
            m_finish += 1

            ' shift remaining elements..
            ext.CopyBackward(position, m_finish - 2, m_finish - 1)

            ' copy x (fill the gap)..
            *position = x

        ' we need to allocate more memory for the element ?
        else
            var old_size = cast(SizeType, fbext_ArraySize__(this))
            var length = cast(SizeType, iif(old_size, 2 * old_size, 1))

            var new_start = m_alloc.Allocate(length)

            ' copy up to position elements into the new void..
            var new_finish = ext.UninitializedCopy( _
                    m_start, position, new_start)

            ' copy x into the new void..
            m_alloc.Construct(new_finish, x)
            new_finish += 1

            ' copy remaining elements into the new void..
            new_finish = ext.UninitializedCopy( _
                    position, m_finish, new_finish)

            var p = m_start
            do while p <> m_finish
                m_alloc.Destroy(p)
                p += 1
            loop
            m_alloc.DeAllocate(m_start, old_size)

            m_start = new_start
            m_finish = new_finish
            m_eos = m_start + length

        end if

    end sub

    '' :::::
    linkage_ sub fbext_Array(( T_)( Allocator_)).m_EraseAtEnd ( byval position as typeof(Iterator) )

        var p = position
        do while p <> m_finish
            m_alloc.Destroy(p)
            p += 1
        loop
        m_finish = position

    end sub

end namespace
:
# endmacro

fbext_InstanciateForBuiltins__(fbext_Array)

# endif ' include guard
