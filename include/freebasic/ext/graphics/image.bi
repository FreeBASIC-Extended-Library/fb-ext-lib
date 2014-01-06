''Title: graphics/image.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_IMAGE_BI__
#define FBEXT_GFX_IMAGE_BI__ -1

#Ifndef fbext_NoBuiltInInstanciations
    #Define fbext_NoBuiltInInstanciations() 1
    #Define image_bi_dnbii 1
#endif

#include once "ext/detail/common.bi"
#include once "ext/math/vector2.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

#Ifdef image_bi_dnbii
    #Undef fbext_NoBuiltInInstanciations
#endif

''Namespace: ext.gfx

namespace ext.gfx

''class: Image
''Provides a *New*-able FB.IMAGE replacement with built-in memory management and convenience functions
''while maintaining compatibility with current fbgfx functions including ImageInfo.
''
type Image
    public:
    ''sub: constructor
    ''Constructs a blank image with the dimensions and color requested.
    ''
    ''Parameters:
    ''w_ - the desired width of the image.
    ''h_ - the desired height of the image.
    ''def_color - the desired default color of the image. Defaults to RGBA(255,0,255,255)
    ''
    declare constructor( byval w_ as uinteger, byval h_ as uinteger, byval def_color as uinteger = RGBA(255,0,255,255) )

    ''sub: constructor
    ''Assigns an existing OpenGL compatible image buffer to this object.
    ''
    ''Parameters:
    ''w_ - the width of the image
    ''h_ - the height of the image
    ''d_ - the buffer containing the image
    ''
    declare constructor( byval w_ as uinteger, byval h_ as uinteger, byval d_ as any ptr )

    ''sub: constructor
    ''Constructs an Image with an external FB.IMAGE. Takes over responsibility for freeing the fb.image's memory.
    ''
    ''Parameters:
    ''_x_ - FB.IMAGE ptr to be used.
    ''
    declare constructor( byval _x_ as FB.IMAGE ptr )

    ''sub: copy constructor
    ''Takes over responsibility for an FB.IMAGE from the passed Image.
    ''
    ''Parameters:
    ''_x_ - the Image class to take image data from.
    ''
    declare constructor( byref _x_ as Image )

    ''Operator: Let
    ''Takes over responsibility for the FB.IMAGE assigned
    declare operator Let( byval _x_ as fb.image ptr )

    ''sub: default constructor
    ''Constructs an invalid Image. Use with the setImage function below.
    ''
    declare constructor( )

    declare destructor( )

    ''function: height
    ''Returns the height of the image.
    declare const function height( ) as ext.SizeType

    ''function: width
    ''Returns the width of the image.
    declare const function width( ) as ext.SizeType

    ''function: pitch
    ''Returns the pitch of the image.
    declare const function pitch( ) as ext.SizeType

    ''function: bpp
    ''Returns the bits per pixel of the image.
    declare const function bpp( ) as ext.SizeType

    ''sub: Display
    ''Copies the image data to a buffer. Equivalent to fbgfx's put command.
    ''
    ''Parameters:
    ''_dest_ - IMAGE ptr to destination buffer.
    ''_x_ - The X position to draw image at.
    ''_y_ - The Y position to draw image at.
    ''_method_ - The method to use to draw the image, one of <DrawMethods>.
    ''_al - Optional value to use with the Alpha_ draw method, defaults to 0.
    ''
    declare const sub Display overload( byval _dest_ as IMAGE ptr, byval _x_ as integer, byval _y_ as integer, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

    ''sub: Display
    ''Copies the image data to a buffer. Equivalent to fbgfx's put command.
    ''
    ''Parameters:
    ''_dest_ - IMAGE ptr to destination buffer.
    ''_pos - position to draw image at.
    ''_method_ - The method to use to draw the image, one of <DrawMethods>.
    ''_al - Optional value to use with the Alpha_ draw method, defaults to 0.
    ''
    declare const sub Display( byval _dest_ as IMAGE ptr, byref _pos as const ext.math.vec2i, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)


    ''sub: Display
    ''Copies the image data to the screen. Equivalent to fbgfx's put command.
    ''
    ''Parameters:
    ''_x_ - The X position to draw image at.
    ''_y_ - The Y position to draw image at.
    ''_method_ - The method to use to draw the image, one of <DrawMethods>.
    ''_al - Optional value to use with the Alpha_ draw method, defaults to 0.
    ''
    declare const sub Display( byval _x_ as integer, byval _y_ as integer, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

    ''sub: Display
    ''Copies the image data to the screen. Equivalent to fbgfx's put command.
    ''
    ''Parameters:
    ''_pos - position to draw image at.
    ''_method_ - The method to use to draw the image, one of <DrawMethods>.
    ''_al - Optional value to use with the Alpha_ draw method, defaults to 0.
    ''
    declare const sub Display( byref _pos as const ext.math.vec2i, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

    declare const operator Cast( ) as FB.IMAGE ptr

    ''Function: copy
    ''Copies the selected pixels to a new image buffer
    ''
    ''Parameters:
    ''x1 - the top left x coordinate
    ''y1 - the top left y coordinate
    ''x2 - the bottom right x coordinate
    ''y2 - the bottom right y coordinate
    ''dest - *optional* pre-allocated image buffer
    ''
    ''Returns:
    ''A newly constructed Image ptr
    ''
    declare const function copy overload ( byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval dest as image ptr = 0 ) as image ptr

    ''Function: copy
    ''Copies the selected pixels to a new image buffer
    ''
    ''Parameters:
    ''x1y1 - top left point
    ''x2y2 - bottom right point
    ''dest - *optional* pre-allocated image buffer
    ''
    ''Returns:
    ''A newly constructed Image ptr
    ''
    declare const function copy overload ( byref x1y1 as const ext.math.vec2i, byref x2y2 as const ext.math.vec2i, byval dest as image ptr = 0) as image ptr

    ''funtion: isEmpty
    ''Returns True if the Image was not properly constructed.
    ''
    declare const property isEmpty( ) as ext.bool

    ''Function: Pixels
    ''Used to access the raw pixels of the underlying image.
    ''
    ''Parameters:
    ''num_pixels - Optional value will be replaced by the number of pixels in the image if passed.
    ''
    ''Returns:
    ''Uinteger ptr to image data.
    ''
    declare const function Pixels( byref num_pixels as uinteger = 0 ) as uinteger ptr

    private:
    declare sub setImage( byval _x_ as FB.IMAGE ptr )
    as bool m_isGL
    m_img as FB.IMAGE ptr
    m_gl as uinteger ptr
    as uinteger m_w, m_h

end type

    ''Function: copyScreen
    ''Copies from the screen to a new image buffer
    ''
    ''Parameters:
    ''x1 - the top left x coordinate
    ''y1 - the top left y coordinate
    ''x2 - the bottom right x coordinate
    ''y2 - the bottom right y coordinate
    ''dest - *optional* pre-allocated destination image buffer
    ''
    ''Returns:
    ''A newly constructed <Image> ptr or dest if not null
    declare function copyScreen overload ( byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval dest as image ptr = 0 ) as image ptr

    ''Function: copyScreen
    ''Copies from the screen to a new image buffer
    ''
    ''Parameters:
    ''x1y1 - the top left coordinate
    ''x2y2 - the bottom right coordinate
    ''dest - *optional* pre-allocated destination image buffer
    ''
    ''Returns:
    ''A newly constructed <Image> ptr or dest if not null
    declare function copyScreen overload ( byref x1y1 as const ext.math.vec2i, byref x2y2 as const ext.math.vec2i, byval dest as image ptr = 0 ) as image ptr

    ''Function: LoadImage
    ''Loads a image file from disk to a FBGFX buffer.
    ''
    ''Supports TGA, JPG, BMP and PNG images depending on allowed external libraries.
    ''If you define: FBEXT_NO_LIBZ before this header then loading PNGs is not supported.
    ''If you define: FBEXT_NO_LIBJPG before this header then loading JPGs is not supported.
    ''If you define: FBEXT_NO_EXTERNAL_LIBS then only TGA and BMP images can be loaded.
    ''
    ''Parameters:
    ''filename - the file to load.
    ''target - <target_e> (default TARGET_FBNEW) which format should the resulting image be?
    ''
    ''Returns:
    ''Pointer to <Image> with a FBGFX or OpenGL-compatible buffer, free with delete when done.
    ''
    declare function LoadImage ( byref filename as const string, byval t as target_e = TARGET_FBNEW ) as Image ptr

    ''Type: GraphicsLoader
    ''Driver for loading graphics of potentially any format
    ''To use to add support for another format, populate f and fmem with your functions then pass to <getDriver>
    ''
    type GraphicsLoader
        ''Function: f
        ''Loads an image from a disk file.
        ''pointer to function taking a string and the target (FB or GL) and returning the <Image> or null on failure
        ''
        f as function( byref as const string, byval as target_e ) as Image ptr
        ''Function: fmem
        ''Loads an image that is loaded into memory.
        ''pointer to function taking a pointer, the buffer's length and the target (FB or GL) and returning the <Image> or null on failure
        fmem as function( byval idat as any ptr, byval blen as SizeType, byval as target_e ) as Image ptr
        declare constructor
        declare operator let( byref rhs as const GraphicsLoader )
    end type
    declare operator = ( byref lhs as const GraphicsLoader, byref rhs as const GraphicsLoader ) as integer

    ''Function: getDriver
    ''Used by LoadImage to load any graphics format.
    ''To add support (or override the default) simply pass a <GraphicsLoader> you have filled in as the second parameter.
    ''
    ''Parameters:
    ''ftype - string (3 letter) extension of the file types the loader supports
    ''set_ - <GraphicsLoader> containing the (pointers to) functions that do the loading.
    ''
    ''Returns:
    ''If called with only ftype then returns the <GraphicsLoader> for the filetype, otherwise returns null.
    ''
    declare function getDriver(byref ftype as string, byval set_ as GraphicsLoader ptr = 0 ) as GraphicsLoader ptr

end namespace

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
#include once "ext/graphics/jpg.bi"
#include once "ext/graphics/bmp.bi"
#include once "ext/graphics/png.bi"
#include once "ext/graphics/tga.bi"
#include once "ext/graphics/gif.bi"
#endif

#endif
