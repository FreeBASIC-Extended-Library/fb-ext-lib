''Title: algorithms/adjacentfind.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_ADJACENTFIND_BI__
# define FBEXT_ALGORITHMS_ADJACENTFIND_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_AdjacentFind_Declare(T_)
	:
    namespace ext
		'' Function: AdjacentFind
		''  Finds the first of two consecutive elements in the range
		''  [*first*, *last*) that compare equal to each other using
		''  operator =.
		''
		'' Parameters:
		''  first - A pointer to the first element in the range to search.
		''  last - A pointer one-past the element in the range to search.
		''
		'' Returns:
		''  Returns a pointer to the element found, or *last* if there is no
		''  such element.
		declare function AdjacentFind overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
		'' Function: AdjacentFind
		''  Finds the first of two consecutive elements in the range
		''  [*first*, *last*) that satisfy the predicate *pred*.
		''
		'' Parameters:
		''  first - A pointer to the first element in the range to search.
		''  last - A pointer one-past the element in the range to search.
		''  pred - The BinaryPredicate function to call.
		''
		'' Returns:
		''  Returns a pointer to the element found, or *last* if there is no
		''  such element.
		declare function AdjacentFind ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as ext.bool ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
	
	# macro fbext_AdjacentFind_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function AdjacentFind ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
			if first = last then return last
			var nxt = first + 1
			do while nxt <> last
				if *first = *nxt then return first
				first = nxt
				nxt += 1
			loop
			return last
		
		end function
		
		'' :::::
		linkage_ function AdjacentFind ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as ext.bool ) as fbext_TypeName(T_) ptr
		
			if first = last then return last
			var nxt = first + 1
			do while nxt <> last
				if pred(*first, *nxt) then return first
				first = nxt
				nxt += 1
			loop
			return last
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_AdjacentFind)

# endif ' include guard
