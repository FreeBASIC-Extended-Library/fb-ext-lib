''File: intensify.bas
''Description: Demonstration of ext.gfx.Intensify function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics/image.bi"
# include once "ext/graphics/manip.bi"
# include once "fbgfx.bi"

using ext
screenres 320,240,32
var image = gfx.LoadImage("fbextlogo.jpg")

Do
    dim as integer intensity = 255*sin(timer)
    screenlock
        cls
        gfx.Intensify( 0, image, 160-image->width\2, 120-image->height\2, intensity )
        screensync
    screenunlock
    sleep 1,1
Loop until multikey(FB.SC_ESCAPE)
