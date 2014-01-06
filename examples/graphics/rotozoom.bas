''File: rotozoom.bas
''Description: Demonstration of ext.gfx.RotoZoom function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics/image.bi"
# include once "ext/graphics/manip.bi"

using ext

screenres 640, 480, 32

var original = gfx.LoadImage("fbextlogo.jpg")

var angle = 0
var zoom = 1f
var method = 0

do while not multikey(FB.SC_ESCAPE)

    screenlock
    cls
    select case as const method
        case 0
            gfx.RotoZoom(0, original, 320, 240,angle, zoom, zoom)
            locate 1,1
            print "Normal"
        case else
            gfx.RotoZoomASM(0, original, 320, 240,angle, zoom, zoom)
            locate 1,1
            print "ASM"
    end select
    screenunlock

    if multikey(FB.SC_SPACE) then
        method = not method
        sleep 150,1
    end if

    if multikey(FB.SC_RIGHT) then angle -= 5
    if multikey(FB.SC_LEFT) then angle += 5
    if multikey(FB.SC_UP) then zoom += .1
    if multikey(FB.SC_DOWN) then zoom-=.1
    if zoom<0 then zoom = 0

    if angle < 0 then angle = 360 + angle
    if angle > 360 then angle = (angle - 360)

    sleep 5,1

loop

delete original
