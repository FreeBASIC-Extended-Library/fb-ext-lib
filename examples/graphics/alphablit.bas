''File: alphablit.bas
''Description: Demonstration of ext.gfx.AlphaBlit function.
''
''Copyright (c) 2007-2024-2012 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING)

# include once "ext/graphics/image.bi"
# include once "ext/graphics/manip.bi"
#include once "fbgfx.bi"

using ext.gfx

const as integer scrX = 320, scrY = 240
screenres scrX, scrY, 32, ,FB.GFX_HIGH_PRIORITY
var back = new Image(100,100,rgba(10,100,10,255))
var fore = new Image(100,100,rgba(100,10,100,255))
dim as integer alpha


do
    alpha = 127.5 + 127.5 * sin(timer)
    screenlock
    cls
    back->Display scrX/2-back->width/2, scrY/2-back->height/2, PSET_
    AlphaBlit( 0, fore, (scrX/2-fore->width/2)+50*sin(timer*2.3), (scrY/2-fore->height/2.5)+50*cos(timer*2), alpha )
    locate 1,1
    print "additive alpha = " & alpha
    screensync
    screenunlock
    sleep 1,1

loop until multikey(FB.SC_ESCAPE)

delete back
delete fore
