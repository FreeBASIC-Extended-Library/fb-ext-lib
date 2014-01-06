''Title: algorithms/filln.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_FILLN_BI__
# define FBEXT_ALGORITHMS_FILLN_BI__ -1

# include once "ext/algorithms/detail/common.bi"
'# include once "ext/memory.bi"

	# macro fbext_FillN_Declare(T_)
	:
    namespace ext
		'' Function: FillN
		'' Assigns a value x to a number of elements n in the starting
		'' at first.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range to assign.
		'' n - The number of elements in the range.
		'' x - The value to assign.
		''
		declare sub FillN overload ( byval first as fbext_TypeName(T_) ptr, byval n as ext.SizeType, byref x as const fbext_TypeName(T_) )
    end namespace
	:
	# endmacro

	# macro fbext_FillN_Define(linkage_, T_)
	:
    namespace ext
	# if fbext_TypeName(T_) = byte or fbext_TypeName(T_) = ubyte
		'' :::::
		linkage_ sub FillN ( byval first as fbext_TypeName(T_) ptr, byval n as ext.SizeType, byref x as const fbext_TypeName(T_) )
			ext.memset(first, x, n)
		end sub

	# else
		'' :::::
		linkage_ sub FillN ( byval first as fbext_TypeName(T_) ptr, byval n as ext.SizeType, byref x as const fbext_TypeName(T_) )

			for i as ext.SizeType = n to 1 step -1
				*first = x
				first += 1
			next

		end sub

	# endif
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_FillN)

# endif ' include guard
