''Title: graphics/tga.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Contains code contributed and copyright (c) 2007 yetifoot
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_TGA_BI__
#define FBEXT_GFX_TGA_BI__ -1

#include once "ext/file/file.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
#define FBEXT_BUILD_NO_GFX_LOADERS -1
#include once "ext/graphics/image.bi"
#undef FBEXT_BUILD_NO_GFX_LOADERS
#endif

''Namespace: ext.gfx.tga

namespace ext.gfx.tga

    ''type: FileHeader
    ''Provided for users wanting to write tga manipulation routines
    type FileHeader field = 1
        idlength        As Ubyte
        colourmaptype   As Ubyte
        datatypecode    As Ubyte
        colourmaporigin As Ushort
        colourmaplength As Ushort
        colourmapdepth  As Ubyte
        x_origin        As Ushort
        y_origin        As Ushort
        Width           As Ushort
        height          As Ushort
        bitsperpixel    As Ubyte
        imagedescriptor As Ubyte
    end type

''Function: load
''Loads a Targa Bitmap Image file.
''
''Parameters:
''filename - the tga image to load.
''
''Returns:
''<ext.gfx.Image> Pointer to tga image in memory.
''
    declare Function load ( byref hFile as ext.File, byval t as target_e = TARGET_FBNEW ) As ext.gfx.Image Ptr

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
sub loadTGAdriver() constructor
    var loader = new GraphicsLoader
    loader->f = @load
    getDriver("tga",loader)
end sub
#endif

end namespace 'ext.gfx.tga

#endif 'FBEXT_GFX_TGA_BI__
