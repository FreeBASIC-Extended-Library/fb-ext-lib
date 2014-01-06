''Title: algorithms/minelement.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_MINELEMENT_BI__
# define FBEXT_ALGORITHMS_MINELEMENT_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_MinElement_Declare(T_)
	:
    namespace ext
		'' Function: MinElement
		'' Returns a pointer to the element in a range with the minimum value.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the element in the range.
		''
		'' Returns:
		'' Returns a pointer to the element in the range with the minimum
		'' value, or *last* if the range is empty.
		''
		declare function MinElement overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
		'' Function: MinElement
		'' Returns a pointer to the element in a range using a predicate.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the element in the range.
		'' pred - A function to compare elements with.
		''
		'' Returns:
		'' Returns a pointer to the element in the range which satisfies the
		'' predicate against all other elements, or *last* if the range is
		'' empty.
		''
		declare function MinElement overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
	
	# macro fbext_MinElement_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function MinElement ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
			if first = last then return first
			
			var result = first
			first += 1
			do while first <> last
				if *result < *first then
					result = first
				end if
				first += 1
			loop
			return result
		
		end function
		
		'' :::::
		linkage_ function MinElement ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool ) as fbext_TypeName(T_) ptr
		
			if first = last then return first
			
			var result = first
			first += 1
			do while first <> last
				if pred(*result, *first) then
					result = first
				end if
				first += 1
			loop
			return result
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_MinElement)

# endif ' include guard
