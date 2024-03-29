''Title: algorithms/fill.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# ifndef FBEXT_ALGORITHMS_FILL_BI__
# define FBEXT_ALGORITHMS_FILL_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_Fill_Declare(T_)
	:
    namespace ext
		'' Function: Fill
		'' Assigns a value x to the elements in the range
		'' [first, last).
		''
		'' Parameters:
		'' first - A pointer to the first element in the range to assign.
		'' last - A pointer to one-past the last element in the range to
		'' assign.
		'' x - The value to assign.
		''
		declare sub Fill overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) )
    end namespace
	:
	# endmacro
	
	# macro fbext_Fill_Define(linkage_, T_)
	:
    namespace ext
	# if FBEXT_IS_BYTE_OR_UBYTE(fbext_TypeName(T_))
		'' :::::
		linkage_ sub Fill ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) )
			memset(first, x, last - first)
		end sub
	# else
		'' :::::
		linkage_ sub Fill ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) )
		
			do while first <> last
				*first = x
				first += 1
			loop
		
		end sub
	# endif
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_Fill)

# endif ' include guard
