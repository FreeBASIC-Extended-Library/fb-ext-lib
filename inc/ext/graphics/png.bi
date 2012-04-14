''Title: graphics/png.bi
''
''About: License
''Copyright (c) 2007-2011, FreeBASIC Extended Library Development Group
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

''Namespace: ext.gfx.png

namespace ext.gfx.png

''Enum: target_e
''Contains the valid destinations/locations for the png image.
''
''TARGET_BAD - invalid
''
''TARGET_FBNEW - use the new (.17 and up) style graphics buffer.
''
''TARGET_OPENGL - use an OpenGL compatible buffer.
''
enum target_e
	TARGET_BAD
	TARGET_FBNEW
	TARGET_OPENGL
end enum

''Function: load
''Loads a png file.
''
''Parameters:
''filename - the png image to load.
''target - (optional) the target from target_e to load to, defaults to New FB style Image buffer
''
''Returns:
''Pointer to png image in memory.
''
''Notes:
''When destroying an image created with TARGET_OPENGL you must use deallocate, not imagedestroy.
''
declare function load cdecl alias "png_load" _
	( _
		byref filename as const string, _
		byval target   as target_e = TARGET_FBNEW _
	) as any ptr

''Function: load_mem
''Loads a png file that has been located in memory.
''
''Parameters:
''buffer - pointer to memory buffer holding the file.
''buffer_len - the length of the buffer.
''target - the target from target_e to load to.
''
''Returns:
''Pointer to png image in memory.
''
declare function load_mem cdecl alias "png_load_mem" _
	( _
		byval buffer     as any ptr, _
		byval buffer_len as integer, _
		byval target     as target_e _
	) as any ptr

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

''Sub: dimensions
''Gets the dimensions of a png image without loading it.
''
''Parameters:
''filename - the file to get the dimensions of.
''w - will contain the width of the image.
''h - will contain the height of the image.
''
declare sub dimensions cdecl alias "png_dimensions" _
	( _
		byref filename as const string, _
		byref w        as uinteger, _
		byref h        as uinteger _
	)

''Sub: dimensions_mem
''Gets the dimensions of a png file loaded in memory.
''
''Parameters:
''buffer - pointer to the memory buffer holding the file.
''w - will contain the width.
''h - will contain the height.
''
declare sub dimensions_mem cdecl alias "png_dimensions_mem" _
	( _
		byval buffer as const any ptr, _
		byref w      as uinteger, _
		byref h      as uinteger _
	)
end namespace 'ext.gfx.png

#endif 'FBEXT_NO_LIBZ
#endif 'FBEXT_NO_EXTERNAL_LIBS

#endif '_PNG_LOAD_BI_
