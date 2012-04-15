#include once "pnginc/png_image.bi"
#include once "pnginc/IDAT.bi"
#include once "pnginc/PLTE.bi"
#include once "pnginc/tRNS.bi"
#include once "pnginc/IHDR.bi"
#include once "crt.bi"

namespace ext.gfx.png

'::::::::
' Purpose : Calculate the bytes per pixel of the image, (1 if bits < 8)
' Return  : none
sub png_image_bpp_calc _
	( _
		byref png_image as png_image_t _
	)

	with png_image
		.bpp = iif( .bitdepth < 8, 1, .bitdepth \ 8 )
		if .colortype = 2 then
			.bpp *= 3
		elseif .colortype = 4 then
			.bpp *= 2
		elseif .colortype = 6 then
			.bpp *= 4
		end if
	end with

end sub

'::::::::
' Purpose : Check the 8 byte signature that all PNG files must start with
' Return  : TRUE if the check passed
function png_signature_check _
	( _
		byval p as ubyte ptr _
	) as integer

	dim as integer i = any

	for i = 0 to 7
		if p[i] <> png_sig(i) then
			function = TRUE
		end if
	next i

end function

'::::::::
' Purpose : create a chunk structure containing details of the next chunk
' Return  : A pointer to the structure on success, NULL if failure
function chunk_read _
	( _
		byref png_image as png_image_t _
	) as png_chunk_t ptr

	dim as png_chunk_t ptr chunk = callocate( sizeof( png_chunk_t ) )
	dim as uinteger data_crc     = 0
	dim as ubyte ptr       p     = any

	with png_image
		p = @.buffer[.buffer_pos]
	end with
	
	with *chunk
		if (png_image.buffer_pos + 8) > png_image.buffer_len then
			DEBUGPRINT( "Bad read attempted in chunk" )
			deallocate( chunk )
			return NULL
		end if
		.length = get_u32( p )
		memcpy( @.type, @p[4], 4 )
		.data = @p[8]
		if (png_image.buffer_pos + 12 + .length) > png_image.buffer_len then ' 12 to include crc
			DEBUGPRINT( "Bad read attempted in chunk" )
			deallocate( chunk )
			return NULL
		end if
		.crc32 = get_u32( @p[8 + .length] )
		data_crc = crc32( data_crc, @.type, 4 )
		data_crc = crc32( data_crc, .data, .length )
		png_image.buffer_pos += (12 + .length)
		if data_crc <> .crc32 then
			DEBUGPRINT( "crc check failed" )
			deallocate( chunk )
			chunk = NULL
		end if
	end with

	function = chunk

end function

'::::::::
' Purpose : Make the chunk array of structs containing the info on the chunks in the PNG file
' Return  : 0 on success, non zero otherwise
function chunks_prepare _
	( _
		byref png_image as png_image_t _
	) as integer

	function = 1

	with png_image	
		if .initialized = FALSE then
			DEBUGPRINT( "Not initialized" )
			exit function
		end if

		' Loop through all chunks, making an info structure for each as chunk array
		while .buffer_pos < .buffer_len
			.chunk_count += 1
			dim as any ptr tmp = reallocate( .chunk, .chunk_count * sizeof( png_chunk_t ptr ) )
			if tmp = NULL then
				.chunk_count -= 1
				DEBUGPRINT( "Reallocate failed" )
				exit function
			end if
			.chunk = tmp
			.chunk[.chunk_count - 1] = chunk_read( png_image )
			if .chunk[.chunk_count - 1] = NULL then
				.chunk_count -= 1
				DEBUGPRINT( "Chunk read failed" )
				exit function
			end if
		wend
	
		' Check there's not too few chunks
		if .chunk_count < 3 then ' 3 is because (IHDR, IEND, and IDAT)
			DEBUGPRINT( "Not enough chunks in file" )
			exit function
		end if
		
		' Check if final chunk is IEND (no need to check IHDR here, that gets checked in IHDR_prepare)
		if not IS_CHUNK_TYPE( .chunk[.chunk_count - 1]->type, @"IEND" ) then
			DEBUGPRINT( "Last chunk not IEND" )
			exit function
		end if

	end with

	function = 0

end function

'::::::::
' Purpose : Unpack data, and generally get the information needed to render the image from the chunks
' Return  : none
sub png_image_prepare _
	( _
		byref png_image as png_image_t _
	)

	with png_image

		.buffer_pos = 0
	
		' Check signature
		if png_signature_check( @.buffer[.buffer_pos] ) <> 0 then
			DEBUGPRINT( "First chunk not IHDR" )
			exit sub
		end if
		.buffer_pos += 8
	
		' Identify all other chunks
		if chunks_prepare( png_image ) <> 0 then
			DEBUGPRINT( "Chunk preperation failed" )
			exit sub
		end if

		' Read header (IHDR)
		if IHDR_prepare( png_image ) <> 0 then
			DEBUGPRINT( "IHDR preperation failed" )
			exit sub
		end if

		' Compile and zlib uncompress all the IDAT chunks
		if IDAT_prepare( png_image ) <> 0 then
			DEBUGPRINT( "IDAT preperation failed" )
			exit sub
		end if
	
		' Calculate the bytes per pixel
		png_image_bpp_calc( png_image )
	
		' If there needs to be a palette, prepare it
		if .colortype = 3 then
			if PLTE_prepare( png_image ) <> 0 then
				DEBUGPRINT( "PLTE preperation failed" )
				exit sub
			end if
		end if
	
		' Check for trans chunk, and prepare it if found
		if tRNS_prepare( png_image ) <> 0 then
			DEBUGPRINT( "tRNS preperation failed" )
			exit sub
		end if

		.prepared = TRUE

	end with

end sub

end namespace 'ext.gfx.png
