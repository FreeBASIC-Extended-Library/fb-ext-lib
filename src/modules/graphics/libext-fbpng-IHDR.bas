#include once "pnginc/png_image.bi"

namespace ext.gfx.png
'::::::::
' Purpose :  Validate the IHDR details
' Return  : TRUE if valid, FALSE if not
function IHDR_is_valid _
	( _
		byref png_image as png_image_t _
	) as integer

	dim as bool_e valid = TRUE

	with png_image

		if (.width = 0) or (.height = 0) then
			valid = FALSE
		end if

		select case .colortype
			case 0
				select case .bitdepth
					case 1, 2, 4, 8, 16
					case else
						valid = FALSE
				end select
			case 3
				select case .bitdepth
					case 1, 2, 4, 8
					case else
						valid = FALSE
				end select
			case 2, 4, 6
				select case .bitdepth
					case 8, 16
					case else
						valid = FALSE
				end select
			case else
				valid = FALSE
		end select

		if .compressionmethod <> 0 then
			valid = FALSE
		end if

		if .filtermethod <> 0 then
			valid = FALSE
		end if

		if (.interlacemethod <> 0) and (.interlacemethod <> 1) then
			valid = FALSE
		end if

	end with

	function = valid

end function

'::::::::
' Purpose : Unpack the IHDR chunk, and validate it
' Return  : 0 on success
function IHDR_prepare _
	( _
		byref png_image as png_image_t _
	) as integer

	dim as integer   IHDR_chunk = chunk_find( png_image, "IHDR", 0 )
	dim as ubyte ptr p          = any

	function = 1
	
	with png_image
	
		if IHDR_chunk = 0 then
			if .chunk[0]->length = 13 then
				p = .chunk[0]->data
				.width             = get_u32( @p[0] )
				.height            = get_u32( @p[4] )
				.bitdepth          = p[8]
				.colortype         = p[9]
				.compressionmethod = p[10]
				.filtermethod      = p[11]
				.interlacemethod   = p[12]
				if IHDR_is_valid( png_image ) = TRUE then
					function = 0
				end if
			end if
		end if
		
	end with

end function

end namespace 'ext.gfx.png
