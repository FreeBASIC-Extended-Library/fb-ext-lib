''Title: algorithms/countif.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_COUNTIF_BI__
# define FBEXT_ALGORITHMS_COUNTIF_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_CountIf_Declare(T_)
	:
    namespace ext
		fbext_TDeclare(fbext_Predicate, (T_))
		'' Function: CountIf
		'' Finds the number of elements in the range [first, last)
		'' that satisfy a predicate pred.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range to search.
		'' last - A pointer to one-past the last element in the range to
		'' search.
		'' pred - A predicate to test the elements with.
		''
		'' Returns:
		'' Returns the number of found elements, or zero (0) if no such
		'' elements are found.
		''
		declare function CountIf overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as fbext_Predicate(T_) ) as ext.SizeType
    end namespace
	:
	# endmacro
	
	# macro fbext_CountIf_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function CountIf ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as fbext_Predicate(T_) ) as ext.SizeType
		
			var c = cast(SizeType, 0)
			do while first <> last
				if pred(*first) then c += 1
				first += 1
			loop
			return c
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_CountIf)

# endif ' include guard
