' Demonstrates some simple vector usage by creating a grid of lines that are
' either attracted or repelled by the mouse cursor. The strength of the force
' applied is controlled by the mouse-wheel.

# include once "ext/math/vector2.bi"
# include once "fbgfx.bi" ' for multikey scancodes

# define CLAMP( n_, low_, high_) _
    iif( (n_) < (low_), (low_), _
    iif( (high_) < (n_), (high_), _
         (n_)))

type Vector as ext.math.fbext_Vector2( ((double)) )

const hScreenSize as uinteger = 800
const vScreenSize as uinteger = 600

const hGridSize as uinteger = 40
const vGridSize as uinteger = 30

dim particles(0 to hGridSize - 1, 0 to vGridSize - 1) as Vector

' setup the particle grid
for j as integer = 0 to vGridSize - 1
for i as integer = 0 to hGridSize - 1
    var x = hScreenSize * ( i / hGridSize )
    var y = vScreenSize * ( j / vGridSize )
    particles( i, j ) = Vector( x, y )
next i, j

screenres hScreenSize, vScreenSize, 32

do
    var mousex = 0, mousey = 0, mousew = 0
    getmouse mousex, mousey, mousew
    
    var mousePosition = Vector( mousex, mousey )
    
    screenlock
    cls
    
    ' calculate the pull on each particle.
    for j as integer = 0 to vGridSize - 1
    for i as integer = 0 to hGridSize - 1
    
        var p = @particles(i, j)
        
        var OM = mousePosition - *p
        var d = OM.Magnitude()
        
        ' pull is proportional to the mousewheel number and inversely
        ' proportional to the square of the distance of the mouse cursor, and
        ' has a range of [-10.0, 10.0].
        var pullForce = ( sgn(mousew) * 2000.0 * (2.0 ^ (abs(mousew) / 4.0)) ) _
                      / ( d ^ 2.0 )
        pullForce = CLAMP( pullForce, -10.0, 10.0 )
        
        ' the particle is pulled toward (or pushed away from) the mouse cursor.
        var pullPosition = *p + OM.Normal() * pullForce
        
        ' the stronger the pull (or push), the whiter the color.
        var particleColor = RGB( abs(pullForce) / 10.0 * 255.0, _
                                 abs(pullForce) / 10.0 * 255.0, _
                                 abs(pullForce) / 10.0 * 255.0 )
        
        line (p->x, p->y) _
            -(pullPosition.x, pullPosition.y), particleColor
        
    next i, j
    
    locate 1, 1
    print "Use the scroll-wheel to adjust force. Forward increases the"
    print "attractive force, while backward increases the repelling force."
    
    screenunlock
    
    sleep 2, 1

loop until multikey( fb.SC_ESCAPE )
