''Title: graphics/manip.bi
''
''About: License
''Copyright (c) 2007-2011, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License


#ifndef FBEXT_GFX_MANIP_BI__
#define FBEXT_GFX_MANIP_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

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
	''<Getting a Pointer to Image Data>
	''
	#define FBEXT_FBGFX_PIXELPTR(t,v) cast( t ptr, (v) + 1 )

        ''Function: grayscale
        ''Converts a color image into grayscale.
        ''
        ''Parameters:
        ''img - FBGFX buffer containing the image to convert
        ''skip_trans - Boolean, should we skip the transparent pixels? defaults to true
        ''
        ''Returns:
        ''A new image containing the grayscale version, destroy with imagedestroy when done.
        ''
        declare function grayscale ( byval img as fb.image ptr, byval skip_trans as ext.bool = ext.bool.true ) as fb.image ptr

	''Function: flipVertical
	''Flips an image on it vertical axis.
	''
	''Parameters:
	''img - FBGFX buffer to work on.
	''
	''Returns:
	''A pointer to the vertically flipped fb.image.
	''
	declare function flipVertical ( byval img As fb.image Ptr ) As fb.image ptr

	''Function: flipHorizontal
	''Flips an image on it horizontal axis.
	''
	''Parameters:
	''img - FBGFX buffer to work on.
	''
	''Returns:
	''A pointer to the horizontally flipped fb.image.
	''
	declare function flipHorizontal ( byval img As fb.image Ptr ) As fb.image ptr

	''Sub: change_color
	''Attempts to change one color to another in a FBGFX buffer.
	''
	''Parameters:
	''img - FBGFX buffer to work on.
	''from_ - uinteger representation of the color to change.
	''to_ - uinteger representation of the color to change to.
	''include_alpha - optional flag to determine if the alpha channel is included in the color check, defaults to false.
	''is_font - optional flag to determine if the buffer is a FBGFX font buffer, defaults to false.
	''
	''See Also:
	''<Changing Colors in an Image>
	''
	declare sub change_color ( byref img as FB.IMAGE ptr, byval from_ as uinteger, byval to_ as uinteger, byval include_alpha as ext.bool = ext.bool.false, byval is_font as ext.bool = ext.bool.false )

	''Sub: Rotate
	''Rotates a image buffer.
	''
	''Parameters:
	''dst - the image buffer to write to.
	''src - the image buffer to rotate.
	''positx - x position (center of image) to draw the rotated image onto the destination buffer
	''posity - y position (center of image) to draw the rotated image onto the destination buffer
	''angle - the angle in degrees to rotate the image.
	''
	''See Also:
	''<Fast Rotation of an Image>
	''
	declare sub Rotate( byref dst as FB.IMAGE ptr, byref src as const FB.IMAGE ptr, byref positx as integer, byref posity as integer, byref angle as integer )



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
	''
	''See Also:
	''<Accurate Rotation and Zooming of Images>
	''
	declare sub RotoZoom( byref dst as FB.IMAGE ptr = 0, byref src as const FB.IMAGE ptr, byref positx as integer, byref posity as integer, byref angle as integer, byref zoomx as single, byref zoomy as single )


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
	''
	''See Also:
	''<Accurate Rotation and Zooming of Images>
	''
	declare sub RotoZoomASM( byref dst as FB.IMAGE ptr = 0, byref src as const FB.IMAGE ptr, byval positx as integer, byval posity as integer, byref angle as integer, byref zoomx as single, byref zoomy as single = 0, byval transcol as uinteger  = &hffff00ff )


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
	''
	''See Also:
	''<Using Blur>
	''
	declare sub Blur( byref dst as FB.IMAGE ptr, byref src as const FB.IMAGE ptr, byref blur_level as integer )

	''Sub: Scale2X
	''performs the Scale2X algorithm on an image.
	''
	''Parameters:
	''dst - the image buffer to write to. Use 0 to draw to the screen.
	''src - the image buffer to to perform the algorithm on.
	''positx - the x position to place the scaled sprite.
	''posity - the y position to place the scaled sprite.
	''
	''See Also:
	''<Simple Scale2X>
	''
	declare sub Scale2X( byref dst as FB.IMAGE ptr = 0, byref src as const FB.IMAGE ptr, byref positx as integer, byref posity as integer )

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
	''See Also:
	''<!example pending!>
	''
    declare sub AlphaBlit( byval dst as FB.IMAGE ptr, byval src as const FB.IMAGE ptr, byref positx as integer, byref posity as integer, byref malpha as integer )


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
	''See Also:
	''<!example pending!>
	''
    declare sub Intensify( byval dst as FB.IMAGE ptr, byval src as const FB.IMAGE ptr, byref positx as integer, byref posity as integer, byref intensity as integer )


	''Example: Getting a Pointer to Image Data
	''(begin code)
	''#include once "ext/graphics.bi"
	''#include once "fbgfx.bi"
	''
	''using ext
	''
	''const as string imagename = "myniceimage.png"
	''
	''screenres 320,240,32
	''
	''var xImg = LoadImage(imagename)
	''
	''var xImgPP = FBEXT_FBGFX_PIXELPTR( uinteger, xImg )
	''
	''print "The color of the top left pixel in " & _
	''			imagename & " is: " & xImgPP[0]
	''sleep
	''(end code)
	''

	''Example: Changing Colors in an Image
	''(begin code)
	''#include once "ext/graphics.bi"
	''#include once "fbgfx.bi"
	''
	''using ext
	''
	''screenres 320, 240, 32
	''
	''dim as FB.IMAGE ptr myimg
	''
	'''create a 100x100 box and fill it with pink with full alpha
	''myimg = imagecreate(100,100, &hFFFF00FF)
	''
	''print "Original image:"
	''put (1,10),myimg, PSET
	''
	''sleep
	''
	'''change pink to yellow, keeping the original alpha and treating it like a font buffer
	''gfx.change_color( myimg, &hFF00FF, &hFFF00F, false, true )
	''
	''cls
	''print "New image:"
	''put (1,10),myimg, PSET
	'''Notice the top line of pixels is still pink, this is the correct behaviour
	'''font buffer mode, if you would change the true in the call to change_color to
	'''false, this line would also be yellow.
	''
	''sleep
	''
	''imagedestroy(myimg)
	''(end code)
	''

	''Example: Fast Rotation of an Image
	''(begin code)
	''#include once "ext/graphics.bi"
	''#include once "fbgfx.bi"
	''using ext
	''
	''screenres 320, 240, 32
	''
	''dim as FB.IMAGE ptr original = LoadImage("fbextlogo.jpg")
	''
	''var angle = 0
	''
	''do while not multikey(FB.SC_ESCAPE)
	''
	''	screenlock
	''	cls
	''	gfx.Rotate(0, original, 160 - original->width \ 2, 120 - original->height \ 2, angle)
	''	screenunlock
	''
	''	if multikey(FB.SC_RIGHT) then angle -= 5
	''	if multikey(FB.SC_LEFT) then angle += 5
	''	if multikey(FB.SC_UP) then angle = 0
	''	if multikey(FB.SC_DOWN) then angle = 180
	''
	''	if angle < 0 then angle = 360 + angle
	''	if angle > 360 then angle = (angle - 360)
	''
	''	sleep 5,1
	''
	''loop
	''(end code)
	''

	''Example: Accurate Rotation and Zooming of Images
	''(begin code)
	''#include once "ext/graphics.bi"
	''#include once "fbgfx.bi"
	''using ext
	''
	''screenres 320, 240, 32
	''
	''dim as FB.IMAGE ptr original = LoadImage("fbextlogo.jpg")
	''
	''var angle = 0
	''dim as single zoom = 1
	''
	''do while not multikey(FB.SC_ESCAPE)
	''
	''	screenlock
	''	cls
	''	gfx.RotoZoom( 0, original, 160 - original->width \ 2, 120 - original->height \ 2, angle, zoom, zoom )
	''	screenunlock
	''
	''	if multikey(FB.SC_RIGHT) then angle -= 5
	''	if multikey(FB.SC_LEFT) then angle += 5
	''	if multikey(FB.SC_UP) then zoom += .1
	''	if multikey(FB.SC_DOWN) then zoom-=.1
	''
	''	if zoom<0 then zoom = 0
	''
	''	if angle < 0 then angle = 360 + angle
	''	if angle > 360 then angle = (angle - 360)
	''
	''	sleep 5,1
	''
	''loop
	''(end code)
	''

	''Example: Using Blur
	''(begin code)
	''#include once "ext/graphics.bi"
	''#include once "fbgfx.bi"
	''
	''using ext
	''
	''screenres 320,240,32
	''
	'''test 1, blur the same image.
	''dim as FB.IMAGE ptr test1 = LoadImage("fbextlogo.jpg")
	''
	''put( 160 - test1->width \ 2, 120 - test1->height \ 2 ), test1, PSET
	''
	''sleep 1000
	''
	''cls
	''
	''for i as integer = 1 to 256
	''
	''    gfx.blur( test1, test1, 1 )
	''
	''    put( i, 120 - test1->height \ 2 ), test1, PSET
	''
	''next
	''
	'''test 2, blur using 2 different buffers.
	''dim as FB.IMAGE ptr test2 = LoadImage("fbextlogo.jpg")
	''
	''dim as single amt
	''
	''for i as integer = 0 to 360
	''
	''    amt = ( i * 5 ) * math.pi_180
	''
	''    gfx.blur( test1, test2, 1.5f + 1.5f * sin(amt) )
	''
	''    put( 160 - test1->width \ 2, 120 - test1->height \ 2 ), test1, PSET
	''
	''next
	''
	''print "Finished!"
	''sleep
	''(end code)
	''

	''Example: Simple Scale2X
	''(begin code)
	''#include once "ext/graphics.bi"
	''#include once "fbgfx.bi"
	''using ext
	''
	''screenres 640, 480, 32
	''
	''dim as FB.IMAGE ptr original = LoadImage("fbextlogo.jpg")
	''
	''put(0,0),original, pset
	''gfx.Scale2X( 0, original, original->width, 0 )
	''
	''sleep
	''(end code)
	''
end namespace 'ext.gfx



#endif 'FBEXT_GFX_MANIP_BI__
