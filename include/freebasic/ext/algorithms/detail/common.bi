''Title: algorithms/detail/common.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# ifndef FBEXT_ALGORITHMS_DETAIL_COMMON_BI__
# define FBEXT_ALGORITHMS_DETAIL_COMMON_BI__ -1

# include once "ext/memory/detail/common.bi"

'' Namespace: ext
namespace ext

extern "C"
    
    declare sub qsort ( byval p as any ptr, byval n as integer, byval elemsize as integer, byval comp as function ( byval as const any ptr, byval as const any ptr ) as integer )
	#ifdef __FB_DOS__
	declare function memcpy ( byval dst as any ptr, byval src as const any ptr, byval size as ulong ) as any ptr
    declare function memcmp ( byval s1 as const any ptr, byval s2 as const any ptr, byval size as ulong ) as long
    declare function memmove ( byval dst as any ptr, byval src as const any ptr, byval size as ulong ) as any ptr
		declare function memset ( byval dst as any ptr, byval value as long, byval size as ulong ) as any ptr
	#else
		declare function memcpy ( byval dst as any ptr, byval src as const any ptr, byval size as uinteger ) as any ptr
		declare function memcmp ( byval s1 as const any ptr, byval s2 as const any ptr, byval size as uinteger ) as long
		declare function memmove ( byval dst as any ptr, byval src as const any ptr, byval size as uinteger ) as any ptr
    	declare function memset ( byval dst as any ptr, byval value as long, byval size as uinteger ) as any ptr
	#endif 
    declare function strncpy (byval dst as zstring ptr, byval src as const zstring ptr, byval n as uinteger) as zstring ptr
end extern

	# define fbext_Predicate(T_) fbext_TypeID((Predicate) T_)
	# macro fbext_Predicate_Declare(T_)
	:
		'' Type: Predicate
		type fbext_TypeID((Predicate) T_) as function ( byref x as fbext_TypeName(T_) ) as ext.bool
	:
	# endmacro

	# define fbext_BinaryPredicate(T_) fbext_TypeID((BinaryPredicate) T_)
	# macro fbext_BinaryPredicate_Declare(T_)
	:
		'' Type: BinaryPredicate
		type fbext_TypeID((BinaryPredicate) T_) as function ( byref a as fbext_TypeName(T_), byref b as fbext_TypeName(T_) ) as ext.bool
	:
	# endmacro

	# define fbext_Operation(T_) fbext_TypeID((Operation) T_)
	# macro fbext_Operation_Declare(T_)
	:
		'' Type: Operation
		type fbext_TypeID((Operation) T_) as sub ( byref x as fbext_TypeName(T_) )
	:
	# endmacro

	# define fbext_Tranformation(T_) fbext_TypeID((Tranformation) T_)
	# macro fbext_Transformation_Declare(T_)
	:
		'' Type: Transformation
		type fbext_TypeID((Transformation) T_) as function ( byref x as fbext_TypeName(T_) ) as fbext_TypeName(T_)
	:
	# endmacro

	# define fbext_BinaryTranformation(T_) fbext_TypeID((BinaryTranformation) T_)
	# macro fbext_BinaryTransformation_Declare(T_)
	:
		'' Type: BinaryTransformation
		type fbext_TypeID((BinaryTransformation) T_) as function ( byref a as fbext_TypeName(T_), byref b as fbext_TypeName(T_) ) as fbext_TypeName(T_)
	:
	# endmacro

end namespace

# endif ' include guard
