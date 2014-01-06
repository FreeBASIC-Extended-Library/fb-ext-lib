''Title: graphics/bmp.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_BMP_BI__
#define FBEXT_GFX_BMP_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"


#ifndef FBEXT_BUILD_NO_GFX_LOADERS
#define FBEXT_BUILD_NO_GFX_LOADERS -1
#include once "ext/graphics/image.bi"
#undef FBEXT_BUILD_NO_GFX_LOADERS
#endif

''Namespace: ext.gfx.bmp

namespace ext.gfx.bmp

    ''type: FileHeader
    ''Provided for users wanting to write bmp manipulation routines
    type FileHeader field = 1
        as ushort       mark
        as uinteger     size
        As ushort       res1, res2
        As uinteger     offset
    end type

    ''type: InfoHeader
    ''Provided for users wanting to write bmp manipulation routines
    type InfoHeader field = 1
        as uinteger     size
        As integer      w, h
        As short        planes, bitCount
        As uinteger     compression, sizeImage
        As integer      ppmX, ppmY
        As uinteger     used, important
    end type

    ''type: bmp_header
    ''Provided for users wanting to write bmp manipulation routines
    type bmp_header field = 1
        As FileHeader   bmfh
        As InfoHeader   bmih
    end type

    ''Function: load
    ''Attempts to load a bitmap to an <ext.gfx.Image>.
    ''
    ''Parameters:
    ''filename - the bitmap file to load.
    ''
    ''Returns:
    ''Pointer to <ext.gfx.Image> or null.
    ''
    declare Function load ( byref filename As const String, byval t as target_e = TARGET_FBNEW ) As ext.gfx.Image Ptr

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
    sub loadBMPdriver() constructor
    var loader = new GraphicsLoader
    loader->f = @load
    getDriver("bmp",loader)
end sub
#endif

end Namespace 'ext.gfx.bmp

#endif 'FBEXT_GFX_BMP_BI__
