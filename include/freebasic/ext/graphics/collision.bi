''Title: graphics/collision.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_COLLISION_BI__
#define FBEXT_GFX_COLLISION_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/graphics/detail/common.bi"
#include once "fbgfx.bi"

''Namespace: ext.gfx

namespace ext.gfx

''Function: collision_rect
''Quickly determine if two FB.IMAGEs overlap or collide.
''
''Parameters:
''img1 - the first image.
''x1 - the x coordinate of the first image.
''y1 - the y coordinate of the first image.
''img2 - the second image.
''x2 - the x coordinate of the second image.
''y2 - the y coordinate of the second image.
''
''Returns:
''ext.bool value, false means no collision, true is collision
''
declare function collision_rect ( _
        byval img1 as const FB.IMAGE ptr, _
        byval x1 as integer, _
        byval y1 as integer, _
        byval img2 as const FB.IMAGE ptr, _
        byval x2 as integer, _
        byval y2 as integer _
) as ext.bool

end namespace 'ext.gfx

#endif
