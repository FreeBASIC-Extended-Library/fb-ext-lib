''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# pragma once
#ifndef FBEXT_GFX__BI__
#define FBEXT_GFX__BI__ -1

#include once "fbgfx.bi"

#include once "ext/graphics/font.bi"
#include once "ext/graphics/colors.bi"
#include once "ext/graphics/bmp.bi"
#include once "ext/graphics/manip.bi"
#include once "ext/graphics/collision.bi"
#include once "ext/graphics/sprite.bi"
#include once "ext/graphics/primitives.bi"
#include once "ext/graphics/image.bi"
#include once "ext/graphics/tga.bi"
#include once "ext/graphics/xpm.bi"


#ifndef FBEXT_NO_EXTERNAL_LIBS

    #include once "ext/graphics/jpg.bi"
    #include once "ext/graphics/png.bi"
    #include once "ext/graphics/gif.bi"

#endif

#Include Once "ext/graphics/detail/common.bi"

#endif 'FBEXT_GFX__BI__
