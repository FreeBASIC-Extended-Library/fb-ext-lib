#include once "pnginc/png_image.bi"
#include once "crt.bi"


namespace ext.gfx.png

'::::::::
' Purpose : Clear the structure and set the buffer
' Return  : none
sub png_image_init _
	( _
		byref png_image  as png_image_t, _
		byval buffer     as any ptr, _
		byval buffer_len as uinteger _
	)

	memset( @png_image, 0, sizeof( png_image_t ) )

	with png_image
		.buffer = buffer
		.buffer_len  = buffer_len
		.initialized = TRUE
	end with

end sub

end namespace 'ext.gfx.png
