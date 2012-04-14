#include once "pnginc/png_image.bi"

namespace ext.gfx.png

' Tables for calculating when in interlaced mode
static as integer tb_wfac(1 to 7) = {8, 8, 4, 4, 2, 2, 1}
static as integer tb_hfac(1 to 7) = {8, 8, 8, 4, 4, 2, 2}
static as integer tb_xoff(1 to 7) = {0, 4, 0, 2, 0, 1, 0}
static as integer tb_yoff(1 to 7) = {0, 0, 4, 0, 2, 0, 1}
' The 8 byte signature that all PNG files must start with
static as ubyte png_sig(0 to 7) = {137, 80, 78, 71, 13, 10, 26, 10}

'::::::::
' Purpose : find the next chunk that matches _type_
' Return  : -1 if not found, index if found
function chunk_find _
	( _
		byref png_image as png_image_t, _
		byval _type_    as zstring ptr, _
		byval start_pos as integer _
	) as integer

	dim as integer i = any

	function = -1

	with png_image
	
		for i = start_pos to .chunk_count - 1
			if IS_CHUNK_TYPE( .chunk[i]->type, _type_ ) then
				function = i
				exit for
			end if
		next i
		
	end with

end function

'::::::::
' Purpose : Calculate the scan size for this pass (pass ignored for non
'           interlaced images)
' Return  : the scan size in bytes
function calc_scan_size _
	( _
		byref png_image as png_image_t, _
		byval pass as integer _
	) as integer

	dim as integer scan_size = any
	dim as integer w         = any

	with png_image
	
		w = .width
		
		if .interlacemethod = 1 then
			if w <= tb_xoff(pass) then return 0
			w = (w + tb_wfac(pass) - tb_xoff(pass) - 1) \ tb_wfac(pass)
		end if
		
		scan_size = ((w * .bitdepth) + 7) \ 8
		
		if .colortype = 2 then
			scan_size *= 3
		elseif .colortype = 4 then
			scan_size *= 2
		elseif .colortype = 6 then
			scan_size *= 4
		end if
		
	end with

	function = scan_size + 1

end function

end namespace 'ext.gfx.png
