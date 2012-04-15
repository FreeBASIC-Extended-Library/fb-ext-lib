' Demonstrates checking for line segment intersection by sweeping a line
' around the center of the screen amidst a circular perimeter of lines.

# include once "ext/math/vector2.bi"
# include once "ext/math/line2.bi"
# include once "ext/math/intersects.bi"
# include once "fbgfx.bi" ' for MultiKey constants

' some type aliases to lighten the load.
type Vector as ext.math.fbext_Vector2( ((double)) )
type LineType as ext.math.fbext_Line2( ((double)) )

' builds an array of count number of perimeter lines in a circle, starting at
' index 1.
declare sub SetupLines ( lines() as LineType, byval count as uinteger )

const numLines as uinteger = 50
const sweepColor as uinteger = RGB( 255, 255, 0 )
const normalColor as uinteger = RGB( 255, 255, 255 )
const intersectedColor as uinteger = RGB( 0, 0, 255 )

randomize

dim lines() as LineType
SetupLines( lines(), numLines )

screenres 640, 480, 32

do
    ' sweep 1/2 radian per second (pi RPM).
    var theta = timer * 0.5
    var sweep = LineType( Vector( 320, 240 ), _
                          Vector( 320 + 125 *  cos(theta), _
                                  240 + 125 * -sin(theta) ) )
    
    screensync
    screenlock
    
    cls
    for i as integer = 1 to ubound(lines)
        var lineColor = normalColor
       
        if ext.math.Intersects( lines(i), sweep, sweep.b ) then
            lineColor = intersectedColor
        end if
       
        line (lines(i).a.x, lines(i).a.y) _
            -(lines(i).b.x, lines(i).b.y), lineColor
    next
    
    line (sweep.a.x, sweep.a.y) _
        -(sweep.b.x, sweep.b.y), sweepColor
    
    screenunlock
    flip
    
    sleep 1,1
loop until multikey(FB.SC_ESCAPE)

'' :::::
sub SetupLines ( lines() as LineType, byval count as uinteger )

    # macro GetVertex( theta_, v_ ) 
    scope
        var radius = 100.0 + rnd * 50.0
        
        v_ = Vector( 320 + radius * cos(theta_), 240 + radius * -sin(theta_) )
    end scope
    # endmacro
    
    redim lines( 1 to count ) as LineType
    
    var angleStep = ext.math.pi2 / count
    var angle = 0.0
    
    GetVertex( angle, lines(1).a )
    for i as integer = 1 to count - 1
        angle += angleStep
        GetVertex( angle, lines(i).b )
        lines(i+1).a = lines(i).b
    next i
    lines(count).b = lines(1).a

end sub
