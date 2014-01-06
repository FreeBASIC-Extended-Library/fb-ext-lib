''File: stars.bas
''Description: Demonstration of vectors and matrices.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include once "ext/graphics.bi"
#include once "ext/math.bi"
#include once "crt/stdlib.bi"
#include once "fbgfx.bi"



using ext.math

Const as integer SCR_W = 640
Const as integer SCR_H = 480
Const as integer SCR_W2=SCR_W\2
Const as integer SCR_H2=SCR_H\2
Const as integer LENS = (SCR_W+SCR_H)\2

screenres SCR_W,SCR_H,32


Function vertex_sort Cdecl ( Byval elm1 As Any Ptr, Byval elm2 As Any Ptr ) As Integer
    Return Sgn( (Cptr(vec3f Ptr, elm2)->z) - (Cptr(vec3f Ptr, elm1)->z) )
End Function

dim as vec3f vert(5000), tvert( ubound(vert) )
 
'set up some test vertices
for i as integer = lbound(vert) to ubound(vert)
    vert(i) = type<vec3f>(-1000+rnd*2000,-1000+rnd*2000,-1000+rnd*2000)
    vert(i)*=1.45
next

    dim as vec3f posit, look
    dim as vec3f tposit
    dim as vec3f tlook 
    dim as vec3f up = vec3f(0,1,0) 
 
do
    if tposit.distance(posit)<100 then
        tposit = type<vec3f>(-1000+rnd*2000,-1000+rnd*2000,-1000+rnd*2000)
        tlook = type<vec3f>(-1000+rnd*2000,-1000+rnd*2000,-1000+rnd*2000)
    end if
    
    posit += (tposit-posit)/50.0
    look  += (tlook-look)/50.0
    
    dim as matrix m, m2
    m.LookAt( posit, look, up ) 
    
    for i as integer = lbound(vert) to ubound(vert)
        tvert(i) = vert(i)*m
    next
        
    'ext.quicksort( @tvert(0), ubound(tvert), SizeOf(vec3f), @vertex_sort )
    qsort( @tvert(0), ubound(tvert), sizeof(vec3f), @vertex_sort )

    screenlock
    line(0,0)-(SCR_W-1,SCR_H-1), 0, BF
    for i as integer = lbound(vert) to ubound(vert)
        dim as vec3f pnt = tvert(i)
        dim as single dist = pnt.z
        if dist > 0 then
            dim as single size = 20 - dist/80
            if size<0 then size = 0
            dim as integer col = 255-(dist/8)
            if col<0 then col = 0
            circle( SCR_W2 + (LENS * pnt.x/dist),  SCR_H2 - (LENS * pnt.y/dist) ), size, 0,,,,f
            circle step(0,0), size, RGB(col,col,0)
        end if    
    next
    
    screensync
    screenunlock
    
    sleep 1,1
loop until len(inkey)
