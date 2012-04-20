''Title: graphics/tga.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''Contains code contributed and copyright (c) 2007 yetifoot
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_TGA_BI__
#define FBEXT_GFX_TGA_BI__ -1

#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

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
''Pointer to tga image in memory.
''
    declare Function load ( byref filename As const String, byval t as target_e ) As any Ptr

declare function load_mem( byval src as any ptr, byval src_len as SizeType, byval t as target_e ) as any ptr

sub loadTGAdriver() constructor
    dim loader as GraphicsLoader
    loader.f = @load
    loader.fmem = @load_mem
    getDriver("tga",@loader)
end sub

end namespace 'ext.gfx.tga

#endif 'FBEXT_GFX_TGA_BI__
