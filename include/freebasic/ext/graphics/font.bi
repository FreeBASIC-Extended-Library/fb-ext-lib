''Title: graphics/font.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_FONT_BI__
#define FBEXT_GFX_FONT_BI__ -1

#include once "ext/detail/common.bi"
#Include Once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

#ifndef FBEXT_NO_EXTERNAL_LIBS
#ifndef FBEXT_NO_LIBFREETYPE
#ifndef __FB_DOS__ 'Freetype is not supported on dos

	#include once "freetype2/freetype.bi"

#endif
#endif
#endif

''Namespace: ext.gfx.font
namespace ext.gfx.font

	''Function: custom_info
	''Provides an easy way to load information about a custom draw string font.
	''
	''Parameters:
	''buf - the FB.IMAGE buffer containing your font.
	''first_ - string containing the first character your font supports.
	''last_ - string containing the last character your font supports.
	''widths() - ubyte array containing the width values for each character.
	''
	''Returns:
	''Returns one of the values defined by ext.bool.
	''
	declare function custom_info( byval buf as FB.IMAGE ptr, byref first_ as const string, byref last_ as const string, widths() as const ubyte ) as ext.bool


	''Function: GetTextWidth
	''Returns the width of a string in a particular draw string font.
	''
	''Parameters:
	''fnt - FB.IMAGE ptr to the draw string font.
	''xstr - the string to return the width of.
	''
	''Returns:
	''Uinteger containing the pixel width of the specified string in the passed font.
	''
	declare function GetTextWidth( byval fnt as const FB.IMAGE ptr, byref xstr as const string ) as uinteger

#ifndef FBEXT_NO_EXTERNAL_LIBS
#ifndef FBEXT_NO_LIBFREETYPE
#ifndef __FB_DOS__

	''Enum: FontError
	''Error values that can be returned by the loadttf function. Not supported or defined on DOS.
	''
	''ftinit - unable to initialize the freetype library.
	''noloadfont - unable to locate the font file.
	''cantsize - freetype was unable to size the font to the value you specified.
	''noloadchar - freetype can't find one of the characters you requested in the font file.
	''cantrenderchar - freetype encountered an error attempting to render one of the characters.
	''
	enum FontError
		ftinit
		noloadfont
		cantsize
		noloadchar
		cantrenderchar
		fontalreadyloaded
	end enum

	''Function: loadttf
	''Loads a truetype font to a Draw String compatible font buffer, not supported or defined on DOS.
	''
	''Parameters:
	''fontname - string containing the path and filename of the font to load.
	''img - un-initialized FB.IMAGE ptr to draw the font on.
	''range_lo - the lowest character your font should support. Defaults to 1.
	''range_hi - the highest character your font should support. Defaults to 255.
	''font_size - requested size of the font in pixels, not exact. Defaults to 14.
	''colour - the colour to use when drawing the font, defaults to white or &hFFFFFF.
	''
	''Returns:
	''Integer value indicating success or failure.
	''
	''Usage:
	''You may use # as a shortcut for the common font directories on Windows and Linux.
	''e.g. "#arial.ttf" on windows expands to "c:/Windows/Fonts/arial.ttf" and on Linux will
	''expand to "/usr/share/fonts/truetype/arial.ttf".
	''Certain fonts at certain sizes may show some artifacting. We've tried to minimize this, but it seems like
	''a feature of freetype and the TrueType standard. Due to the way FreeType loads the font, you will have to
	''use the ALPHA drawing method with Draw String for your font to be displayed properly.
	''
	''(begin code)
	''#include once "ext/graphics/font.bi"
	''#include once "fbgfx.bi"
	''
	''using ext
	''
	''dim as FB.IMAGE ptr myFont
	''
	''screenres 320, 240, 32
	''
	''if gfx.loadttf( "Vera.ttf", myFont ) = 1 then
	''
	''	draw string (10,10), "Hello, World!", ,myFont, ALPHA
	''
	''else
	''
	''	print "Error loading font."
	''
	''end if
	''
	''imagedestroy myFont
	''
	declare function loadttf ( byref fontname as Const string, byref img as FB.IMAGE ptr, byval range_lo as integer = 1, byval range_hi as integer = 255, byval font_size as integer = 14, byval colour as uinteger = &HFFFFFF ) as integer

	type oFont

		public:
		declare constructor ()
		declare constructor ( byref rhs as const oFont )
		declare constructor ( byref fname as const string, byval fsize as integer = -1, byval flower as integer = 0, byval fupper as integer = 255 )
		declare operator let( byref rhs as const oFont )

		declare function Load( byref fname as const string, byval fsize as integer = -1, byval flower as integer = 0, byval fupper as integer = 255 ) as integer
		declare Function DrawString overload ( byval draw_x as integer, byval draw_y as integer, byref s as const string, byval colour as uinteger = &hFFFFFFFF, byval size as integer = -1 ) as integer
		declare Function DrawString( byval target as any ptr, draw_x as integer, draw_y as integer, byref s as const string, byval colour as uinteger = &hFFFFFFFF, byval size as integer = -1 ) as integer
		declare Function GetWidth( byref s as const string, byval size as integer = -1 ) as integer

		declare destructor

		private:
		as any ptr glyph

		as FT_Face face_
		as string font_
		as integer lower_, upper_, size_

		'[s: static, d: dynamic]
		declare function __ttfdraw_d( byval target as any ptr = 0, byval draw_x as integer, byval draw_y as integer, byref s as const string, byval colour as uinteger, byval size as integer ) as integer
		declare function __ttfdraw_s( byval target as any ptr = 0, byval draw_x as integer, byval draw_y as integer, byref s as const string, byval colour as uinteger ) as integer


	end type

#endif
#endif
#endif

end namespace 'ext.gfx.font

#endif 'FBEXT_GFX_FONT_BI__
