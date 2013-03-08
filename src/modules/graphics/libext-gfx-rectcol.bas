''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
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


# include once "ext/detail/common.bi"
# include once "fbgfx.bi"

namespace ext.gfx

	'' :::::
	function collision_rect ( byval img1 as const FB.IMAGE ptr, byval x1 as integer, byval y1 as integer,	byval img2 as const FB.IMAGE ptr, byval x2 as integer, byval y2 as integer ) as ext.bool
	
		dim as integer xl1 = x1 + (img1->width - 1)
		dim as integer yl1 = y1 + (img1->height - 1)
		dim as integer xl2 = x2 + (img2->width - 1)
		dim as integer yl2 = y2 + (img2->height - 1)
		
		'' all you have to do is a really basic check to see if the blocks absolutely
		'' can not be touching, on each side of the square.
		
		'' object 1's right and bottom less than object 2's left and top
		if xl1 < x2 then return ext.bool.false
		if yl1 < y2 then return ext.bool.false
		'' object 2's right and bottom less than object 1's left and top
		if xl2 < x1 then return ext.bool.false
		if yl2 < y1 then return ext.bool.false
		
		'' must be touching
		return ext.bool.true
	
	end function

end namespace 'ext.gfx
