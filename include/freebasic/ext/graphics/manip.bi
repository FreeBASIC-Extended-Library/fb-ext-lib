''Title: graphics/manip.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License


#ifndef FBEXT_GFX_MANIP_BI__
#define FBEXT_GFX_MANIP_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/graphics/detail/common.bi"
#include once "ext/graphics/image.bi"

''Namespace: ext.gfx

namespace ext.gfx

    ''Macro: FBEXT_FBGFX_PIXELPTR
    ''Clear way to gain a pointer to a FBGFX image's pixels of any type.
    ''
    ''Parameters:
    ''t - the type (without the ptr) to cast to.
    ''v - the variable referring to the FB.IMAGE (must be a FB.IMAGE ptr)
    ''
    ''Returns:
    ''Pointer of the type passed pointing to the raw pixels of a FB.IMAGE.
    ''
    ''See Also:
    ''<Image>
    ''
    #define FBEXT_FBGFX_PIXELPTR(t,v) cast( t ptr, (v) + 1 )

        ''Function: grayscale
        ''Converts a color image into grayscale.
        ''
        ''Parameters:
        ''img - <Image> buffer containing the image to convert
        ''skip_trans - Boolean, should we skip the transparent pixels? defaults to true
        ''
        ''Returns:
        ''A new image containing the grayscale version, destroy with imagedestroy when done.
        ''
        declare function grayscale ( byval img as Image ptr, byval skip_trans as ext.bool = ext.bool.true ) as Image ptr

    ''Function: flipVertical
    ''Flips an image on it vertical axis.
    ''
    ''Parameters:
    ''img - <Image> buffer to work on.
    ''
    ''Returns:
    ''A pointer to the vertically flipped Image.
    ''
    declare function flipVertical ( byval img As const Image Ptr ) As Image ptr

    ''Function: flipHorizontal
    ''Flips an image on it horizontal axis.
    ''
    ''Parameters:
    ''img - <Image> buffer to work on.
    ''
    ''Returns:
    ''A pointer to the horizontally flipped Image.
    ''
    declare function flipHorizontal ( byval img As const Image Ptr ) As Image ptr

    ''Sub: changeColor
    ''Attempts to change one color to another in a <Image> buffer.
    ''
    ''Parameters:
    ''img - <Image> buffer to work on.
    ''from_ - uinteger representation of the color to change.
    ''to_ - uinteger representation of the color to change to.
    ''include_alpha - optional flag to determine if the alpha channel is included in the color check, defaults to false.
    ''is_font - optional flag to determine if the buffer is a FBGFX font buffer, defaults to false.
    ''
    declare sub changeColor ( byref img as Image ptr, byval from_ as uinteger, byval to_ as uinteger, byval include_alpha as ext.bool = ext.bool.false, byval is_font as ext.bool = ext.bool.false )

    ''Sub: Rotate
    ''Rotates a image buffer.
    ''
    ''Parameters:
    ''dst - the image buffer to write to.
    ''src - the image buffer to rotate.
    ''positx - x position (center of image) to draw the rotated image onto the destination buffer
    ''posity - y position (center of image) to draw the rotated image onto the destination buffer
    ''angle - the angle in degrees to rotate the image.
    declare sub Rotate( byref dst as Image ptr = 0, byref src as const Image ptr, byref positx as integer, byref posity as integer, byref angle as integer )



    ''Sub: RotoZoom
    ''Rotates and scales an image buffer. (per axis)
    ''
    ''Parameters:
    ''dst - the image buffer to write to.
    ''src - the image buffer to rotate/zoom.
    ''positx - the x position to "put" on the dst image buffer.
    ''positx - the y position to "put" on the dst image buffer.
    ''angle - the angle in degrees to rotate the image.
    ''zoomx - the amount to zoom on the x axis.
    ''zoomy - the amount to zoom on the y axis.
    declare sub RotoZoom( byref dst as Image ptr = 0, byref src as const Image ptr, byref positx as integer, byref posity as integer, byref angle as integer, byref zoomx as single, byref zoomy as single )


    ''Sub: RotoZoomASM
    ''Rotates and scales an image buffer. (per axis): 32 bit images only. could possibly add other depths if requested.
    ''
    ''Parameters:
    ''dst - the image buffer to write to.
    ''src - the image buffer to rotate/zoom.
    ''positx - the x position to "put" on the dst image buffer.
    ''positx - the y position to "put" on the dst image buffer.
    ''angle - the angle in degrees to rotate the image.
    ''zoomx - the amount to zoom on the x axis.
    ''zoomy - the amount to zoom on the y axis. (optional parameter: if omitted, zoomx value is used.)
    ''transcol - the transparent color. (optional parameter: if omitted, fbgfx's *magic pink*(&hffff00ff) color is used.)
    declare sub RotoZoomASM( byref dst as Image ptr = 0, byref src as const Image ptr, byval positx as integer, byval posity as integer, byref angle as integer, byref zoomx as single, byref zoomy as single = 0, byval transcol as uinteger  = &hffff00ff )


    ''Sub: Blur
    ''Blurs an image buffer.
    ''
    ''Parameters:
    ''dst - the image buffer to write to.
    ''src - the image buffer to blur.
    ''blur_level - the amount of blur to apply.
    ''
    ''Notes:
    ''When attempting to apply a blur level of <= 0 this function simply copies
    ''the source image into the destination image.
    declare sub Blur( byref dst as Image ptr, byref src as const Image ptr, byref blur_level as integer )

    ''Sub: Scale2X
    ''performs the Scale2X algorithm on an image.
    ''
    ''Parameters:
    ''dst - the image buffer to write to. Use 0 to draw to the screen.
    ''src - the image buffer to to perform the algorithm on.
    ''positx - the x position to place the scaled sprite.
    ''posity - the y position to place the scaled sprite.
    ''
    declare sub Scale2X( byref dst as Image ptr = 0, byref src as const Image ptr, byref positx as integer, byref posity as integer )

    ''Sub: AlphaBlit
    ''performs additive alpha blending on an image.
    ''
    ''Parameters:
    ''dst - the image buffer to write to. Use 0 to draw to the screen.
    ''src - the image buffer to to perform the algorithm on.
    ''positx - the x position to place the scaled sprite.
    ''posity - the y position to place the scaled sprite.
    ''malpha - the additive alpha value to add.
    ''
    declare sub AlphaBlit( byval dst as Image ptr, byval src as const Image ptr, byref positx as integer, byref posity as integer, byref malpha as integer )


    ''Sub: Intensify
    ''performs brighten/darken filtering on an image.
    ''
    ''Parameters:
    ''dst - the image buffer to write to. Use 0 to draw to the screen.
    ''src - the image buffer to to perform the algorithm on.
    ''positx - the x position to place the scaled sprite.
    ''posity - the y position to place the scaled sprite.
    ''intensity - the amount to darken/brighten the image.
    ''
    declare sub Intensify( byval dst as IMAGE ptr, byval src as const IMAGE ptr, byref positx as integer, byref posity as integer, byref intensity as integer )

end namespace 'ext.gfx

#endif 'FBEXT_GFX_MANIP_BI__
