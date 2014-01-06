''Title: algorithms/findfirstof.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_FINDFIRSTOF_BI__
# define FBEXT_ALGORITHMS_FINDFIRSTOF_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_FindFirstOf_Declare(T_)
	:
    namespace ext
		'' Function: FindFirstOf
		'' Finds the first occurance of an element in the range
		'' [//first1//, //last1//) equal to any one of the elements in the
		'' range [//first2//, //last2//).
		''
		'' Parameters:
		'' first1 - A pointer to the first element in the range to search.
		'' last1 - A pointer to one-past the last element in the range to search.
		'' first2 - A pointer to the first elements in the range to search for.
		'' last2 - A pointer to one-past the last element in the range to search for.
		''
		'' Returns:
		'' Returns a pointer to the element, or //last1// if no such element
		'' is found.
		''
		declare function FindFirstOf overload ( byval first1 as fbext_TypeName(T_) ptr, byval last1 as fbext_TypeName(T_) ptr, byval first2 as fbext_TypeName(T_) ptr, byval last2 as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
		'' Function: FindFirstOf
		'' Finds the first occurance of an element in the range
		'' [//first1//, //last1//) that satisfies a predicate //pred// with
		'' any one of the elements in the range [//first2//, //last2//).
		''
		'' Parameters:
		'' first1 - A pointer to the first element in the range to search.
		'' last1 - A pointer to one-past the last element in the range to search.
		'' first2 - A pointer to the first elements in the range to search for.
		'' last2 - A pointer to one-past the last element in the range to search for.
		'' pred - The predicate to test elements with.
		''
		'' Returns:
		'' Returns a pointer to the element, or //last1// if no such element
		'' is found.
		''
		declare function FindFirstOf overload ( byval first1 as fbext_TypeName(T_) ptr, byval last1 as fbext_TypeName(T_) ptr, byval first2 as fbext_TypeName(T_) ptr, byval last2 as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
	
	# macro fbext_FindFirstOf_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function FindFirstOf ( byval first1 as fbext_TypeName(T_) ptr, byval last1 as fbext_TypeName(T_) ptr, byval first2 as fbext_TypeName(T_) ptr, byval last2 as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
			do while first1 <> last1
				do while first2 <> last2
					if *first1 = *first2 then
						return first1
					end if
				loop
			loop
			return last1
		
		end function
		
		'' :::::
		linkage_ function FindFirstOf ( byval first1 as fbext_TypeName(T_) ptr, byval last1 as fbext_TypeName(T_) ptr, byval first2 as fbext_TypeName(T_) ptr, byval last2 as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool ) as fbext_TypeName(T_) ptr
		
			do while first1 <> last1
				do while first2 <> last2
					if pred(*first1, *first2) then
						return first1
					end if
				loop
			loop
			return last1
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_FindFirstOf)

# endif ' include guard
