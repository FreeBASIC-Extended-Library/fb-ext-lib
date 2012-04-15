''Title: graphics/img_load.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_IMGLOAD_BI__
#define FBEXT_GFX_IMGLOAD_BI__ -1

#include once "ext/detail/common.bi"
#include once "fbgfx.bi"

#ifndef FBEXT_NO_LIBZ
#ifndef FBEXT_NO_LIBJPG

#include once "ext/graphics/jpg.bi"
#include once "ext/graphics/bmp.bi"
#include once "ext/graphics/png.bi"
#include once "ext/graphics/tga.bi"

''Namespace: ext.gfx

namespace ext.gfx

    ''Function: LoadImage
    ''Loads a image file from disk to a FBGFX buffer.
    ''
    ''Supports TGA, JPG, BMP and PNG images.
    ''
    ''Parameters:
    ''filename - the file to load.
    ''
    ''Returns:
    ''Pointer to FBGFX buffer.
    ''
    declare function LoadImage ( byref filename as const string ) as FB.IMAGE ptr

end namespace

#endif 'NO_LIBJPG
#endif 'NO_LIBZ


#endif
