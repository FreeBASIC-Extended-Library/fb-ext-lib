''Title: memory/sharedarray.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MEMORY_SHAREDARRAY_BI__
# define FBEXT_MEMORY_SHAREDARRAY_BI__ -1

# include once "ext/memory/detail/common.bi"

namespace ext

	'' Macro: FBEXT_SHAREDARRAY
	''
	# define fbext_SharedPtrArray(T_) fbext_TypeID((SharedPtrArray) T_)
	
	# macro fbext_SharedPtrArray_Declare(T_)
	:
		fbext_TDeclare(fbext_DestroyProc, (T_))
		
		type fbext_SharedPtrArray(T_)
		public:
			'' Sub: default constructor
			'' Constructs a fbext_SharedPtrArray(T_) with the address of an array of
			'' objects.
			''
			'' Parameters:
			'' p - The address of the array to reference.
			''
			'' Description:
			'' *p* defaults to //null// if not specified, meaning the
			'' fbext_SharedPtrArray(T_) references no resource. When the last fbext_SharedPtrArray(T_)
			'' referencing the resource is destroyed, ..DELETE[] will be called
			'' to free the resource.
			''
			declare constructor ( byval p as fbext_TypeName(T_) ptr = null )
			
			'' Sub: constructor
			'' Constructs a fbext_SharedPtrArray(T_) with the address of an array of
			'' objects.
			''
			'' Parameters:
			'' p - The address of the array to reference.
			'' destroy - The address of a procedure that will be passed the
			'' wrapped pointer when no more fbext_SharedPtrArray(T_) objects reference it.
			''
			'' Description:
			'' *p* defaults to //null// if not specified, meaning the
			'' fbext_SharedPtrArray(T_) references no resource. When the last fbext_SharedPtrArray(T_)
			'' referencing the resource is destroyed, *d* will be called to
			'' handle freeing the resource. If *d* is //null//, ..DELETE[] will
			'' be called instead.
			''
			declare constructor ( byval p as fbext_TypeName(T_) ptr, byval d as fbext_DestroyProc(T_) )
			
			'' Sub: copy constructor
			'' Constructs a fbext_SharedPtrArray(T_) by sharing the resource of another.
			''
			'' Parameters:
			'' x - The other fbext_SharedPtrArray(T_).
			''
			'' Description:
			'' The newly constructed fbext_SharedPtrArray(T_) will share the resource, if
			'' any, referenced by *x*. Any destruction procedure bound to the
			'' resource is also copied.
			''
			declare constructor ( byref x as fbext_SharedPtrArray(T_) )
			
			'' Sub: destructor
			'' Destroys a fbext_SharedPtrArray(T_).
			''
			'' Description:
			'' If no other fbext_SharedPtrArray(T_) references this resource, it is
			'' destroyed using ..DELETE[], or the user-supplied destruction
			'' procedure.
			''
			declare destructor ( )
			
			'' Operator: let
			'' Shares a resource with another fbext_SharedPtrArray(T_).
			''
			'' Parameters:
			'' x - The other fbext_SharedPtrArray(T_).
			''
			'' Description:
			'' If no other fbext_SharedPtrArray(T_) references this resource, it is
			'' destroyed using ..DELETE[], or the user-supplied destruction
			'' procedure. The fbext_SharedPtrArray(T_) will then share the resource, if
			'' any, of *x*.
			''
			'' Behaves like *this.Swap_(fbext_SharedPtrArray(T_)(x))*.
			''
			declare operator let ( byref x as fbext_SharedPtrArray(T_) )
			
			'' Function: Index
			'' Returns the address of an element in the referenced array.
			''
			'' Parameters:
			'' i - The 0-based offset of the element in the array.
			''
			'' Returns:
			'' The element at offset *i*.
			''
			declare function Index ( byval i as ext.SizeType ) as fbext_TypeName(T_) ptr
			
			'' Sub: Reset
			'' Forces the fbext_SharedPtrArray(T_) to reference another resource.
			''
			'' Parameters:
			'' p - The address of the new resource.
			''
			'' Description:
			'' If no other fbext_SharedPtrArray(T_) references this resource, it is
			'' destroyed using ..DELETE[], or the user-supplied destruction
			'' procedure. The fbext_SharedPtrArray(T_) will then reference the resource
			'' pointed to by *p*, or no resource if *p* is //null//.
			''
			'' Behaves like *this.Swap_(fbext_SharedPtrArray(T_)(p))*.
			''
			declare sub Reset ( byval p as fbext_TypeName(T_) ptr = null )
			
			'' Sub: Reset
			'' Forces the fbext_SharedPtrArray(T_) to reference another resource.
			''
			'' Parameters:
			'' p - The address of the new resource.
			'' destroy - The address of a procedure that will be passed the
			'' wrapped pointer when no more fbext_SharedPtrArray(T_) objects reference it.
			''
			'' Description:
			'' If no other fbext_SharedPtrArray(T_) references this resource, it is
			'' destroyed using ..DELETE[], or the user-supplied destruction
			'' procedure. The fbext_SharedPtrArray(T_) will then reference the resource
			'' pointed to by *p*, or no resource if *p* is //null//.
			''
			'' Behaves like *this.Swap_(fbext_SharedPtrArray(T_)(p, d))*.
			''
			declare sub Reset ( byval p as fbext_TypeName(T_) ptr, byval d as fbext_DestroyProc(T_) )
			
			'' Function: Get
			'' Retrieves the wrapped pointer.
			''
			'' Returns:
			'' Returns the address of the referenced resource.
			''
			declare function Get ( ) as fbext_TypeName(T_) ptr
			
			'' Sub: Swap_
			'' Swaps the value of this fbext_SharedPtrArray(T_) with another.
			''
			'' Description:
			'' The two fbext_SharedPtrArray(T_) objects will then reference each other's
			'' resources, if any.
			''
			declare sub Swap_ ( byref x as fbext_SharedPtrArray(T_) )
			
		private:
			m_p         as fbext_TypeName(T_) ptr = any
			m_destroy   as fbext_DestroyProc(T_) = any
			m_refcount  as ext.SizeType ptr = any
		end type
		
		'' Sub: Swap_
		'' Global ext.Swap_ overload.
		''
		declare sub Swap_ overload ( byref x as fbext_SharedPtrArray(T_), byref y as fbext_SharedPtrArray(T_) )
	:
	# endmacro

	# macro fbext_SharedPtrArray_Define(linkage_, T_)
	:
		'' :::::
		linkage_ constructor fbext_SharedPtrArray(T_) ( byval p as fbext_TypeName(T_) ptr )
			m_p = p
			m_destroy = null
			if m_p then
				m_refcount = new ext.SizeType(1)
			else
				m_refcount = null
			end if
		end constructor
		
		'' :::::
		linkage_ constructor fbext_SharedPtrArray(T_) ( byval p as fbext_TypeName(T_) ptr, byval d as fbext_DestroyProc(T_) )
			m_p = p
			m_destroy = d
			if m_p then
				m_refcount = new ext.SizeType(1)
			else
				m_refcount = null
			end if
		end constructor
		
		'' :::::
		linkage_ constructor fbext_SharedPtrArray(T_) ( byref x as fbext_SharedPtrArray(T_) )
			m_p = x.m_p
			m_destroy = x.m_destroy
			if x.m_refcount then
				m_refcount = x.m_refcount
				*m_refcount += 1
			else
				m_refcount = null
			end if
		end constructor
		
		'' :::::
		linkage_ destructor fbext_SharedPtrArray(T_) ( )
		
			if m_refcount then
				ASSERT( 0 < *m_refcount )
				*m_refcount -= 1
				
				if 0 = *m_refcount then
					ASSERT( null <> m_p )
					
					if m_destroy then
						m_destroy(m_p)
					else
						delete[] m_p
					end if
					
					delete m_refcount
				end if
			end if
		
		end destructor
		
		'' :::::
		linkage_ operator fbext_SharedPtrArray(T_).let ( byref x as fbext_SharedPtrArray(T_) )
			this.Swap_(fbext_SharedPtrArray(T_)(x))
		end operator
		
		'' :::::
		linkage_ function fbext_SharedPtrArray(T_).Index ( byval i as ext.SizeType ) as fbext_TypeName(T_) ptr
			return @m_p[i]
		end function
		
		'' :::::
		linkage_ sub fbext_SharedPtrArray(T_).Reset ( byval p as fbext_TypeName(T_) ptr )
			this.Swap_(fbext_SharedPtrArray(T_)(p))
		end sub
		
		'' :::::
		linkage_ sub fbext_SharedPtrArray(T_).Reset ( byval p as fbext_TypeName(T_) ptr, byval d as fbext_DestroyProc(T_) )
			this.Swap_(fbext_SharedPtrArray(T_)(p, d))
		end sub
		
		'' :::::
		linkage_ function fbext_SharedPtrArray(T_).Get ( ) as fbext_TypeName(T_) ptr
			return m_p
		end function
		
		'' :::::
		linkage_ sub fbext_SharedPtrArray(T_).Swap_ ( byref x as fbext_SharedPtrArray(T_) )
			swap m_p, x.m_p
			swap m_destroy, x.m_destroy
			swap m_refcount, x.m_refcount
		end sub
		
		'' ::::: Global ext.Swap_ overload
		linkage_ sub Swap_ ( byref x as fbext_SharedPtrArray(T_), byref y as fbext_SharedPtrArray(T_) )
			x.Swap_(y)
		end sub
	:
	# endmacro
	
    # ifndef FBEXT_NO_BUILTIN_INSTANCIATIONS
    
        fbext_InstanciateMulti(fbext_SharedPtrArray, fbext_NumericTypes())
    
    # endif

end namespace

# endif ' include guard
