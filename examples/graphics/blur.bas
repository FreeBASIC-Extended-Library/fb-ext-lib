''File: blur.bas
''Description: Demonstration of ext.gfx.Blur function.
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

screenres 320,240,32

'test 1, blur the same image.
dim as FB.IMAGE ptr test1 = gfx.LoadImage("fbextlogo.jpg")

put(160-test1->width\2,120-test1->height\2),test1,pset

sleep 1000

cls

for i as integer = 1 to 256

    gfx.blur( test1, test1, 1 )

    put(i,120-test1->height\2),test1,pset

next


'test 2, blur using 2 different buffers.
dim as FB.IMAGE ptr test2 = gfx.LoadImage("fbextlogo.jpg")

dim as single amt

for i as integer = 0 to 360

    amt = (i*5)*ext.math.pi_180

    gfx.blur(test1, test2, 1.5+1.5*sin(amt))

    put(160-test1->width\2,120-test1->height\2), test1, pset

next


print "Finished!"
sleep
