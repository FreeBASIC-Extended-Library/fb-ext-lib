''Title: algorithms/equal.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_EQUAL_BI__
# define FBEXT_ALGORITHMS_EQUAL_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_Equal_Declare(T_)
	:
    namespace ext
		'' Function: Equal
		'' Tests two ranges of elements [first, last) and beginning at
		'' first2 for equivalence.
		''
		'' Parameters:
		'' first1 - A pointer to the first element in the first range.
		'' last - A pointer to one-past the end of the last element in the
		'' first range.
		'' first2 - A pointer to the first element in the second range.
		''
		'' Returns:
		'' Returns true if all elements in each range compare equal, false
		'' otherwise.
		''
		declare function Equal overload ( byval first1 as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval first2 as fbext_TypeName(T_) ptr ) as bool
		
		'' Function: Equal
		'' Tests two ranges of elements [first, last) and beginning at
		'' first2 for equivalence using a predicate pred.
		''
		'' Parameters:
		'' first1 - A pointer to the first element in the first range.
		'' last - A pointer to one-past the end of the last element in the
		'' first range.
		'' first2 - A pointer to the first element in the second range.
		'' pred - A binary predicate to compare elements.
		''
		'' Returns:
		'' Returns true if all corresponding elements in each range
		'' satisfy the predicate, false otherwise.
		''
		declare function Equal ( byval first1 as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval first2 as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool ) as bool
    end namespace
	:
	# endmacro
	
	# macro fbext_Equal_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function Equal ( byval first1 as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval first2 as fbext_TypeName(T_) ptr ) as bool
		
			for i as integer = 1 to last - first1
				if not *first1 = *first2 then return false
			next
			return true
		
		end function
		
		'' :::::
		linkage_ function Equal ( byval first1 as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval first2 as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool ) as bool
		
			for i as integer = 1 to last - first1
				if not pred(*first1, *first2) then return false
			next
			return true
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_Equal)

# endif ' include guard
