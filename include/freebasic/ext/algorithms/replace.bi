''Title: algorithms/replace.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_REPLACE_BI__
# define FBEXT_ALGORITHMS_REPLACE_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_Replace_Declare(T_)
	:
    namespace ext
		'' Function: Replace
		'' Replaces each element in the range [//first//, //last//) that has
		'' a certain value //oldvalue// with another value //newvalue//.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the last element in the range.
		'' oldvalue - The value to be replaced.
		'' newvalue - The value to replace with.
		''
		'' Returns:
		'' Returns //last//.
		''
		declare function Replace overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byref oldvalue as const fbext_TypeName(T_), byref newvalue as const fbext_TypeName(T_) ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
	
	# macro fbext_Replace_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function Replace ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byref oldvalue as const fbext_TypeName(T_), byref newvalue as const fbext_TypeName(T_) ) as fbext_TypeName(T_) ptr
		
			do while first <> last
				if *first = oldvalue then
					*first = newvalue
				end if
				first += 1
			loop
			return first
		
		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_Replace)

# endif ' include guard
