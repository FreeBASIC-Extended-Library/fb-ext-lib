#include once "pnginc/png_image.bi"
#include once "crt.bi"

namespace ext.gfx.png
'::::::::
' Purpose : Load a file to a buffer
' Return  : buffer as function return, size of file in byref fsize
function file_to_buffer _
	( _
		byval fname as zstring ptr, _
		byref fsize as integer _
	) as any ptr

	dim as FILE ptr  hfile  = NULL
	dim as ubyte ptr buffer = NULL

	fsize = 0

	if fname <> NULL then
		hfile = fopen( fname, "rb" )
		if hfile <> NULL then
			fseek( hfile, 0, SEEK_END )
			fsize = ftell( hfile )
			fseek( hfile, 0, SEEK_SET )
			if fsize > 0 then
				buffer = callocate( fsize )
				if buffer <> NULL then
					if fread( buffer, 1, fsize, hfile ) <> fsize then
						deallocate( buffer )
						buffer = NULL
					end if
				end if
			end if
			fclose( hfile )
		end if
	end if

	function = buffer

end function 

end namespace
