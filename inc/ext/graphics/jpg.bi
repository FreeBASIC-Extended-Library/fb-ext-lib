''Title: graphics/jpg.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_JPG_BI__
#define FBEXT_GFX_JPG_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

#ifndef FBEXT_NO_EXTERNAL_LIBS
#ifndef FBEXT_NO_LIBJPG

#inclib "jpeg"

''Namespace: ext.gfx.jpg
namespace ext.gfx.jpg

''Function: load
''Loads a JPEG image to an <ext.gfx.Image>.
''
''Parameters:
''filename - the file to load.
''
''Returns:
''<ext.gfx.Image> ptr containing the jpg data. Does not work with grayscale images at this time.
''
declare function load ( byref filename as const string, byval t as target_e ) as any ptr

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
sub loadJPGdriver() constructor
    dim loader as GraphicsLoader
    loader.f = @load
    getDriver("jpg",@loader)
end sub
#endif

end namespace

#endif
#endif

#endif
