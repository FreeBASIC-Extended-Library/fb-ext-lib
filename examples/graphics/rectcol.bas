''File: rectcol.bas
''Description: Demonstration of rectangular collision and math.RndRange functions.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/graphics/collision.bi"
# include once "ext/math/random.bi"
# include once "fbgfx.bi"

dim as FB.IMAGE ptr myimg1, myimg2

screenres 640,480,32
randomize timer

myimg1 = imagecreate(100,100)
myimg2 = imagecreate(100,100)
do while not multikey(FB.SC_ESCAPE)
    var rndx1 = ext.math.RndRange(1,640)
    var rndx2 = ext.math.RndRange(1,640)
    var rndy1 = ext.math.RndRange(1,480)
    var rndy2 = ext.math.RndRange(1,480)

    line (rndx1, rndy1) - (rndx1 + 100, rndy1 + 100), &hFF0000, BF
    line (rndx2, rndy2) - (rndx2 + 100, rndy2 + 100), &h00FF00, BF

    print "0 means no collision, -1 collision"
    print "img1: " & rndx1 & "," & rndy1
    print "img2: " & rndx2 & "," & rndy2
    print ext.gfx.collision_rect(myimg1, rndx1, rndy1, myimg2, rndx2, rndy2)
    print
    print "Any key to continue, ESC to quit"
    sleep
    cls
loop

imagedestroy(myimg1)
imagedestroy(myimg2)

