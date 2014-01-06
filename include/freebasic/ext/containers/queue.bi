'' Title: containers/queue.bi
'' 
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
'' 
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONTAINERS_QUEUE_BI__
# define FBEXT_CONTAINERS_QUEUE_BI__ -1

# include once "ext/detail/common.bi"
# include once "ext/containers/list.bi"

' elem 0: T_ - The element type.
' elem 1: Container_ - The underlying container type.
# define fbext_Queue( targs_)                fbext_TemplateID( Queue, targs_, fbext_Queue_DefaultTArgs() )
# define fbext_Queue_DefaultTArgs()          (__)((fbext_List))

# macro fbext_Queue_Declare(T_, Container_)
:
fbext_TDeclare(fbext_TypeName(Container_), (T_))

''namespace: ext
namespace ext
    
    '' Class: fbext_Queue((T_)(Container_))
    ''  Macro template that generates classes used to store element values
    ''  of type *T_* in a first-in first-out queue structure, using an
    ''  object of type *fbext_TypeName(Container_)(T_)* to actually store the elements.
    ''
    '' Parameters:
    ''  T_ - the type of element value stored in the queue.
    ''  Container_ - the name of the macro template used as the underlying
    ''      container class.
    ''
    ''  The macro template *Container_* must accept *T_* as its first
    ''  argument. It also must support the following member procedures:
    ''
    ''      - .Front( ) as T_ ptr
    ''      - .cFront( ) as const T_ ptr
    ''      - .Back( ) as T_ ptr
    ''      - .cBack( ) as const T_ ptr
    ''      - .PushBack( byref value as const T_ )
    ''      - .PopFront( )
    ''
    ''  By default, *Container_* is *fbext_List*.
    type fbext_Queue((T_)(Container_))
    public:
        '' Sub: default constructor
        ''  Constructs an empty queue.
        declare constructor ( )
        
        '' Sub: constructor
        ''  Constructs a queue consisting of copies of the elements from
        ''  the container object *c*.
        '' 
        '' Parameters:
        ''  c - a container object to copy elements from.
        declare constructor ( byref c as const fbext_TypeName(Container_)((T_)) )
        
        '' Function: Size
        ''  Returns the size of the queue.
        declare const function Size ( ) as ext.SizeType
        
        '' Function: Empty
        ''  Returns <ext.true> if the queue contains zero elements, or
        ''  <ext.false> otherwise.
        declare const function Empty ( ) as ext.bool
        
        '' Function: Front
        ''  Returns a pointer to the first element in the queue.
        declare function Front ( ) as fbext_TypeName(T_) ptr
        '' Function: cFront
        ''  Returns a pointer to the first element in the queue.
        declare const function cFront ( ) as const fbext_TypeName(T_) ptr
        
        '' Function: Back
        ''  Returns a pointer to the last element in the queue.
        declare function Back ( ) as fbext_TypeName(T_) ptr
        '' Function: cBack
        ''  Returns a pointer to the last element in the queue.
        declare const function cBack ( ) as const fbext_TypeName(T_) ptr
        
        '' Sub: Push
        ''  Adds an item onto the back of the queue.
        '' 
        '' Parameters:
        ''  x - the item to add.
        declare sub Push ( byref x as const fbext_TypeName(T_) )

        '' Sub: Pop
        ''  Removes the first element in the queue. 
        declare sub Pop ( )
    
    private:
        m_c as fbext_TypeName(Container_)((T_))
    end type

end namespace
:
# endmacro

# macro fbext_Queue_Define(linkage_, T_, Container_)
:
fbext_TDefine(fbext_TypeName(Container_), private, (T_))

namespace ext
    
    '' :::::
    linkage_ constructor fbext_Queue((T_)(Container_)) ( )
        ' nothing needs to be done.
    end constructor
    
    '' :::::
    linkage_ constructor fbext_Queue((T_)(Container_)) ( byref c as const fbext_TypeName(Container_)((T_)) )
        m_c = c
    end constructor
    
    '' :::::
    linkage_ function fbext_Queue((T_)(Container_)).Size ( ) as ext.SizeType
        return m_c.Size()
    end function
    
    '' :::::
    linkage_ function fbext_Queue((T_)(Container_)).Empty ( ) as ext.bool
        return m_c.Empty()
    end function
    
    '' :::::
    linkage_ function fbext_Queue((T_)(Container_)).Front ( ) as fbext_TypeName(T_) ptr
        return m_c.Front()
    end function
    
    '' :::::
    linkage_ function fbext_Queue((T_)(Container_)).cFront ( ) as const fbext_TypeName(T_) ptr
        return m_c.cFront()
    end function
    
    '' :::::
    linkage_ function fbext_Queue((T_)(Container_)).Back ( ) as fbext_TypeName(T_) ptr
        return m_c.Back()
    end function
    
    '' :::::
    linkage_ function fbext_Queue((T_)(Container_)).cBack ( ) as const fbext_TypeName(T_) ptr
        return m_c.cBack()
    end function
    
    '' :::::
    linkage_ sub fbext_Queue((T_)(Container_)).Push ( byref x as const fbext_TypeName(T_) )
        m_c.PushBack(x)
    end sub
    
    '' :::::
    linkage_ sub fbext_Queue((T_)(Container_)).Pop ( )
        m_c.PopFront()
    end sub

end namespace
:
# endmacro

fbext_InstanciateForBuiltins__(fbext_Queue)

# endif ' include guard
