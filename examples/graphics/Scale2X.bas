''File: Scale2X.bas
''Description: Demonstration of ext.gfx.Scale2X function.
''
''Copyright (c) 2007 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics.bi"
# include once "fbgfx.bi"

screenres 640, 480, 32

dim as FB.IMAGE ptr original = ext.LoadImage("fbextlogo.jpg")

put(0,0),original, pset
ext.gfx.Scale2X( 0, original, original->width, 0 )

sleep
