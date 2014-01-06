''File: sphere-line-collision.bas
''Description: Demonstration of 2d circle to line collision
'' detection and response using the ext.math.vector*d library.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/math.bi"
# include once "fbgfx.bi"

using ext.math

declare function cPointline( byref vA as vec2f, byref vB as vec2f, byref vPoint as vec2f ) as vec2f 

screenres 640,480,8,,FB.GFX_HIGH_PRIORITY

dim as integer num_verts
dim as single radius = 30, tDist, mSpeed = 50
dim as double tTimer, fTime
dim as vec2f Lines()
var pl = vec2f(320,240)
dim as vec2f pld, cent, ero

read Num_Verts 
redim Lines(num_verts)
for i as integer = 0 to ubound(Lines) 
    read Lines(i).X, Lines(i).Y 
next 


tTimer = Timer

do

    fTime = Timer - tTimer
    tTimer = Timer
    
    dim as single trans_speed = mSpeed*fTime

    if multikey(FB.SC_LEFT) then
        pld.x -= trans_speed
    end if

    if multikey(FB.SC_RIGHT) then
        pld.x += trans_speed
    end if

    if multikey(FB.SC_UP) then
        pld.y -= trans_speed
    end if

    if multikey(FB.SC_DOWN) then
        pld.y += trans_speed
    end if
    
    pld -= (pld/10f)
    pl += pld
    
    screenlock
    line(0,0)-(639,479),0,bf
    for i as integer = 0 to ubound(Lines)-1 step 2
        var j = i+1
        cent = Lines(i).Cross(Lines(j))
        Ero = cPointline( Lines(i), Lines(j), pl ) 
        tDist = Pl.Distance( Ero )
        
        if tDist < Radius then 
            pl  += (cent*(radius-tDist))
            pld += (cent*(radius-tDist))
        end if
        
        line(Lines(i).X, Lines(i).Y)-(Lines(j).X, Lines(j).Y),14 
        line(Ero.X, Ero.Y)-(Ero.X + (Cent.X*Radius), Ero.Y + (Cent.Y*Radius)),7 
    next
    
    circle (Pl.X,Pl.Y),Radius, 1 
    pset (Pl.X,Pl.Y), 4
 
    screensync
    screenunlock
    
    sleep 4,1

loop until multikey(FB.SC_ESCAPE)


function cPointline( byref vA as vec2f, byref vB as vec2f, byref vPoint as vec2f ) as vec2f 
    
    dim as vec2f tVector1
    dim as vec2f tVector2
    dim as vec2f vReturn
    dim as single d
    dim as single t
    
    tVector1 = vPoint - vA
    tVector2 = vB-vA
    tVector2.Normalize
    
    d = vA.Distance(vB)
    t = tVector2.Dot(tVector1)
    
    if t<=0 then return vA 
    
    if t>=d then return vB
    
    return vA + (tVector2*t)
    
end function


data 21 

data 10,15 
data 10,240 

data 10,240 
data 100,340 

data 100,340 
data 125,400 

data 125,400 
data 300,450 

data 300,450 
data 450,470 

data 450,470 
data 600,370 

data 600,370 
data 550,300 

data 550,300 
data 625,250 

data 625,250 
data 500,0 

data 500,0 
data 320,50 

data 320,50 
data 10,15
