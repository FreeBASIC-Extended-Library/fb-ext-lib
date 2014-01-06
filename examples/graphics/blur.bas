''File: blur.bas
''Description: Demonstration of ext.gfx.Blur function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics/image.bi"
# include once "ext/graphics/manip.bi"
# include once "fbgfx.bi"

using ext.gfx
screenres 320,240,32

'test 1, blur the same image.
var test1 = LoadImage("fbextlogo.jpg")
test1->Display 160-test1->width\2,120-test1->height\2, PSET_

sleep 1000
cls

for i as integer = 1 to 256
    blur( test1, test1, 1 )
    test1->Display i,120-test1->height\2, PSET_
next

'test 2, blur using 2 different buffers.
var test2 = LoadImage("fbextlogo.jpg")
dim as single amt

for i as integer = 0 to 360
    amt = (i*5)*ext.math.pi_180
    blur(test1, test2, 1.5+1.5*sin(amt))
    test1->Display 160-test1->width\2, 120-test1->height\2, PSET_
next

delete test1
delete test2

print "Finished!"
sleep
