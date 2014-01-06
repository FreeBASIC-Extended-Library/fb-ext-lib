''Title: algorithms/transform.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_ALGORITHMS_TRANSFORM_BI__
# define FBEXT_ALGORITHMS_TRANSFORM_BI__ -1

# include once "ext/algorithms/detail/common.bi"


	# macro fbext_Transform_Declare(T_)
	:
    namespace ext
		'' Function: Transform
		'' Applies an operation //op// on each element in the range
		'' [//first//, //last//), storing the results of the transformation
		'' in the range starting at //result//.
		''
		'' Parameters:
		'' first - A pointer to the first element in the range.
		'' last - A pointer to one-past the last element in the range.
		'' result - A pointer to the first element in the range to recieve
		'' the result of the transformation.
		'' op - The operation used to transform the elements.
		''
		'' Returns:
		'' Returns a pointer to one-past the last element copied.
		''
		declare function Transform overload ( byval first as  fbext_TypeName(T_) ptr, byval last as  fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr, byval op as function ( byref as fbext_TypeName(T_) ) as fbext_TypeName(T_) ) as fbext_TypeName(T_) ptr

		'' Function: Transform
		'' Applies an operation //op// on each of the corresponding elements
		'' in the ranges [//first//, //last//) and
		'' [//first2//, //first2// + //last//-//first//), storing the results
		'' of the transformation in the range starting at //result//.
		''
		'' Parameters:
		'' first - A pointer to the first element in the first range.
		'' last - A pointer to one-past the last element in the first range.
		'' first2 - A pointer to the first element in the second range.
		'' result - A pointer to the first element in the range to recieve
		'' the result of the transformation.
		'' op - The operation used to transform the elements.
		''
		'' Returns:
		'' Returns a pointer to one-past the last element copied.
		''
		declare function Transform overload ( byval first as  fbext_TypeName(T_) ptr, byval last as  fbext_TypeName(T_) ptr, byval first2 as  fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr, byval op as function ( byref as fbext_TypeName(T_), byref as fbext_TypeName(T_) ) as fbext_TypeName(T_) ) as fbext_TypeName(T_) ptr
    end namespace
	:
	# endmacro
    
	# macro fbext_Transform_Define(linkage_, T_)
	:
    namespace ext
		'' :::::
		linkage_ function Transform ( byval first as  fbext_TypeName(T_) ptr, byval last as  fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr, byval op as function ( byref as fbext_TypeName(T_) ) as fbext_TypeName(T_) ) as fbext_TypeName(T_) ptr

			do while first <> last
				*result = op(*cast( fbext_TypeName(T_) ptr, first))
				result += 1 : first += 1
			loop
			return result

		end function

		'' :::::
		linkage_ function Transform ( byval first as  fbext_TypeName(T_) ptr, byval last as  fbext_TypeName(T_) ptr, byval first2 as  fbext_TypeName(T_) ptr, byval result as fbext_TypeName(T_) ptr, byval op as function ( byref as fbext_TypeName(T_), byref as fbext_TypeName(T_) ) as fbext_TypeName(T_) ) as fbext_TypeName(T_) ptr

			do while first <> last
				*result = op(*cast( fbext_TypeName(T_) ptr, first), *cast( fbext_TypeName(T_) ptr, first2))
				result += 1 : first += 1 : first2 += 1
			loop
			return result

		end function
    end namespace
	:
	# endmacro

    fbext_InstanciateForBuiltins__(fbext_Transform)

# endif ' include guard
