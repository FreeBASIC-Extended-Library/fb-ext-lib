''Title: graphics/GIF.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''Uses GIFLIB Copyright: (C) 1997 Eric S. Raymond <esr@thyrsus.com>
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_GIF_BI__
#define FBEXT_GFX_GIF_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

#ifndef FBEXT_NO_EXTERNAL_LIBS
#ifndef FBEXT_NO_LIBGIF

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
#define FBEXT_BUILD_NO_GFX_LOADERS -1
#include once "ext/graphics/image.bi"
#undef FBEXT_BUILD_NO_GFX_LOADERS
#endif

''Namespace: ext.gfx.gif
namespace ext.gfx.gif

''Function: load
''Loads the first frame in a gif image
''
''Notes:
''At this time all GIF images width must be a multiple of 2 to load properly
''
''Parameters:
''fn - the file name of the GIF image
''t - the format of image to return (OpenGL or FB)
''
''Returns:
''<ext.gfx.Image> ptr or null on error
''
declare function load( byref fn as const string, byval t as target_e ) as ext.gfx.Image ptr

''Function: loadAll
''Loads all images in a gif image
''
''Notes:
''At this time all GIF images width must be a multiple of 2 to load properly
''
''Parameters:
''fn - the file name of the GIF image
''num_imgs - returns the number of images
''
''Returns:
''<ext.gfx.Image> ptr array containing the images, delete with delete[] when done
''
declare function loadAll( byref fn as const string, byref num_imgs as uinteger ) as ext.gfx.Image ptr ptr

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
sub loadGIFdriver() constructor
    var loader = new GraphicsLoader
    loader->f = @load
    getDriver("gif",loader)
end sub
#endif

end namespace

#endif
#endif
#endif
