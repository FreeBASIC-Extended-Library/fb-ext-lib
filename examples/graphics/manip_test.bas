''File: manip_test.bas
''Description: Demonstration of ext.gfx.change_color function.
''
''Copyright (c) 2007-2012 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics/manip.bi"
# include once "fbgfx.bi"

using ext

screenres 320,240,32

dim as FB.IMAGE ptr myimg

'create a 100x100 box and fill it with pink with full alpha
myimg = imagecreate(100,100, &hFFFF00FF)

print "Original image:"
put (1,10),myimg, PSET

sleep

'change pink to yellow, keeping the original alpha and treating it like a font buffer
gfx.change_color( myimg, &hFF00FF, &hFFF00F, false, true )

cls
print "New image:"
put (1,10),myimg, PSET

sleep

imagedestroy(myimg)
