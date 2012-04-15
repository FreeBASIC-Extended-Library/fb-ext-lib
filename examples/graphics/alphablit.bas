
''File: blur.bas
''Description: Demonstration of ext.gfx.Blur function.
''
''Copyright (c) 2007 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)
''lol use rotozoom :)

# include once "ext/graphics.bi"
# include once "fbgfx.bi"

const as integer scrX = 320, scrY = 240

screenres scrX, scrY, 32, ,FB.GFX_HIGH_PRIORITY

dim as FB.image ptr back = ext.LoadImage("fbextlogo.jpg")

dim as FB.IMAGE ptr fore = ext.LoadImage("test.png")

dim as integer alpha


do
    
    alpha = 127.5 + 127.5 * sin(timer)

    screenlock

    cls
    
    put( scrX/2-back->width/2, scrY/2-back->height/2 ), back, pset
    
    ext.gfx.AlphaBlit( 0, fore, (scrX/2-fore->width/2)+50*sin(timer*2.3), (scrY/2-fore->height/2.5)+50*cos(timer*2), alpha )

    locate 1,1

    print "additive alpha = " & alpha

    screensync
    
    screenunlock
    
    sleep 1,1
    
loop until multikey(FB.SC_ESCAPE)
