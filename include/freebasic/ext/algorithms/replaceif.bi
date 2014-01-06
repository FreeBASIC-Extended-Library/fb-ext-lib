''Title: algorithms/replaceif.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_REPLACEIF_BI__
# define FBEXT_ALGORITHMS_REPLACEIF_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_ReplaceIf_Declare(T_)
	:
	namespace ext
		'' Function: ReplaceIf
		'' Replaces each element in the range [//first//, //last//) that
		'' satsifies a predicate //pred// with another value //newvalue//.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the last element in the range.
		'' pred - The predicate to test the elements.
		'' newvalue - The value to replace with.
		''
		'' Returns:
		'' Returns //last//.
		''
		declare function ReplaceIf overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_) ) as bool, byref newvalue as const fbext_TypeName(T_) ) as fbext_TypeName(T_) ptr
	end namespace
	:
	# endmacro
	
	# macro fbext_ReplaceIf_Define(linkage_, T_)
	:
	namespace ext
		'' :::::
		linkage_ function ReplaceIf ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval pred as function ( byref as const fbext_TypeName(T_) ) as bool, byref newvalue as const fbext_TypeName(T_) ) as fbext_TypeName(T_) ptr
		
			do while first <> last
				if pred(*first) then
					*first = newvalue
				end if
				first += 1
			loop
			return first
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_ReplaceIf)

# endif ' include guard
