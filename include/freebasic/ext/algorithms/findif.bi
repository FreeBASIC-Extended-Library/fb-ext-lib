''Title: algorithms/findif.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_FINDIF_BI__
# define FBEXT_ALGORITHMS_FINDIF_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_FindIf_Declare(T_)
	:
    namespace ext
		'' Function: FindIf
		'' Finds the first element in the range [//first//, //last//) that
		'' satisfies a predicate //pred//.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the last element in the range.
		'' pred - The predicate to test elements.
		''
		'' Returns:
		'' Returns a pointer to the element, or *last* if no such element is
		'' found.
		''
		declare function FindIf overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_) ) as bool ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
	
	# macro fbext_FindIf_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function FindIf ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_) ) as bool ) as fbext_TypeName(T_) ptr
		
			do while first <> last and not pred(*first)
				first += 1
			loop
			return first
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_FindIf)

# endif ' include guard
