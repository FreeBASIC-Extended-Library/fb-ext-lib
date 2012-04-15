' Demonstrates applying forces and reflecting objects by placing particles
' around a large force-producing yin yang. The black hemicircle of the yin yang
' attracts white particles and repels black particles; the reverse is true for
' the white hemicircle. This is an analogy of the north and south poles of a
' magnet.

# include once "ext/math/vector2.bi"
# include once "ext/math/line2.bi"
# include once "ext/math/reflections.bi"
# include once "fbgfx.bi" ' for MultiKey scan codes

type Vector as ext.math.fbext_Vector2( ((double)) )
type LineType as ext.math.fbext_Line2( ((double)) )

type Particle
    position as Vector
    velocity as Vector
    isWhite as ext.bool
    
    isDead as ext.bool
    isAbsorbing as ext.bool
end type

declare sub CheckForCollisionWithScreenEdge ( byref p as Particle )

const hScreenSize as uinteger = 800
const vScreenSize as uinteger = 600

const yinYangRadius as double = 100.0
const yinYangForce as double = 1000000.0

const particleCount as uinteger = 40
const particleRadius as double = 5.0

dim particles(1 to particleCount) as Particle


var yinYang = Particle
yinYang.position = Vector( hScreenSize / 2.0, vScreenSize / 2.0 )

' randomize particle positions.
for i as uinteger = lbound(particles) to ubound(particles)
    particles(i).isWhite = ( i/2.0 = int( i/2.0 ) )
    
    var p = @particles(i).position
    p->x = hScreenSize * rnd
    p->y = vScreenSize * rnd
    
    ' make sure no particles are within the yin-yang.
    do while p->Magnitude() < yinYangRadius + particleRadius
        p->x = hScreenSize * rnd
        p->y = vScreenSize * rnd
    loop
next i

' put (0, 0) at the bottom-left corner of the screen.
screenres hScreenSize, vScreenSize, 32
window (0.0, 0.0) - (hScreenSize, vScreenSize)

var ticEndTime = timer

do
    ' update time information.
    var ticStartTime = timer
    var secsSinceLastTic = ticStartTime - ticEndTime
    
    var mousex = 0, mousey = 0
    getmouse( mousex, mousey )
    
    ' convert screen coordinates to window coordinates.
    var mousePosition = Vector( mousex, vScreenSize - mousey )
    
    screenlock
    cls
    locate 1, 1 : print "FPS: " & int( 1 / secsSinceLastTic )
    
    ' draw yinyang.
    var YYM = mousePosition - yinYang.Position
    var YYMRight = Vector( YYM.y, -YYM.x )
    
    var theta = atan2( YYMRight.y, YYMRight.x )
    if theta < 0 then theta = ext.math.pi2 + theta
    
    YYMRight.Normalize()
    circle ( yinYang.Position.x, yinYang.Position.y ), yinYangRadius, RGB( 255, 255, 255 )
    
    var blackArcPosition = yinYang.Position + YYMRight * yinYangRadius/2.0
    circle ( blackArcPosition.x, blackArcPosition.y ), yinYangRadius/2.0, RGB( 255, 255, 255 ), theta, theta + ext.math.pi
    circle ( blackArcPosition.x, blackArcPosition.y ), yinYangRadius/8.0, RGB( 255, 255, 255 ),,,,F
    
    var whiteArcPosition = yinYang.Position + -YYMRight * yinYangRadius/2.0
    circle ( whiteArcPosition.x, whiteArcPosition.y ), yinYangRadius/2.0, RGB( 255, 255, 255 ), theta + ext.math.pi, theta + ext.math.pi2
    circle ( whiteArcPosition.x, whiteArcPosition.y ), yinYangRadius/8.0, RGB( 255, 255, 255 )
    
    var paintPosition = yinYang.Position + -YYMRight * yinYangRadius/16.0
    paint ( paintPosition.x, paintPosition.y ), RGB( 255, 255, 255 )
    
    ' update and draw particles.
    for i as uinteger = lbound(particles) to ubound(particles)
        var position = @particles(i).position
        var velocity = @particles(i).velocity
        var isWhite = particles(i).isWhite
        
        ' yinyang -> particle
        var YYP = *position - yinYang.position
        
        ' force is inversely proportional to the square of the distance of the
        ' particle, and proportional to the angle from the equator.
        var force = yinYangForce / ( YYP.Magnitude() ^ 2 )
        
        var angle = acos( YYP.Normal().Dot( YYM.Normal() ) )
        
        ' facing the black hemicircle ? attract particles.
        if angle >= ext.math.pi_2 then
            angle -= ext.math.pi_2
            force *= -( angle / ext.math.pi_2 )
        ' facing the white hemicircle; repel particles.
        else
            force *= 1 - angle / ext.math.pi_2
        end if
        
        ' adjust velocity for yinyang force, and move particle.
        *velocity += YYP.Normal() * iif( isWhite, force, -force )
        *position += *velocity * secsSinceLastTic
        
        CheckForCollisionWithScreenEdge( particles(i) )
        
        YYP = *position - yinYang.position
        
        ' check for collision with yinyang..
        var edgeDistance = YYP.Magnitude() - ( particleRadius + yinYangRadius )
        if edgeDistance < 0 then
            var YYPNormal = YYP.Normal()
            var tangent = Vector( YYPNormal.y, -YYPNormal.x )
            *position = yinYang.position + YYPNormal * ( particleRadius + yinYangRadius )
            *velocity = ext.math.GetReflectedVector( *velocity, tangent ) * 0.80
        end if
        
        if isWhite then
            circle ( position->x, position->y ), particleRadius, RGB( 255, 255, 255 ),,,,F
        else
            circle ( position->x, position->y ), particleRadius, RGB( 255, 255, 255 )
        end if
    
    next i
    
    screenunlock
    
    ticEndTime = timer
    sleep 1, 1

loop until multikey( fb.SC_ESCAPE )

'' :::::
sub CheckForCollisionWithScreenEdge ( byref p as Particle )

    using ext.math
    
    ' left side of screen ?
    if p.position.x - particleRadius < 0 then
        p.position.x = particleRadius
        p.velocity = -GetReflectedVector( p.velocity, Vector( 1.0, 0.0 ) )
    ' right side of screen ?
    elseif hScreenSize < p.position.x + particleRadius then
        p.position.x = hScreenSize - particleRadius
        p.velocity = -GetReflectedVector( p.velocity, Vector( -1.0, 0.0 ) )
    end if
    
    ' bottom of screen ?
    if p.position.y - particleRadius < 0 then
        p.position.y = particleRadius
        p.velocity = -GetReflectedVector( p.velocity, Vector( 0.0, 1.0 ) )
    ' top of screen ?
    elseif vScreenSize < p.position.y + particleRadius then
        p.position.y = vScreenSize - particleRadius
        p.velocity = -GetReflectedVector( p.velocity, Vector( 0.0, -1.0 ) )
    end if

end sub
