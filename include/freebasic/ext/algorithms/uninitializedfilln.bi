''Title: algorithms/uninitializedfilln.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_UNINITIALIZEDFILLN_BI__
# define FBEXT_ALGORITHMS_UNINITIALIZEDFILLN_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_UninitializedFillN_Declare(T_)
	:
	namespace ext
		'' Function: UninitializedFillN
		'' Copies a value //x// to a number of uninitialized elements //n//
		'' in the range starting at //first//.
		'' 
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' n - The number of elements in the range.
		'' x - The value to fill.
		''
		declare sub UninitializedFillN overload ( byval first as fbext_TypeName(T_) ptr, byval n as SizeType, byref x as const fbext_TypeName(T_) )
	end namespace
	:
	# endmacro
	
	# macro fbext_UninitializedFillN_Define(linkage_, T_)
	:
	namespace ext
		'' :::::
		linkage_ sub UninitializedFillN ( byval first as fbext_TypeName(T_) ptr, byval n as SizeType, byref x as const fbext_TypeName(T_) )
		
			for i as SizeType = n to 1 step -1
			# if fbext_TypeName(T_) = string
			    clear *first, 0, sizeof(string)
			    *first = x
			# else
				var tmp = new(first) fbext_TypeName(T_)(x)
			# endif
				first += 1
			next
		
		end sub
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_UninitializedFillN)


# endif ' include guard
