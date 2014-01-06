''Title: algorithms/foreach.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_FOREACH_BI__
# define FBEXT_ALGORITHMS_FOREACH_BI__ -1

# include once "ext/algorithms/detail/common.bi"

	# macro fbext_ForEach_Declare(T_)
	:
    namespace ext
		'' Function: ForEach
		'' Applies an operation //op// for every element in the range
		'' [//first//, //last//).
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer one-past the last element in the range.
		'' op - The operation to perform.
		''
		declare sub ForEach overload ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval op_ as sub ( byref as fbext_TypeName(T_) ) )
    end namespace
	:
	# endmacro
	
	# macro fbext_ForEach_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ sub ForEach ( byval first as fbext_TypeName(T_) ptr, byval last as fbext_TypeName(T_) ptr, byval op_ as sub ( byref as fbext_TypeName(T_) ) )
		
			do while first <> last
				op_(*first)
				first += 1
			loop
		
		end sub
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_ForEach)

# endif ' include guard
