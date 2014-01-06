'' Title: ext/containers/stack.bi
'' 
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
'' 
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONTAINERS_STACK_BI__
# define FBEXT_CONTAINERS_STACK_BI__ -1

# include once "ext/detail/common.bi"
# include once "ext/containers/array.bi"

' elem 0: T_ - The element type.
' elem 1: Container_ - The underlying container type.
# define fbext_Stack( targs_)                fbext_TemplateID( Stack, targs_, fbext_Stack_DefaultTArgs() )
# define fbext_Stack_DefaultTArgs()          (__)((fbext_Array))

# macro fbext_Stack_Declare(T_, Container_)
:
fbext_TDeclare(fbext_TypeName(Container_), (T_))

namespace ext

    '' Class: fbext_Stack
    ''  Macro template that generates classes used to store element values
    ''  of type *T_* in a last-in first-out stack structure, using an
    ''  object of type *Container_(T_)* to actually store the elements.
    ''
    '' Parameters:
    ''  T_ - the type of element value stored in the stack.
    ''  Container_ - the name of the macro template used as the underlying
    ''      container class.
    ''
    ''  The macro template *Container_* must accept *T_* as its first
    ''  argument. It also must support the following member procedures:
    ''
    ''      : .Back( ) as T_ ptr
    ''      : .cBack( ) as const T_ ptr
    ''      : .PushBack( byref value as const T_ )
    ''      : .PopBack( )
    ''
    ''  By default, *Container_* is _fbext_Array_, so the underlying container
    ''  object is <fbext_Array(T_)>.
    type fbext_Stack((T_)(Container_))
    public:
        '' Sub: constructor
        ''  Constructs an empty stack.
        declare constructor ( )
        
        '' Sub: constructor
        ''  Constructs a stack consisting of copies of the elements from
        ''  the container object *c*.
        '' 
        '' Parameters:
        ''  c - a container object to copy elements from.
        declare constructor ( byref c as const fbext_TypeName(Container_)((T_)) )
        
        '' Function: Size
        ''  Returns the size of the Stack.
        declare const function Size ( ) as ext.SizeType
        
        '' Function: Empty
        ''  Returns <ext.true> if the stack contains zero elements, or
        ''  <ext.false> otherwise.
        declare const function Empty ( ) as ext.bool
        
        '' Function: Top
        ''  Returns a pointer to the top-most element in the stack.
        declare function Top ( ) as fbext_TypeName(T_) ptr
        '' Function: cTop
        ''  Returns a pointer to the top-most element in the stack.
        declare const function cTop ( ) as const fbext_TypeName(T_) ptr
        
        '' Sub: Push
        ''  Adds an item onto the top of the stack.
        '' 
        '' Parameters:
        ''  x - the item to add.
        declare sub Push ( byref x as const fbext_TypeName(T_) )

        '' Sub: Pop
        ''  Removes the topmost item from the stack.
        declare sub Pop ( )
    
    private:
        m_c as fbext_TypeName(Container_)((T_))
    end type

end namespace
:
# endmacro

# macro fbext_Stack_Define(linkage_, T_, Container_)
:
fbext_TDefine(fbext_TypeName(Container_), private, (T_))

namespace ext

    '' :::::
    linkage_ constructor fbext_Stack((T_)(Container_)) ( )
        ' nothing needs to be done.
    end constructor
    
    '' :::::
    linkage_ constructor fbext_Stack((T_)(Container_)) ( byref c as const fbext_TypeName(Container_)((T_)) )
        m_c = c
    end constructor
    
    '' :::::
    linkage_ function fbext_Stack((T_)(Container_)).Size ( ) as ext.SizeType
        return m_c.Size()
    end function
    
    '' :::::
    linkage_ function fbext_Stack((T_)(Container_)).Empty ( ) as ext.bool
        return m_c.Empty()
    end function
    
    '' :::::
    linkage_ function fbext_Stack((T_)(Container_)).Top ( ) as fbext_TypeName(T_) ptr
        return m_c.Back()
    end function
    
    '' :::::
    linkage_ function fbext_Stack((T_)(Container_)).cTop ( ) as const fbext_TypeName(T_) ptr
        return m_c.cBack()
    end function
    
    '' :::::
    linkage_ sub fbext_Stack((T_)(Container_)).Push ( byref x as const fbext_TypeName(T_) )
        m_c.PushBack(x)
    end sub
    
    '' :::::
    linkage_ sub fbext_Stack((T_)(Container_)).Pop ( )
        m_c.PopBack()
    end sub

end namespace
:
# endmacro

fbext_InstanciateForBuiltins__(fbext_Stack)

# endif ' include guard
