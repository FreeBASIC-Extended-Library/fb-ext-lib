#include once "pnginc/png_image.bi"

namespace ext.gfx.png
'::::::::
' Purpose : Find the PLTE chunk and unpack it
' Return  : 0 on success
function PLTE_prepare _
	( _
		byref png_image as png_image_t _
	) as integer

	dim as integer   PLTE_chunk = chunk_find( png_image, "PLTE", 0 )
	dim as ubyte ptr p          = any
	dim as integer   i          = any
	
	function = 1

	if PLTE_chunk <> -1 then
		
		with *png_image.chunk[PLTE_chunk]
			p = .data
			png_image.PLTE_count = .length \ 3
		end with
		
		with png_image
		
			if .PLTE_count <= 256 then
				for i = 0 to .PLTE_count - 1
					.PLTE(i).r = *p
					.PLTE(i).g = p[1]
					.PLTE(i).b = p[2]
					p += 3
				next i
				function = 0
			end if
			
		end with
	end if

end function
end namespace 'ext.gfx.png
