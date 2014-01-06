''Title: algorithms/uninitializedcopy.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_UNINITIALIZEDCOPY_BI__
# define FBEXT_ALGORITHMS_UNINITIALIZEDCOPY_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	
	# macro fbext_UninitializedCopy_Declare(T_)
	:
    namespace ext
		'' Function: UninitializedCopy
		'' Copies elements in the range [//first//, //last//) to uninitialized
		'' memory beginning at //result//.
		''
		'' Parameters:
		'' first - A pointer to the first element to be copied.
		'' last - A pointer to one-past the last element to be copied.
		'' result - A pointer to uninitialized memory that will recieve the
		'' copies.
		''
		'' Returns:
		'' Returns a pointer to one-past the last element copied.
		''
		declare function UninitializedCopy overload ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
	
	# macro fbext_UninitializedCopy_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function UninitializedCopy ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
			do while first <> last
			# if fbext_TypeID(T_) = string
			    clear *result, 0, sizeof(string)
			    *result = *first
			' FB BUG [2212554] workaround.
			# elseif FBEXT_IS_FLOATINGPOINT(fbext_TypeName(T_))
				*result = *first
			# else
				var tmp = new(result) fbext_TypeName(T_)(*first)
			# endif
				first += 1
				result += 1
			loop
			return result
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_UninitializedCopy)


# endif ' include guard
