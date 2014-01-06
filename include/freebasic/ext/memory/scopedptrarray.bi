''Title: memory/scopedptrarray.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MEMORY_SCOPEDPTRARRAY_BI__
# define FBEXT_MEMORY_SCOPEDPTRARRAY_BI__ -1

# include once "ext/memory/detail/common.bi"

'' Namespace: ext
namespace ext

	# define fbext_ScopedPtrArray(T_) fbext_TypeID((ScopedPtrArray) T_)
	
	# macro fbext_ScopedPtrArray_Declare(T_)
	:
		fbext_TDeclare(fbext_DestroyProc, (T_))

		''Class: ScopedArray
		''This class implements a pointer array container similiar to boost::scoped_array.
		''
		''Description:
		''A ScopedArray is guaranteed to be deleted when it goes out of scope.
		''
		''A ScopedArray has sole ownership of a pointer array, if assigned to another ScopedArray the new ScopedArray will gain ownership of the pointer array and the original ScopedArray is now invalid.
		''		
		type fbext_ScopedPtrArray(T_)
		public:
			''Sub: constuctor
			''This constructor takes another ScopedArray as its argument and transfers ownership to the newly created ScopedArray.
			'
			declare constructor ( byref x as fbext_ScopedPtrArray(T_) )

			''Sub: constructor
			''This constructor takes a pointer array of (type) and becomes responsible for its deletion.
			''
			''Description:
			''When constructing a ScopedArray with this constructor delete[] will be used to free the memory.
			''
			declare constructor ( byval p as fbext_TypeName(T_) ptr = null )

			''Sub: constructor
			''This constructor takes a pointer of (type) and will call a user passed subroutine to free the memory.
			''
			declare constructor ( byval p as fbext_TypeName(T_) ptr, byval destroy as fbext_DestroyProc(T_) )

			declare destructor ( )

			''Sub: Operator Let
			''Transfers ownership of a pointer to the lhs ScopedArray.
			''
			''Usage:
			''(begin code)
			''var myptr = type<ScopedArrayinteger>(new integer[10])
			''var mysecondptr = myptr
			''(end code)
			''mysecondptr now has control of the pointer array and myptr is invalid.
			''
			declare operator let ( byref rhs as fbext_ScopedPtrArray(T_) )

			''Sub: Operator Cast
			''Provided to allow passing a ScopedArray(type) to a procedure requiring a (type) ptr
			''
			declare operator cast ( ) as fbext_TypeName(T_) ptr

			''Function: Get
			''Provided to allow passing a ScopedArray(type) to a procedure requiring a (type) ptr
			''
			declare function Get ( ) as fbext_TypeName(T_) ptr
			
			''Function: index
			''Provided to allow accessing values in the pointer array.
			''
			declare function index ( byval rhs as integer ) as fbext_TypeName(T_)

		
		private:
			m_ptr as fbext_TypeName(T_) ptr = any
			m_destroy as fbext_DestroyProc(T_) = any
		
		end type
		
		''Function: * (dereference)
		''Dereferences the (type) pointer owned by a ScopedArray returning the value pointed to by the pointer.
		''
		declare operator * ( byref rhs as fbext_ScopedPtrArray(T_) ) as fbext_TypeName(T_)
	:
	# endmacro
	
	# macro fbext_ScopedPtrArray_Define(linkage_, T_)
	:
		'' :::::
		linkage_ constructor fbext_ScopedPtrArray(T_) ( byval p as fbext_TypeName(T_) ptr )
		
			m_ptr = p
			m_destroy = null
		
		end constructor
		
		'' :::::
		linkage_ constructor fbext_ScopedPtrArray(T_) ( byval p as fbext_TypeName(T_) ptr, byval destroy as fbext_DestroyProc(T_) )
		
			m_ptr = p
			m_destroy = destroy
		
		end constructor
		
		'' :::::
		linkage_ constructor fbext_ScopedPtrArray(T_) ( byref x as fbext_ScopedPtrArray(T_) )
		
			m_ptr = x.m_ptr
			m_destroy = x.m_destroy
			x.m_ptr = null
			x.m_destroy = null
		
		end constructor
		
		'' :::::
		linkage_ destructor fbext_ScopedPtrArray(T_) ( )
		
			if m_ptr <> null then
				if m_destroy <> null then 
					m_destroy(m_ptr)
				
				else
					delete[] m_ptr
				
				end if
			
			end if
		
		end destructor
		
		'' :::::
		linkage_ operator fbext_ScopedPtrArray(T_).let ( byref rhs as fbext_ScopedPtrArray(T_) )
		
			if m_ptr then
				if m_destroy then
					m_destroy(m_ptr)
				
				else
					delete[] m_ptr
				
				end if
			end if
			
			this.m_ptr = rhs.m_ptr
			this.m_destroy = rhs.m_destroy
			rhs.m_ptr = null
			rhs.m_destroy = null
		
		end operator
		
		'' :::::
		linkage_ operator * ( byref rhs as fbext_ScopedPtrArray(T_) ) as fbext_TypeName(T_)
		
			return *rhs.Get()
		
		end operator
		
		'' :::::
		linkage_ function fbext_ScopedPtrArray(T_).index ( byval rhs as integer ) as fbext_TypeName(T_)
		
			return m_ptr[rhs]
		
		end function

		'' :::::
		linkage_ function fbext_ScopedPtrArray(T_).Get ( ) as fbext_TypeName(T_) ptr

			return m_ptr

		end function
		
		'' :::::
		linkage_ operator fbext_ScopedPtrArray(T_).cast ( ) as fbext_TypeName(T_) ptr
		
			return m_ptr
		
		end operator
	:
	# endmacro

    # ifndef FBEXT_NO_BUILTIN_INSTANCIATIONS
    
        fbext_InstanciateMulti(fbext_ScopedPtrArray, fbext_NumericTypes())
    
    # endif

end namespace

# endif 'include guard
