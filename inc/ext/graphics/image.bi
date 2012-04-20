''Title: graphics/image.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
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
#include once "ext/graphics/detail/common.bi"
#include once "ext/math/vector2.bi"
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
    declare function height( ) as ext.SizeType

    ''function: width
    ''Returns the width of the image.
    declare function width( ) as ext.SizeType

    ''function: pitch
    ''Returns the pitch of the image.
    declare function pitch( ) as ext.SizeType

    ''function: bpp
    ''Returns the bits per pixel of the image.
    declare function bpp( ) as ext.SizeType

    ''sub: Display
    ''Copies the image data to a buffer. Equivalent to fbgfx's put command.
    ''
    ''Parameters:
    ''_dest_ - FB.IMAGE ptr to destination buffer.
    ''_x_ - The X position to draw image at.
    ''_y_ - The Y position to draw image at.
    ''_method_ - The method to use to draw the image, one of <DrawMethods>.
    ''_al - Optional value to use with the Alpha_ draw method, defaults to 0.
    ''
    declare sub Display overload( byval _dest_ as FB.IMAGE ptr, byval _x_ as integer, byval _y_ as integer, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

    ''sub: Display
    ''Copies the image data to a buffer. Equivalent to fbgfx's put command.
    ''
    ''Parameters:
    ''_dest_ - FB.IMAGE ptr to destination buffer.
    ''_pos - position to draw image at.
    ''_method_ - The method to use to draw the image, one of <DrawMethods>.
    ''_al - Optional value to use with the Alpha_ draw method, defaults to 0.
    ''
    declare sub Display( byval _dest_ as FB.IMAGE ptr, byref _pos as const ext.math.vec2i, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)


    ''sub: Display
    ''Copies the image data to the screen. Equivalent to fbgfx's put command.
    ''
    ''Parameters:
    ''_x_ - The X position to draw image at.
    ''_y_ - The Y position to draw image at.
    ''_method_ - The method to use to draw the image, one of <DrawMethods>.
    ''_al - Optional value to use with the Alpha_ draw method, defaults to 0.
    ''
    declare sub Display( byval _x_ as integer, byval _y_ as integer, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

    ''sub: Display
    ''Copies the image data to the screen. Equivalent to fbgfx's put command.
    ''
    ''Parameters:
    ''_pos - position to draw image at.
    ''_method_ - The method to use to draw the image, one of <DrawMethods>.
    ''_al - Optional value to use with the Alpha_ draw method, defaults to 0.
    ''
    declare sub Display( byref _pos as const ext.math.vec2i, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

    declare operator Cast( ) as FB.IMAGE ptr

    ''funtion: isEmpty
    ''Returns True if the Image was not properly constructed.
    ''
    declare property isEmpty( ) as ext.bool

    ''Function: Pixels
    ''Used to access the raw pixels of the underlying image.
    ''
    ''Parameters:
    ''num_pixels - Optional value will be replaced by the number of pixels in the image if passed.
    ''
    ''Returns:
    ''Uinteger ptr to image data.
    ''
    declare function Pixels( byref num_pixels as uinteger = 0 ) as uinteger ptr

    private:
    declare sub setImage( byval _x_ as FB.IMAGE ptr )
    as bool m_isGL
    m_img as FB.IMAGE ptr
    m_gl as uinteger ptr
    as uinteger m_w, m_h

end type

end namespace

#endif
