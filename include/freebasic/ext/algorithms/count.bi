''Title: algorithms/count.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# ifndef FBEXT_ALGORITHMS_COUNT_BI__
# define FBEXT_ALGORITHMS_COUNT_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_Count_Declare(T_)
	:
    namespace ext
		'' Function: Count
		'' Finds the number of elements in the range [first, last)
		'' that are equal to a value x.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range to search.
		'' last - A pointer to one-past the last element in the range to
		'' search.
		'' x - The value to search for.
		''
		'' Returns:
		'' Returns the number of found elements, or zero (0) if no such
		'' elements are found.
		''
		declare function Count overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) ) as ext.SizeType
    end namespace
	:
	# endmacro
	
	# macro fbext_Count_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function Count ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byref x as const fbext_TypeName(T_) ) as ext.SizeType
		
			var c = cast(SizeType, 0)
			do while first <> last
				if *first = x then c += 1
				first += 1
			loop
			return c
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_Count)

# endif ' include guard
