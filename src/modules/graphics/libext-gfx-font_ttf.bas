''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2007, yetifoot
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

''!!FIXME!!
''There are a few edge cases reported by yetifoot that result in strange renderings
''of the fonts.

#ifndef __FB_DOS__

# include once "ext/detail/common.bi"
# include once "ext/graphics/font.bi"
# include once "ext/debug.bi"

namespace ext.gfx.font

'from Anson on the mailing list:
'http://lists.nongnu.org/archive/html/freetype/2005-06/msg00033.html
function DeriveDesignHeightFromMaxHeight(byval aFace as FT_Face, byval aMaxHeightInPixel as integer) as integer

	dim as integer boundingBoxHeightInFontUnit = aFace->bbox.yMax - aFace->bbox.yMin
	dim as integer designHeightInPixels = ( ( aMaxHeightInPixel * aFace->units_per_EM ) / boundingBoxHeightInFontUnit )
	dim as integer maxHeightInFontUnit = aMaxHeightInPixel shl 6
	FT_Set_Pixel_Sizes( aFace, designHeightInPixels, designHeightInPixels )
	dim as integer currentMaxHeightInFontUnit = FT_MulFix( boundingBoxHeightInFontUnit, aFace->size->metrics.y_scale )

	while currentMaxHeightInFontUnit < maxHeightInFontUnit
		designHeightInPixels += 1
		FT_Set_Pixel_Sizes( aFace, designHeightInPixels, designHeightInPixels )
		currentMaxHeightInFontUnit = FT_MulFix( boundingBoxHeightInFontUnit, aFace->size->metrics.y_scale )
	wend

	while currentMaxHeightInFontUnit > maxHeightInFontUnit
		designHeightInPixels -= 1
		FT_Set_Pixel_Sizes( aFace, designHeightInPixels, designHeightInPixels )
		currentMaxHeightInFontUnit = FT_MulFix( boundingBoxHeightInFontUnit, aFace->size->metrics.y_scale )
	wend

	return designHeightInPixels

end Function

Function getFullFontFilePath( ByRef fontname As Const String ) As String
	If fontname[0] <> Asc("#") Then Return fontname

	Var fullfontname = ""

	#Ifdef __FB_WIN32__
		fullfontname = environ("WINDIR") & "/Fonts/" & Right(fontname, Len(fontname)-1)
	#EndIf

	#Ifdef __FB_LINUX__
		fullfontname = "/usr/share/fonts/truetype/" & Right(fontname, Len(fontname)-1)
	#EndIf

	Return fullfontname
End Function

function loadttf ( byref fontname as Const string, byref img as FB.IMAGE ptr, byval range_lo as integer = 1, byval range_hi as integer = 255, byval font_size as integer = 14, byval colour as uinteger = &HFFFFFF ) as integer

dim as FT_Library library

if FT_Init_FreeType( @library ) then
	return FontError.ftinit
end if

dim as FT_Face face

if FT_New_Face( library, getFullFontFilePath(fontname), 0, @face ) then
	return FontError.noloadfont
end if

'
'If FT_Set_Char_Size( face, 0, font_size * 64, 96, 96 ) then
'	return FontError.cantsize
'end if





if FT_Set_Pixel_Sizes( face, font_size, font_size ) then
	return FontError.cantsize
end if

font_size = DeriveDesignHeightFromMaxHeight( face, font_size )

dim as integer img_width, img_height, below, draw_x, draw_y
img_height = font_size + 1

for n as integer = 0 to 255
	if FT_Load_Char( face, n, FT_LOAD_RENDER ) then
		return FontError.cantrenderchar
	end if
	img_width += face->Glyph->Advance.x shr 6
	if (n >= range_lo) and (n <= range_hi) then
		img_width += face->Glyph->Advance.x shr 6
	end if
	if ((face->Glyph->Metrics.Height - face->Glyph->Metrics.horiBearingY) \ 64) > below then
		below = (face->Glyph->Metrics.Height - face->Glyph->Metrics.horiBearingY) \ 64
	end if
next n

img = imagecreate( img_width, img_height + 1, RGBA(0, 0, 0, 0) )

dim as ubyte ptr p = cptr( ubyte ptr, img ) + sizeof( fb.image )

p[0] = 0
p[1] = range_lo
p[2] = range_hi

p = @p[3]

draw_x = 0
draw_y = 1

dim as integer x_pos = 0, y_pos = 0

for n as integer = range_lo to range_hi
	if FT_Load_Char( face, n, FT_LOAD_RENDER ) then
		return FontError.cantrenderchar
	end if
	for y as integer = 0 to face->Glyph->Bitmap.Rows - 1
		y_pos = img_height - below ' baseline
		y_pos -= face->Glyph->Bitmap_Top
		y_pos += y
		for x as integer = 0 to face->Glyph->Bitmap.Width - 1
			x_pos = draw_x + face->Glyph->Bitmap_Left + x
			dim as ubyte c = face->Glyph->Bitmap.Buffer[x + (y * face->Glyph->Bitmap.Width)]
			if c <> 0 then
				pset img, ( x_pos, y_pos ), (colour and &HFFFFFF) or (cuint( c ) shl 24)
			end if
		next x
	next y
	draw_x += face->Glyph->Advance.x shr 6
	*p = face->Glyph->Advance.x shr 6
	p += 1
next n

FT_Done_FreeType(library)

return 1
end function

end namespace 'ext.gfx.font
#endif
