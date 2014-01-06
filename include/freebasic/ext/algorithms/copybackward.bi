''Title: algorithms/copybackward.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_COPYBACKWARD_BI__
# define FBEXT_ALGORITHMS_COPYBACKWARD_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_CopyBackward_Declare(T_)
	:
    namespace ext
		'' Function: CopyBackward
		'' Copies elements in the range [//first, last//) to the range
		'' beginning at //result// backwards.
		''
		'' Parameters:
		'' first - A pointer to the first element to be copied.
		'' last - A pointer to one-past the last element to be copied.
		'' result - A pointer to one-past the end of the range that will
		'' recieve the copies.
		''
		'' Returns:
		'' Returns a pointer to the first element copied.
		''
		declare function CopyBackward overload ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro

	# macro fbext_CopyBackward_Define(linkage_, T_)
	:
    namespace ext
	# if FBEXT_IS_SIMPLE(fbext_TypeName(T_))
		'' :::::
		linkage_ function CopyBackward ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr

			dim as SizeType n = last - first
			ext.memmove(result - n, cast(any ptr, first), sizeof(fbext_TypeName(T_)) * n)
			return result - n

		end function

	# else
		'' :::::
		linkage_ function CopyBackward ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr

			for n as SizeType = last - first to 1 step -1
				last -= 1 : result -= 1
				*result = *last
			next
			return result

		end function

	# endif
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_CopyBackward)

# endif ' include guard
