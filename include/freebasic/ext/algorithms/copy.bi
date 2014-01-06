''Title: algorithms/copy.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_COPY_BI__
# define FBEXT_ALGORITHMS_COPY_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_Copy_Declare(T_)
	:
    namespace ext
		'' Function: Copy
		'' Copies elements in the range [first, last) to the range
		'' beginning at result.
		''
		'' Parameters:
		'' first - A pointer to the first element to be copied.
		'' last - A pointer to one-past the last element to be copied.
		'' result - A pointer to the beginning of the range that will recieve
		'' the copies.
		''
		'' Returns:
		'' Returns a pointer to one-past the last element copied.
		''
		declare function Copy overload ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
    
	# macro fbext_Copy_Define(linkage_, T_)
	:
    namespace ext
	# if FBEXT_IS_SIMPLE(fbext_TypeName(T_))
		'' :::::
		linkage_ function Copy ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr

			ext.memmove(result, cast(any ptr, first), sizeof(fbext_TypeName(T_)) * (last - first))
			return result + (last - first)

		end function

	# else
		'' :::::
		linkage_ function Copy ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr

			do while first <> last
				*result = *first
				result += 1 : first += 1
			loop
			return result

		end function

	# endif
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_Copy)

# endif ' include guard
