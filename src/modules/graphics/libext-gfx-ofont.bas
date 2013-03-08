''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''Copyright (c) 2010, LukeL
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

#include once "ext/graphics/font.bi"

namespace ext.gfx.font

type ttfont_libhndl

   as FT_Library ptr library

   as integer internal_error, external_error
   as integer init

End Type

type ttfont_glyph

   as integer btop, bleft
   as integer brows, bwidth

   as integer advance_x
   as any ptr pixel_data

End Type

declare Function getFullFontFilePath( ByRef fontname As Const String ) As String
declare function DeriveDesignHeightFromMaxHeight(byval aFace as FT_Face, byval aMaxHeightInPixel as integer) as integer

dim shared FTControl as any ptr

sub ofontInit ( ) constructor

	if FTControl = 0 then
		FTControl = new ttfont_libhndl
				cast( ttfont_libhndl ptr, FTControl )->library = new FT_Library
		cast( ttfont_libhndl ptr, FTControl )->external_error = FT_Init_FreeType( cast( ttfont_libhndl ptr, FTControl )->library )

	end if

end sub

sub ofontDeInit ( ) destructor

	if FTControl <> 0 then
		FT_Done_FreeType( *cast( ttfont_libhndl ptr, FTControl )->library )
		delete cast( ttfont_libhndl ptr, FTControl )
		FTControl = 0
	end if

end sub

		constructor oFont()
			glyph = new ttfont_glyph[255]
		end constructor

		constructor oFont( byref rhs as const oFont )
			glyph = new ttfont_glyph[255]
			font_ = space( len(rhs.font_) )
			font_ = rhs.font_
			upper_ = rhs.upper_
			lower_ = rhs.lower_
			memcpy( glyph, rhs.glyph, sizeof(ttfont_glyph) * 255 )
		end constructor

		constructor oFont( byref fname as const string, byval fsize as integer = -1, byval flower as integer = 0, byval fupper as integer = 255 )
			glyph = new ttfont_glyph[255]

			this.Load( fname, fsize, flower, fupper )

		end constructor

		function oFont.Load( byref fname as const string, byval fsize as integer = -1, byval flower as integer = 0, byval fupper as integer = 255 ) as integer

  dim as integer ret

   if len( font_ ) then return fontalreadyloaded

   font_ = getFullFontFilePath( fname )
   lower_ = flower
   upper_ = fupper

   if fsize = -1 then

      ret = FT_New_Face( *cast(ttfont_libhndl ptr, FTControl )->library, font_, 0, @face_ )

      if ret <> 0 then
         cast(ttfont_libhndl ptr, FTControl )->external_error = ret
         return noloadfont
      EndIf

      size_ = -1

   else 'static size

      ret = FT_New_Face( *cast(ttfont_libhndl ptr, FTControl )->library, font_, 0, @face_ )

      if ret <> 0 then
         cast(ttfont_libhndl ptr, FTControl )->external_error = ret
         return noloadfont
      EndIf

      size_ = DeriveDesignHeightFromMaxHeight( face_, fsize )

      ret = FT_Set_Pixel_Sizes( face_, size_, size_ )
      if ret <> 0 then
         cast(ttfont_libhndl ptr, FTControl )->external_error = ret
         return cantsize
      EndIf
		var glyp = cast( ttfont_glyph ptr, glyph )
      for i as integer = lower_ to upper_

         ret = FT_Load_Char( face_, i, FT_LOAD_RENDER )
         if ret <> 0 then
            cast(ttfont_libhndl ptr, FTControl )->external_error = ret
            return noloadfont
         EndIf

         glyp[ i ].bleft = face_->Glyph->Bitmap_Left
         glyp[ i ].btop = face_->Glyph->Bitmap_Top
         glyp[ i ].bwidth = face_->Glyph->Bitmap.Width
         glyp[ i ].brows = face_->Glyph->Bitmap.Rows
         glyp[ i ].advance_x = face_->Glyph->Advance.x shr 6

         glyp[ i ].pixel_data = callocate( ( face_->Glyph->Bitmap.Rows * face_->Glyph->Bitmap.Width ) )

         dim as ubyte ptr fp = face_->Glyph->Bitmap.Buffer
         dim as ubyte ptr pp = cptr( ubyte ptr, glyp[ i ].pixel_data )

         for y as integer = 0 to face_->Glyph->Bitmap.Rows - 1
      		for x as integer = 0 to face_->Glyph->Bitmap.Width - 1
      			*pp = *fp
      			pp += 1
      			fp += 1
      		next x
      	next y

      Next i

      FT_Done_Face( face_ )

   EndIf

   Function = ret

		end function

		Function oFont.DrawString overload ( byval draw_x as integer, byval draw_y as integer, byref s as const string, byval colour as uinteger = &hFFFFFFFF, byval size as integer = -1 ) as integer
			if size = -1 orelse size = size_ then
				return __ttfdraw_s( 0, draw_x, draw_y, s, colour )
			else
				return __ttfdraw_d( 0, draw_x, draw_y, s, colour, size )
			end if
		end function

		Function oFont.DrawString( byval target as any ptr, draw_x as integer, draw_y as integer, byref s as const string, byval colour as uinteger = &hFFFFFFFF, byval size as integer = -1 ) as integer
					if size = -1 orelse size = size_ then
				return __ttfdraw_s( target, draw_x, draw_y, s, colour )
			else
				return __ttfdraw_d( target, draw_x, draw_y, s, colour, size )
			end if
		end function

	Function oFont.GetWidth( byref s as const string, byval size as integer = -1 ) as integer
		   var ret = 0

   if size = -1 then

      size = DeriveDesignHeightFromMaxHeight( face_, size )
      FT_Set_Pixel_Sizes( face_, size, size )

      for i as integer = 0 to len(s) - 1
         FT_Load_Char( face_, s[i], FT_LOAD_RENDER )
   	   ret += ( face_->Glyph->Advance.x shr 6 ) + face_->Glyph->Bitmap_Left
   	next

   else
	var glyp = cast( ttfont_glyph ptr, glyph )
      for i as integer = 0 to len(s) - 1
         ret += glyp[ s[i] ].advance_x + glyp[ s[i] ].bLeft
      Next

   EndIf

   Function = ret

	end function

		destructor oFont
			delete[] cast( ttfont_glyph ptr, glyph )
			font_ = ""
		end destructor

function oFont.__ttfdraw_d( byval target as any ptr = 0, byval draw_x as integer, byval draw_y as integer, byref s as const string, byval colour as uinteger, byval size as integer ) as integer

   size = DeriveDesignHeightFromMaxHeight( face_, size )

	draw_y += size

   if FT_Set_Pixel_Sizes( face_, size, size ) then
      'die( "Unable to set size" )
   EndIf

   for i as integer = 0 to len( s ) - 1

      if FT_Load_Char( face_, s[i], FT_LOAD_RENDER ) then
		   'die( "Unable to load and render char" )
	   end if

   	draw_x += face_->Glyph->Bitmap_Left
   	draw_y -= face_->Glyph->Bitmap_Top

   	dim as ubyte ptr fp = face_->Glyph->Bitmap.Buffer
   	dim as uinteger rb, g
   	dim as integer a

   	for y as integer = 0 to face_->Glyph->Bitmap.Rows - 1
   		for x as integer = 0 to face_->Glyph->Bitmap.Width - 1
   		   a = *fp
   			if a <> 0 then

   				' http://www.daniweb.com/code/snippet216791.html
   				rb = (((colour and &H00ff00ff) * a) and &Hff00ff00)
				   g =  (((colour and &H0000ff00) * a) and &H00ff0000)

   				pset target, ( draw_x + x, draw_y + y ), (rb or g) shr 8
   			end if
   			fp += 1
   		next x
   	next y

   	draw_y += face_->Glyph->Bitmap_Top
   	draw_x += face_->Glyph->Advance.x shr 6

   next i

	function = draw_x - 1

End Function

function oFont.__ttfdraw_s( byval target as any ptr = 0, byval draw_x as integer, byval draw_y as integer, byref s as const string, byval colour as uinteger ) as integer

   draw_y += size_
	var glyp = cast( ttfont_glyph ptr, glyph )
   for i as integer = 0 to len(s) - 1

      with glyp[ s[i] ]

      draw_x += .bLeft
   	draw_y -= .bTop

   	dim as ubyte ptr fp = .pixel_data
   	dim as uinteger rb, g
   	dim as integer a

   	for y as integer = 0 to .bRows - 1
   		for x as integer = 0 to .bWidth - 1
   		   a = *fp
   			if a <> 0 then

				   ' http://www.daniweb.com/code/snippet216791.html
				   rb = (((colour and &H00ff00ff) * a) and &Hff00ff00)
				   g =  (((colour and &H0000ff00) * a) and &H00ff0000)

				   pset target, ( draw_x + x, draw_y + y ), (rb or g) shr 8

			   end if
   			fp += 1
   		next x
   	next y

   	draw_y += .bTop
   	draw_x += .advance_x

   	end with

   next i

	function = draw_x - 1

end function

end namespace
