''Title: graphics/xpm.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_XPM_BI__
#define FBEXT_GFX_XPM_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/file/file.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
#define FBEXT_BUILD_NO_GFX_LOADERS -1
#include once "ext/graphics/image.bi"
#undef FBEXT_BUILD_NO_GFX_LOADERS
#endif

''Namespace: ext.gfx.xpm
namespace ext.gfx.xpm

''Function: load
''Load a version 1 XPM image.
''
''Parameters:
''fn - File object pointing to file or buffer containing XPM image.
''
''Returns:
''<ext.gfx.Image> ptr on success or NULL on error
declare function load ( byref fn as File ) as Image ptr

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
sub loadXPMdriver() constructor
    var loader = new GraphicsLoader
    loader->f = @load
    getDriver("xpm",loader)
end sub
#endif

end namespace

#endif
