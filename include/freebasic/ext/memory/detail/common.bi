''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MEMORY_DETAIL_COMMON_BI__
# define FBEXT_MEMORY_DETAIL_COMMON_BI__ -1

# include once "ext/detail/common.bi"

namespace ext

	# define fbext_DestroyProc(T_) fbext_TypeID((DestroyProc) T_)
	# macro fbext_DestroyProc_Declare(T_)
	:
		type fbext_DestroyProc(T_) as sub ( byval p as fbext_TypeName(T_) ptr )
	:
	# endmacro

end namespace

# endif ' include guard
