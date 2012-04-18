''File: rotate.bas
''Description: Demonstration of ext.gfx.Rotate function.
''
''Copyright (c) 2007-2012 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics/img_load.bi"
# include once "ext/graphics/manip.bi"
# include once "fbgfx.bi"

using ext

screenres 320, 240, 32

dim as FB.IMAGE ptr original = LoadImage("fbextlogo.jpg")

var angle = 0

do while not multikey(FB.SC_ESCAPE)

    screenlock
    cls
    gfx.Rotate(0, original, 160-original->width\2, 120-original->height\2, angle)
    screenunlock

    if multikey(FB.SC_RIGHT) then angle -= 5
    if multikey(FB.SC_LEFT) then angle += 5
    if multikey(FB.SC_UP) then angle = 0
    if multikey(FB.SC_DOWN) then angle = 180

    if angle < 0 then angle = 360 + angle
    if angle > 360 then angle = (angle - 360)

    sleep 5,1

loop
