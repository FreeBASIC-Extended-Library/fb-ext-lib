''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
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

# include once "ext/detail/common.bi"
# include once "ext/graphics/font.bi"
# include once "ext/graphics/manip.bi"

namespace ext.gfx.font

function custom_info( byval buf as FB.IMAGE ptr, byref first_ as const string, byref last_ as const string, widths() as const ubyte ) as ext.bool

	if (buf = NULL) then return ext.bool.invalid
	
	var first_char = first_[0], last_char = last_[0], counter = 3
	if (lbound(widths) <> cast(integer, first_char)) then return ext.bool.invalid
	if (ubound(widths) <> cast(integer, last_char)) then return ext.bool.invalid

	var pixel_data = FBEXT_FBGFX_PIXELPTR( ubyte, buf )

	pixel_data[0] = 0
	pixel_data[1] = first_char
	pixel_data[2] = last_char

	for n as ubyte = first_char to last_char

		pixel_data[counter] = widths(n)
		counter += 1

	next

	return ext.bool.true

end function

function GetTextWidth( byval fnt as const FB.IMAGE ptr, byref xstr as const string ) as uinteger

	var pixel_data = FBEXT_FBGFX_PIXELPTR( const ubyte, fnt )

	static as uinteger f_char, l_char, offset

	offset = 0

	if( pixel_data[1]<>1 ) then
		offset = (pixel_data[1]-1)

	end if

	f_char = pixel_data[1]
	l_char = pixel_data[2]


	dim as uinteger result = 0

	for n as uinteger = 0 to len(xstr) - 1

		var temp = xstr[n]

		if temp >= f_char AND temp <= l_char then result += pixel_data[(temp - offset) + 2]

	next

	return result

end function

end namespace
