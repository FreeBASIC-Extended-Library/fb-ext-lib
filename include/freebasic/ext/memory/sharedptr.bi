''Title: memory/sharedptr.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MEMORY_SHAREDPTR_BI__
# define FBEXT_MEMORY_SHAREDPTR_BI__ -1

# include once "ext/memory/detail/common.bi"

namespace ext

	# define fbext_SharedPtr(T_) fbext_TypeID((SharedPtr) T_)

	'' Macro: FBEXT_DECLARE_SHAREDPTR
	'' Defines the SharedPtr object class for a particular type, and
	'' any declarations it needs.
	''
	'' Parameters:
	'' fbext_TypeName(T_) - The type of SharedPtr to define.
	''
	# macro fbext_SharedPtr_Declare(T_)
	:
		fbext_TDeclare(fbext_DestroyProc, (T_))

		'' Class: SharedPtr
		'' A generic reference-counting smart pointer class.
		''
		'' Description:
		'' SharedPtr objects reference resources, and are responsible for
		'' freeing that resource when it's no longer referenced. Copying a
		'' SharedPtr results in another SharedPtr that shares the
		'' resource, if any, of the original. When all SharedPtr objects
		'' that share a particular resource are destroyed, the resource is also
		'' destroyed, using ..DELETE, or a user-defined destruction procedure.
		''
		''See Also:
		''<SharedPtr example>
		''
		type fbext_SharedPtr(T_)
		public:
			'' Sub: default constructor
			'' Constructs a fbext_SharedPtr(T_) with the address of a resource.
			''
			'' Parameters:
			'' p - The address of the resource to reference.
			''
			'' Description:
			'' *p* defaults to //null// if not specified, meaning the
			'' fbext_SharedPtr(T_) references no resource. When the last fbext_SharedPtr(T_)
			'' referencing the resource is destroyed, ..DELETE will be called
			'' to free the resource.
			''
			declare constructor ( byval p as fbext_TypeName(T_) ptr = null )

			'' Sub: constructor
			'' Constructs a fbext_SharedPtr(T_) with the address of a resource.
			''
			'' Parameters:
			'' p - The address of the resource to reference.
			'' destroy - The address of a procedure that will be passed the
			'' wrapped pointer when no more fbext_SharedPtr(T_) objects reference it.
			''
			'' Description:
			'' *p* defaults to //null// if not specified, meaning the
			'' fbext_SharedPtr(T_) references no resource. When the last fbext_SharedPtr(T_)
			'' referencing the resource is destroyed, *d* will be called to
			'' handle freeing the resource. If *d* is //null//, ..DELETE will
			'' be called instead.
			''
			declare constructor ( byval p as fbext_TypeName(T_) ptr, byval d as fbext_DestroyProc(T_) )

			'' Sub: copy constructor
			'' Constructs a fbext_SharedPtr(T_) by sharing the resource of another.
			''
			'' Parameters:
			'' x - The other fbext_SharedPtr(T_).
			''
			'' Description:
			'' The newly constructed fbext_SharedPtr(T_) will share the resource, if
			'' any, referenced by *x*. Any destruction procedure bound to the
			'' resource is also copied.
			''
			declare constructor ( byref x as fbext_SharedPtr(T_) )

			'' Sub: destructor
			'' Destroys a fbext_SharedPtr(T_).
			''
			'' Description:
			'' If no other fbext_SharedPtr(T_) references this resource, it is
			'' destroyed using ..DELETE, or the user-supplied destruction
			'' procedure.
			''
			declare destructor ( )

			'' Operator: let
			'' Shares a resource with another fbext_SharedPtr(T_).
			''
			'' Parameters:
			'' x - The other fbext_SharedPtr(T_).
			''
			'' Description:
			'' If no other fbext_SharedPtr(T_) references this resource, it is
			'' destroyed using ..DELETE, or the user-supplied destruction
			'' procedure. The fbext_SharedPtr(T_) will then share the resource, if
			'' any, of *x*.
			''
			'' Behaves like *this.Swap_(fbext_SharedPtr(T_)(x))*.
			''
			declare operator let ( byref x as fbext_SharedPtr(T_) )

			'' Sub: Reset
			'' Forces the fbext_SharedPtr(T_) to reference another resource.
			''
			'' Parameters:
			'' p - The address of the new resource.
			''
			'' Description:
			'' If no other fbext_SharedPtr(T_) references this resource, it is
			'' destroyed using ..DELETE, or the user-supplied destruction
			'' procedure. The fbext_SharedPtr(T_) will then reference the resource
			'' pointed to by *p*, or no resource if *p* is //null//.
			''
			'' Behaves like *this.Swap_(fbext_SharedPtr(T_)(p))*.
			''
			declare sub Reset ( byval p as fbext_TypeName(T_) ptr = null )

			'' Sub: Reset
			'' Forces the fbext_SharedPtr(T_) to reference another resource.
			''
			'' Parameters:
			'' p - The address of the new resource.
			'' destroy - The address of a procedure that will be passed the
			'' wrapped pointer when no more fbext_SharedPtr(T_) objects reference it.
			''
			'' Description:
			'' If no other fbext_SharedPtr(T_) references this resource, it is
			'' destroyed using ..DELETE, or the user-supplied destruction
			'' procedure. The fbext_SharedPtr(T_) will then reference the resource
			'' pointed to by *p*, or no resource if *p* is //null//.
			''
			'' Behaves like *this.Swap_(fbext_SharedPtr(T_)(p, d))*.
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
			'' Swaps the value of this fbext_SharedPtr(T_) with another.
			''
			'' Description:
			'' The two fbext_SharedPtr(T_) objects will then reference each other's
			'' resources, if any.
			''
			declare sub Swap_ ( byref x as fbext_SharedPtr(T_) )

		private:
			m_obj		as fbext_TypeName(T_) ptr = any
			m_destroy	as fbext_DestroyProc(T_) = any
			m_refcount	as SizeType ptr = any
		end type
	:
	# endmacro

	'' Macro: FBEXT_DEFINE_SHAREDPTR
	'' Defines the fbext_SharedPtr(T_) object class implementation.
	''
	'' Parameters:
	'' fbext_TypeName(T_) - The type of SharedPtr implementation to define.
	''
	# macro fbext_SharedPtr_Define(linkage_, T_)
	:
		'' :::::
		linkage_ constructor fbext_SharedPtr(T_) ( byval p as fbext_TypeName(T_) ptr )
			m_obj = p
			m_destroy = null
			if m_obj then
				m_refcount = new SizeType(1)
			end if
		end constructor

		'' :::::
		linkage_ constructor fbext_SharedPtr(T_) ( byval p as fbext_TypeName(T_) ptr, byval d as fbext_DestroyProc(T_) )
			m_obj = p
			m_destroy = d
			if m_obj then
				m_refcount = new SizeType(1)
			end if
		end constructor

		'' :::::
		linkage_ constructor fbext_SharedPtr(T_) ( byref x as fbext_SharedPtr(T_) )
			m_obj = x.m_obj
			m_destroy = x.m_destroy
			if x.m_refcount then
				m_refcount = x.m_refcount
				*m_refcount += 1
			else
				m_refcount = null
			end if
		end constructor

		'' :::::
		linkage_ destructor fbext_SharedPtr(T_) ( )

			if m_refcount then
				ASSERT( 0 < *m_refcount )
				*m_refcount -= 1

				if 0 = *m_refcount then
					ASSERT( null <> m_obj )

					if m_destroy then
						m_destroy(m_obj)
					else
						delete m_obj
					end if

					delete m_refcount
				end if
			end if

		end destructor

		'' :::::
		linkage_ operator fbext_SharedPtr(T_).let ( byref x as fbext_SharedPtr(T_) )
			this.Swap_(fbext_SharedPtr(T_)(x))
		end operator

		'' :::::
		linkage_ sub fbext_SharedPtr(T_).Reset ( byval p as fbext_TypeName(T_) ptr )
			this.Swap_(fbext_SharedPtr(T_)(p))
		end sub

		'' :::::
		linkage_ sub fbext_SharedPtr(T_).Reset ( byval p as fbext_TypeName(T_) ptr, byval d as fbext_DestroyProc(T_) )
			this.Swap_(fbext_SharedPtr(T_)(p, d))
		end sub

		'' :::::
		linkage_ function fbext_SharedPtr(T_).Get ( ) as fbext_TypeName(T_) ptr
			return m_obj
		end function

		'' :::::
		linkage_ sub fbext_SharedPtr(T_).Swap_ ( byref x as fbext_SharedPtr(T_) )
			swap m_obj, x.m_obj
			swap m_destroy, x.m_destroy
			swap m_refcount, x.m_refcount
		end sub
	:
	# endmacro

    '#ifndef fbext_NoBuiltinInstanciations
       'fbext_InstanciateMulti(fbext_SharedPtr, fbext_NumericTypes())
    '#endif

end namespace

# endif ' include guard
