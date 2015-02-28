#include once "pnginc/png_image.bi"
#include once "crt.bi"

namespace ext.gfx.png
'::::::::
' Purpose : Calculate the total size the uncompressed IDAT should take
' Return  : size
function IDAT_calc _
	( _
		byref png_image as png_image_t _
	) as integer

	dim as integer size = 0
	dim as integer pass = any
	dim as integer h    = any

	with png_image

		if .interlacemethod = 0 then
			size = calc_scan_size( png_image, 1 ) * .height
		else
			for pass = 1 to 7
				if .width > tb_xoff(pass) then
					h = .height + tb_hfac(pass) - tb_yoff(pass) - 1
					h \= tb_hfac(pass)
					size += (h * calc_scan_size( png_image, pass ))
				end if
			next pass
		end if

	end with

	function = size

end function

'::::::::
' Purpose : Compile all IDAT chunks into one buffer
' Return  : 0 on success
function IDAT_compile _
	( _
		byref png_image as png_image_t _
	) as integer

	dim as ubyte ptr p = any
	dim as integer   i = any

	function = 1

	with png_image

		.IDAT = NULL
		.IDAT_len = 0

		i = chunk_find( png_image, "IDAT", 0 )
		while i <> -1
			.IDAT_len += .chunk[i]->length
			i = chunk_find( png_image, "IDAT", i + 1 )
		wend

		if .IDAT_len > 0 then
			.IDAT = callocate( .IDAT_len )
			if .IDAT <> NULL then
				p = .IDAT
				i = chunk_find( png_image, "IDAT", 0 )
				while i <> -1
					with *.chunk[i]
						memcpy( p, .data, .length )
						p += .length
					end with
					i = chunk_find( png_image, "IDAT", i + 1 )
				wend
				function = 0
			end if
		end if

	end with

end function

'::::::::
' Purpose : Uncompress the IDAT using zlib
' Return  : 0 on success
function IDAT_uncompress _
	( _
		byref png_image   as png_image_t _
	) as integer

	dim as integer predict_len = IDAT_calc( png_image )
	dim as ulong dest_len    = (predict_len * 1.2) + 12
	dim as any ptr dest        = callocate( dest_len )

	function = 1

	with png_image

		if dest <> NULL then
			if uncompress( dest, @dest_len, .IDAT, .IDAT_len ) = 0 then
				if dest_len = predict_len then
					function = 0
				end if
			end if
		end if

		deallocate( .IDAT )

		.IDAT = dest
		.IDAT_len = dest_len

	end with

end function

'::::::::
' Purpose : Compile IDAT chunks, and uncompress so that IDAT points to the raw
'           image data
' Return  : 0 on success
function IDAT_prepare _
	( _
		byref png_image as png_image_t _
	) as integer

	function = 1

	if IDAT_compile( png_image ) = 0 then
		if IDAT_uncompress( png_image ) = 0 then
			function = 0
		end if
	end if

end function

end namespace 'ext.gfx.png
