''Title: graphics/png.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Contains code contributed and copyright (c) 2007 yetifoot
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef _PNG_LOAD_BI_
#define _PNG_LOAD_BI_

#ifndef FBEXT_NO_EXTERNAL_LIBS
#ifndef FBEXT_NO_LIBZ

#include once "ext/detail/common.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

#Ifndef FBEXT_USE_ZLIB_DLL
#Ifdef __FB_WIN32__
    #inclib "ext-z-win32"
#Else
    #Inclib "z"
#EndIf
#Else
    #Inclib "z"
#endif


#ifndef FBEXT_BUILD_NO_GFX_LOADERS
#define FBEXT_BUILD_NO_GFX_LOADERS -1
#include once "ext/graphics/image.bi"
#undef FBEXT_BUILD_NO_GFX_LOADERS
#else
#include once "ext/graphics/image.bi"
#endif

''Namespace: ext.gfx.png

namespace ext.gfx.png

''Type: gl_img
''Contains height and width data for a image loaded for OpenGL by png.load
type gl_img
    as uinteger width, height
end type

''Function: load
''Loads a png file.
''
''Parameters:
''filename - the png image to load.
''target - (optional) the target from target_e to load to, defaults to New FB style Image buffer
''
''Returns:
''<ext.gfx.Image> Pointer to png image in memory.
''
declare function load _
    ( _
        byref filename as const string, _
        byval target   as target_e = TARGET_FBNEW _
    ) as ext.gfx.Image ptr

''Function: load_mem
''Loads a png file that has been located in memory.
''
''Parameters:
''buffer - pointer to memory buffer holding the file.
''buffer_len - the length of the buffer.
''target - the target from target_e to load to.
''
''Returns:
''<ext.gfx.Image> Pointer to png image in memory.
''
declare function load_mem _
    ( _
        byval buffer     as any ptr, _
        byval buffer_len as SizeType, _
        byval target     as target_e _
    ) as ext.gfx.Image ptr

''Function: save
''Saves a png image from a memory buffer.
''
''Parameters:
''filename - the file to save as.
''img - the FBGFX buffer to save.
''
''Returns:
''Success.
''
declare function save cdecl alias "png_save" _
    ( _
        byref filename as const string, _
        byval img      as const FB.IMAGE ptr _
    ) as integer

#ifndef FBEXT_BUILD_NO_GFX_LOADERS
sub loadPNGdriver() constructor
    var loader = new GraphicsLoader
    loader->f = @load
    loader->fmem = @load_mem
    getDriver("png",loader)
end sub
#endif ' FBEXT_BUILD_NO_GFX_LOADERS

end namespace 'ext.gfx.png

#endif 'FBEXT_NO_LIBZ
#endif 'FBEXT_NO_EXTERNAL_LIBS

#endif '_PNG_LOAD_BI_
