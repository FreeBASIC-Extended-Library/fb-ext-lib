'' Title: memory/arrays.bi
'' 
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
'' 
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# include once "ext/algorithms/detail/common.bi"

''namespace: ext

    # macro fbext_copyArray_Declare(T_)
	:
	namespace ext
	''sub: copyArray
	''Copies an Array of simple types rapidly.
	''
	''Parameters:
	''src() - array to copy.
	''dest() - array to hold copy of src, dest() will be overwritten.
	''amount_ - number of elements to copy from element 0.
	''
		declare sub copyArray overload ( src() as fbext_TypeName(T_) , _
										dest() as fbext_TypeName(T_) , _
										byval amount_ as uinteger )
	end namespace
	:
	# endmacro

	# macro fbext_copyArray_Define(linkage_, T_)
	:
	namespace ext
		linkage_ sub copyArray overload ( src() as fbext_TypeName(T_) , _
										dest() as fbext_TypeName(T_) , _
										byval amount_ as uinteger )

		redim dest( amount_ )
		ext.memcpy( @dest(0), @src(0), sizeOf( fbext_TypeName(T_) ) * amount_ )

		end sub
	end namespace
	:
	# endmacro

    # macro fbext_sliceArray_Declare(T_)
	:
	namespace ext
		''sub: sliceArray
		''Copies a portion of an Array into a new array.
		''
		''Parameters:
		''src() - the array to slice.
		''dest() - the array to hold the sliced information, will be overwritten.
		''start_ - the element in src() to start the slice.
		''end_ - the element in src() to stop the slice.
		''
		declare sub sliceArray overload ( src() as fbext_TypeName(T_) , _
										dest() as fbext_TypeName(T_) , _
										byval start_ as uinteger, _
										byval end_ as uinteger )
	end namespace
	:
	# endmacro

	# macro fbext_sliceArray_Define(linkage_, T_)
	:
	namespace ext
		linkage_ sub sliceArray overload ( src() as fbext_TypeName(T_) , _
										dest() as fbext_TypeName(T_) , _
										byval start_ as uinteger, _
										byval end_ as uinteger )

		redim dest( end_ - (start_ + 1) )
		ext.memcpy( @dest(0), @src(start_), sizeOf( fbext_TypeName(T_) ) * ( end_ - (start_ + 1) ) )

		end sub
	end namespace
	:
	# endmacro

	fbext_InstanciateForBuiltins__(fbext_copyArray)
	fbext_InstanciateForBuiltins__(fbext_sliceArray)
