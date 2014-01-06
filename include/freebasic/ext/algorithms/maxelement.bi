''Title: algorithms/maxelement.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_MAXELEMENT_BI__
# define FBEXT_ALGORITHMS_MAXELEMENT_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_MaxElement_Declare(T_)
	:
    namespace ext
		'' Function: MaxElement
		'' Finds the first element in the range [//first//, //last//) with
		'' the maximum value.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the last element in the range.
		''
		'' Returns:
		'' Returns a pointer to the element or //last// if the range is empty.
		''
		declare function MaxElement overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
		'' Function: MaxElement
		'' Finds the first element in the range [//first//, //last//) with
		'' the maximum value determined by a predicate //pred//.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the last element in the range.
		''
		'' Returns:
		'' Returns a pointer to the element or //last// if the range is empty.
		''
		declare function MaxElement overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
	
	# macro fbext_MaxElement_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function MaxElement ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr ) as fbext_TypeName(T_) ptr
		
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
		linkage_ function MaxElement ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_), byref as const fbext_TypeName(T_) ) as bool ) as fbext_TypeName(T_) ptr
		
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

    fbext_InstanciateForBuiltins__(fbext_MaxElement)

# endif ' include guard
