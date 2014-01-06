''Title: graphics/primitives.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_PRIMITIVES_BI__
#define FBEXT_GFX_PRIMITIVES_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/graphics/detail/common.bi"
#include once "ext/graphics/image.bi"
#include once "ext/math/vector2.bi"

namespace ext.gfx

    ''Sub: Triangle
    ''Draws a flat shaded triangle.
    ''
    ''Parameters:
    ''dst - <Image> buffer to draw on. Pass 0 to draw to the screen.
    ''x1 - x coordinate of first point of triangle.
    ''y1 - y coordinate of first point of triangle.
    ''x2 - x coordinate of second point of triangle.
    ''y2 - y coordinate of second point of triangle.
    ''x3 - x coordinate of third point of triangle.
    ''y3 - y coordinate of third point of triangle.
    ''col - the color of the triangle to be drawn, defaults to &hffffff (white).
    ''
    ''See Also:
    ''<Drawing a Triangle>
    ''
    declare sub Triangle overload ( byval dst as Image ptr = 0, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval x3 as integer, byval y3 as integer, byval col as uinteger = rgba(255,255,255,255) )


    ''Sub: Triangle
    ''Draws a flat shaded triangle.
    ''
    ''Parameters:
    ''dst - <Image> buffer to draw on. Pass 0 to draw to the screen.
    ''p1 - <Vector2> containing the x and y of the first point.
    ''p2 - <Vector2> containing the x and y of the second point.
    ''p3 - <Vector2> containing the x and y of the third point.
    ''col - the color of the triangle to be drawn, defaults to &hffffff (white).
    ''
    ''See Also:
    ''<Using the Vector2D class to simplify Triangle drawing>
    ''
    ''<vector2d>
    ''
    declare sub Triangle( byval dst as Image ptr = 0, byref p1 as ext.math.vec2i, byref p2 as ext.math.vec2i, byref p3 as ext.math.vec2i, byval col as uinteger = rgba(255,255,255,255) )

    ''Example: Drawing a Triangle
    ''(begin code)
    ''#include once "ext/graphics.bi"
    ''#include once "fbgfx.bi"
    ''
    ''screenres 320, 240, 32
    ''
    ''do while not multikey(FB.SC_ESCAPE)
    ''
    ''  screenlock
    ''
    ''  cls
    ''  ext.gfx.Triangle( , 1, 1, 1, 10, 10, 1, rgb(255,0,0) ) 'Draw a red triangle in the top left corner of the screen
    ''
    ''  screenunlock
    ''
    ''  sleep 5
    ''
    ''loop 'loop until the user pushes the ESC key
    ''(end code)
    ''

    ''Example: Using the Vector2D class to simplify Triangle drawing
    ''(begin code)
    ''#include once "ext/graphics.bi"
    ''#include once "fbgfx.bi"
    ''
    ''screenres 320, 240, 32
    ''
    ''dim as ext.math.Vector2D ptr Points
    ''
    ''Points = new ext.math.Vector2D[3]
    ''
    ''do while not multikey(FB.SC_ESCAPE)
    ''
    ''  for n as uinteger = 0 to 2
    ''      Points[n].x = ext.math.RndRange(1.0,319.0)
    ''      Points[n].y = ext.math.RndRange(1.0,319.0)
    ''  next
    ''
    ''  screenlock
    ''  cls
    ''  ext.gfx.Triangle( 0, Points[0], Points[1], Points[2], ext.math.RndRange(&h222222, &hFFFFFF) )
    ''  screenunlocek
    ''
    ''  sleep 100,1
    ''
    ''loop
    ''
    ''delete[] Points
    ''(end code)
    ''

    declare sub TriangleASM overload ( byval dst as Image ptr = 0, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval x3 as integer, byval y3 as integer, byval col as uinteger = rgba(255,255,255,255) )

    declare sub TriangleASM( byval dst as Image ptr = 0, byref p1 as ext.math.vec2i, byref p2 as ext.math.vec2i, byref p3 as ext.math.vec2i, byval col as uinteger = rgba(255,255,255,255) )

end namespace 'ext.gfx

#endif 'FBEXT_GFX_PRIMITIVES_BI__
