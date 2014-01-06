''Title: algorithms/find.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_FIND_BI__
# define FBEXT_ALGORITHMS_FIND_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_Find_Declare(T_)
	:
    namespace ext
		'' Function: Find
		'' Finds the first element in the range [first, last) that
		'' matches a value x.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the last element in the range.
		'' x - The value to find.
		''
		'' Returns:
		'' Returns a pointer to the element, or //last// if no such element is
		'' found.
		''
		declare function Find overload ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) ) as const fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro

	# macro fbext_Find_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function Find ( byval first as const fbext_TypeName(T_) ptr, byval last as const fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) ) as const fbext_TypeName(T_) ptr

			var first_ = cast( fbext_TypeName(T_) ptr, first )

			do while first_ <> last and *first_ <> x
				cast( fbext_TypeName(T_) ptr, first_ ) += 1
			loop
			return cast( const fbext_TypeName(T_) ptr, first_)

		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_Find)

# endif ' include guard
