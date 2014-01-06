'' Title: memory/allocator.bi
'' 
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
'' 
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

''namespace: ext

# include once "ext/memory/detail/common.bi"

	# define fbext_Allocator(targs_) fbext_TID(Allocator, targs_)
    
    # macro fbext_Allocator_Declare(T_)
    :
    namespace ext
        '' Class: fbext_Allocator((T_))
        ''  Macro template that generates the default allocator class for use
        ''  with *T_* objects.
        ''
        '' Parameters:
        ''  T_ - the type of object that is allocated and constructed.
        ''
        ''  This is the default allocator used in many portions of the
        ''  FreeBASIC Extended Library. It uses New[] and Delete[] to allocate
        ''  and deallocate memory for objects.
        type fbext_Allocator((T_))
        public:
            '' Sub: constructor
            ''  Constructs an allocator object.
            declare constructor ( )
            
            '' Sub: constructor
            ''  Constructs an allocator object from another. The new allocator
            ''  object can deallocate memory allocated by the other allocator
            ''  object, and vice-versa.
            declare constructor ( byref x as const fbext_Allocator((T_)) )
            
            '' Sub: destructor
            ''  Destructs the allocator object.
            declare destructor ( )
            
            '' Function: Allocate
            ''  Acquires memory for an array of *n* number of *T_* objects.
            ''
            '' Parameters:
            ''  n - the number of objects in the array.
            ''  hint - ignored.
            ''
            '' Returns:
            ''  Returns the address of the first object in the array.
            declare function Allocate ( byval n as SizeType, byval hint as fbext_TypeName(T_) ptr = 0 ) as fbext_TypeName(T_) ptr
            
            '' Sub: DeAllocate
            ''  Frees the memory of the array starting at the address *p*,
            ''  which contains *n* number of *T_* objects.
            ''
            '' Parameters:
            ''  p - the address of the first object.
            ''  n - the number of objects contained within the memory.
            declare sub DeAllocate ( byval p as fbext_TypeName(T_) ptr, byval n as SizeType )
            
            '' Sub: Construct
            ''  Copy constructs an object at address *p* with *value*.
            ''
            '' Parameters:
            ''  p - the address of the object to construct.
            ''  value - the value to construct the object with.
            declare sub Construct ( byval p as fbext_TypeName(T_) ptr, byref value as const fbext_TypeName(T_) )
            
            '' Sub: Destroy
            ''  Destroys the object at address *p* by calling its destructor.
            ''
            '' Parameters:
            ''  p - the address of the object to destroy.
            declare sub Destroy ( byval p as fbext_TypeName(T_) ptr )
        
        private:
            ' "Type cannot be empty" workaround.
            m_unused as integer
        end type
    end namespace
    :
    # endmacro

    # macro fbext_Allocator_Define(linkage_, T_)
    :
    namespace ext
        '' :::::
        linkage_ constructor fbext_Allocator((T_)) ( )
            ' nothing to be done here.
        end constructor
        
        '' :::::
        linkage_ constructor fbext_Allocator((T_)) ( byref x as const fbext_Allocator((T_)) )
            ' nothing to be done here.
        end constructor
        
        '' :::::
        linkage_ destructor fbext_Allocator((T_)) ( )
            ' nothing to be done here.
        end destructor
        
        '' :::::
        linkage_ function fbext_Allocator((T_)).Allocate ( byval n as SizeType, byval hint as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
            return cast(fbext_TypeName(T_) ptr, new byte[n * sizeof(fbext_TypeName(T_))])
        end function
        
        '' :::::
        linkage_ sub fbext_Allocator((T_)).DeAllocate ( byval p as fbext_TypeName(T_) ptr, byval n as SizeType )
            delete[] cast(byte ptr, p)
        end sub
        
        '' :::::
        linkage_ sub fbext_Allocator((T_)).Construct ( byval p as fbext_TypeName(T_) ptr, byref value as const fbext_TypeName(T_) )
        # if fbextPP_Stringize( fbext_TypeName(T_) ) = "string"
            clear *p, 0, sizeof(string)
            *p = value
        # elseif FBEXT_IS_SIMPLE(fbext_TypeName(T_))
            *p = value
        # else
            var tmp = new(p) fbext_TypeName(T_)(value)
        # endif
        end sub
        
        '' :::::
        linkage_ sub fbext_Allocator((T_)).Destroy ( byval p as fbext_TypeName(T_) ptr )
        # if fbextPP_Stringize( fbext_TypeName(T_) ) = "string"
            *p = ""
        # elseif not FBEXT_IS_SIMPLE(fbext_TypeName(T_))
            p->destructor()
        # endif
        end sub
    end namespace
    :
    # endmacro
    
    fbext_InstanciateForBuiltins__(fbext_Allocator)
