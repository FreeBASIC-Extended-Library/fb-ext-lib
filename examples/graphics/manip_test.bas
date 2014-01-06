''File: manip_test.bas
''Description: Demonstration of ext.gfx.change_color function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics/manip.bi"

using ext.gfx
screenres 320,240,32

'create a 100x100 box and fill it with pink with full alpha
var myimg = new image(100,100, &hFFFF00FF)

print "Original image:"
myimg->Display 1, 10, PSET_
sleep

'change pink to yellow, keeping the original alpha and treating it like a font buffer
changeColor( myimg, &hFF00FF, &hFFF00F, ext.false, ext.true )

cls
print "New image:"
myimg->Display 1, 10, PSET_
sleep

delete myimg
