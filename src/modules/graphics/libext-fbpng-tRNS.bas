#include once "pnginc/png_image.bi"


namespace ext.gfx.png
'::::::::
' Purpose : Prepare the tRNS chunk
' Return  : Zero on success, non zero otherwise
function tRNS_prepare _
	( _
		byref png_image as png_image_t _
	) as integer

	dim as integer   tRNS_chunk = chunk_find( png_image, "tRNS", 0 )
	dim as ubyte ptr p          = any
	dim as integer   i          = any

	function = 1

	if tRNS_chunk <> -1 then
		with png_image
			p = .chunk[tRNS_chunk]->data
			.has_tRNS = TRUE
			select case .colortype
				case 0
					if .chunk[tRNS_chunk]->length = 2 then
						.tRNS_0 = get_u16( p )
						function = 0
					end if
				case 2
					if .chunk[tRNS_chunk]->length = 6 then
						.tRNS_2r = get_u16( p )
						.tRNS_2g = get_u16( @p[2] )
						.tRNS_2b = get_u16( @p[4] )
						function = 0
					end if
				case 3
					if .chunk[tRNS_chunk]->length <= 256 then
						for i = 0 to .chunk[tRNS_chunk]->length - 1
							.tRNS_3(i) = p[i]
						next i
						for i = .chunk[tRNS_chunk]->length to 255
							.tRNS_3(i) = 255
						next i
						function = 0
					end if
			end select
		end with
	else
		function = 0
	end if

end function

end namespace 'ext.gfx.png
