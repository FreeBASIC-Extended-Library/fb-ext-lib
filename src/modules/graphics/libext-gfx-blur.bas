''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
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

# include once "ext/graphics/manip.bi"
# include once "crt.bi"

namespace ext.gfx

sub Blur( byref dst as FB.IMAGE ptr, byref src as const FB.IMAGE ptr, byref blur_level as integer )

	if ( dst = null ) OR ( src = null ) then exit sub

	dim as uinteger ptr srcptr = FBEXT_FBGFX_PIXELPTR( uinteger, src )
	dim as uinteger ptr dstptr = FBEXT_FBGFX_PIXELPTR( uinteger, dst )

	static as integer xstart, xend, ystart, yend, hits, r, g, b, c

	if blur_level <= 0 then

		memcpy( dstptr, srcptr, src->height * src->pitch )

	exit sub

	end if

	for y as integer = 0 to dst->height - 1

		for x as integer = 0 to dst->width - 1

			xstart = x - blur_level
			xend = x + blur_level
			ystart = y - blur_level
			yend = y + blur_level

			if xstart < 0 then
				xstart = 0
			end if

			if xend > src->width-1 then

				xend = src->width - 1

			end if

			if ystart < 0 then
				ystart = 0
			end if

			if yend > src->height - 1 then
				yend = src->height - 1
			end if

			hits = 0
			r = 0
			g = 0
			b = 0

			for y2 as integer = ystart to yend

				for x2 as integer = xstart to xend

					hits += 1

					c = *cast( uinteger ptr, cast( ubyte ptr, srcptr ) + y2 * src->pitch + x2 * src->bpp )

					r += ( c shr 16 ) and &hFF 
					g += ( c shr  8 ) and &hFF 
					b += ( c        ) and &hFF

				next

			next

			r \= hits
			g \= hits
			b \= hits

			*cast( uinteger ptr, cast( ubyte ptr, dstptr ) + y * dst->pitch + x * dst->bpp ) = rgb( r, g, b )

		next

	next

end sub

end namespace
