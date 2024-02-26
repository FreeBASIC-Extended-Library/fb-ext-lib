'' Title: memory/arrays.bi
''
'' About: License
''  Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# include once "ext/algorithms/detail/common.bi"

''namespace: ext

	# macro fbext_pushArray_Declare(T_)
	:
	namespace ext
		''Sub: pushArray
		''Pushes a value onto an array.
		''Automatically performs the proper redim.
		''
		''Parameters:
		''v - the value to put into the array at the end
		''dest() - the array to add v to.
		declare sub pushArray overload ( byref v as fbext_TypeName(T_), _
										    dest() as fbext_TypeName(T_) )
	end namespace
	:
	# endmacro

	# macro fbext_pushArray_Define(linkage_,T_)
	:
	namespace ext
		sub pushArray overload ( byref x as fbext_TypeName(T_), _
										    arr() as fbext_TypeName(T_) )
			if @arr(lbound(arr)) <> 0 then
				redim preserve arr(ubound(arr)+1)
			else
				redim arr(0)
			end if
			arr(ubound(arr)) = x
		end sub
	end namespace
	:
	# endmacro

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
		redim dest( end_ - (start_) )
		ext.memcpy( @dest(0), @src(start_), sizeOf( fbext_TypeName(T_) ) * ( (end_ - start_) + 1 ) )

		end sub
	end namespace
	:
	# endmacro

	# macro fbext_remove_i_from_array_Declare(T_)
	:
	namespace ext
		''Sub: remove_i_from_array
		''Removes one item from an array.
		''
		''Parameters:
		''index - 0 based index in the array to remove
		''arr() - the array to remvoe index from
		declare sub remove_i_from_array overload ( byval index as uinteger, arr() as fbext_TypeName(T_) )
	end namespace
	:
	# endmacro

	# macro fbext_remove_i_from_array_Define(linkage_,T_)
	:
	namespace ext
	linkage_ sub remove_i_from_array( byval index as uinteger, arr() as fbext_TypeName(T_) )
	    var ip1 = index + 1
	    if ip1 > ubound(arr) then
	        redim preserve arr(ubound(arr)-1)
	        return
	    end if
	    dim temp_arr(0 to ubound(arr)-ip1) as fbext_TypeName(T_)
	    var i = 0
	    for n as integer = ip1 to ubound(arr)
	        temp_arr(i) = arr(n)
	        i += 1
	    next
	    redim preserve arr(ubound(arr)-1)
	    i = 0
	    for n as integer = index to ubound(arr)
	        arr(n) = temp_arr(i)
	        i += 1
	    next
	end sub
	end namespace
	:
	# endmacro

	fbext_InstanciateForBuiltins__(fbext_pushArray)
	fbext_InstanciateForBuiltins__(fbext_copyArray)
	fbext_InstanciateForBuiltins__(fbext_sliceArray)
	fbext_InstanciateForBuiltins__(fbext_remove_i_from_array)
