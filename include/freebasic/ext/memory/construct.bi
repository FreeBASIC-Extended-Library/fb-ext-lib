''Title: memory/construct.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MEMORY_CONSTRUCT_BI__
# define FBEXT_MEMORY_CONSTRUCT_BI__ -1

# include once "ext/memory/detail/common.bi"
# include once "ext/algorithms/detail/common.bi"

	''Macro: FBEXT_DECLARE_CONSTRUCT
	''
	# macro fbext_Construct_Declare(T_)
	:
	namespace ext
	# if fbext_TypeID(T_) = string
		declare sub Construct overload ( byval p as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) = "" )
	# elseif FBEXT_IS_SIMPLE(fbext_TypeName(T_))
		declare sub Construct overload ( byval p as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) = 0 )
	
	# else
		declare sub Construct overload ( byval p as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) = fbext_TypeName(T_)() )
	
	# endif
	end namespace
	:
	# endmacro
	
	''Macro: FBEXT_DEFINE_CONSTRUCT
	''
	# macro fbext_Construct_Define(linkage_, T_)
	:
	namespace ext
	# if fbext_TypeID(T_) = string
		'' :::::
		linkage_ sub Construct ( byval p as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) )
			clear *p, 0, sizeof(string)
			*p = x
		end sub
	# elseif FBEXT_IS_SIMPLE(fbext_TypeName(T_))
		'' :::::
		linkage_ sub Construct ( byval p as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) )
			*p = x
		end sub
		
	# else
		'' :::::
		linkage_ sub Construct ( byval p as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) )
			var tmp = new(p) fbext_TypeName(T_)(x)
		end sub
	# endif
	end namespace
	:
	# endmacro
	
	''Macro: FBEXT_DECLARE_DESTROY
	''
	# macro fbext_Destroy_Declare(T_)
	:
	namespace ext
		declare sub Destroy overload ( byval p as fbext_TypeName(T_) ptr )
		declare sub Destroy ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr )
	end namespace
	:
	# endmacro
	
	''Macro: FBEXT_DEFINE_DESTROY
	''
	# macro fbext_Destroy_Define(linkage_, T_)
	:
	namespace ext
	# if fbext_TypeID(T_) = string
		'' :::::
		linkage_ sub Destroy ( byval p as fbext_TypeName(T_) ptr )
			*p = ""
		end sub
		
	# elseif FBEXT_IS_SIMPLE(fbext_TypeName(T_))
		'' :::::
		linkage_ sub Destroy ( byval p as fbext_TypeName(T_) ptr )
			' nothing to be done..
		end sub
		
		'' :::::
		linkage_ sub Destroy ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr )
			' nothing to be done..
		end sub
	
	# else
		'' :::::
		linkage_ sub Destroy ( byval p as fbext_TypeName(T_) ptr )
			cast(fbext_TypeName(T_) ptr, p)->destructor()
		end sub
		
		'' :::::
		linkage_ sub Destroy ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr )
		
			do while first <> last
    			cast(fbext_TypeName(T_) ptr, first)->destructor()
				first += 1
			loop
		
		end sub
	# endif
	end namespace
	:
	# endmacro
	
	fbext_InstanciateForBuiltins__(fbext_Construct)

# endif ' include guard
