' Demonstrates drawing perpendicular lines using projections.

# include once "ext/math/line2.bi"
# include once "ext/math/projections.bi"
# include once "fbgfx.bi" ' for MultiKey constants

' some type aliases to lighten the load.
type Vector as ext.math.fbext_Vector2( ((double)) )
type LineType as ext.math.fbext_Line2( ((double)) )

' these lines surround the circle.
dim lines( 1 to 11 ) as LineType = { _
    LineType( Vector( 50,70 ),   Vector( 10,240 ) ),    _
    LineType( Vector( 10,240 ),  Vector( 100,340 ) ),   _
    LineType( Vector( 100,340 ), Vector( 125,400 ) ),   _
    LineType( Vector( 125,400 ), Vector( 300,450 ) ),   _
    LineType( Vector( 300,450 ), Vector( 450,470 ) ),   _
    LineType( Vector( 450,470 ), Vector( 600,370 ) ),   _
    LineType( Vector( 600,370 ), Vector( 550,300 ) ),   _
    LineType( Vector( 550,300 ), Vector( 625,250 ) ),   _
    LineType( Vector( 625,250 ), Vector( 500,10 ) ),    _
    LineType( Vector( 500,10 ),  Vector( 320,50 ) ),    _
    LineType( Vector( 320,50 ),  Vector( 50,70 ) )      _
}

dim scr as const Vector = Vector( 800, 600 )
dim radius as const double = 25.0

screenres scr.x, scr.y, 8

var velocity = Vector( 0.0, 0.0 )
var position = Vector( scr / 2.0 )

do
    ' adjust velocity per user input.
    if multikey(FB.SC_LEFT)  then velocity.x -= 0.15
    if multikey(FB.SC_RIGHT) then velocity.x += 0.15
    if multikey(FB.SC_UP)    then velocity.y -= 0.15
    if multikey(FB.SC_DOWN)  then velocity.y += 0.15
    
    ' adjust velocity, then move the circle.
    velocity *= 0.95
    position += velocity
    
    screenlock
    
    line (0,0)-(scr.x-1, scr.y-1), 0, bf
    
    for i as integer = 1 to ubound(lines)
        var AB = (lines(i).b - lines(i).a).Normal()
        var perpendicular = Vector( AB.y, -AB.x )
        
        var projectedPoint = ext.math.ClampProjectedPoint( lines(i), position )
        var distanceFromLine = ext.math.Distance( position, projectedPoint )
        
        ' adjust position so that circle stays within the lines.
        if distanceFromLine < radius then
            position += perpendicular * ( radius - distanceFromLine )
        end if
        
        ' draw the line.
        line (lines(i).a.x, lines(i).a.y) _
            -(lines(i).b.x, lines(i).b.y), 14
        
        ' draw from the projected point perpendicular to the line.
        var a = projectedPoint
        var b = a + perpendicular * radius
        line (a.x, a.y)-(b.x, b.y), 7
    next i
    
    circle (position.x,position.y),radius, 14
    pset (position.x,position.y), 4
    
    screensync
    screenunlock
    
    sleep 2,1

loop until multikey(FB.SC_ESCAPE)
