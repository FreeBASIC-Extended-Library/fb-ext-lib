''File: triangle.bas
''Description: Demonstration of flat shaded triangle drawing function.
''
''Copyright (c) 2007 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include once "ext/graphics.bi"

screenres 320,240,32
dim as FB.IMAGE ptr tbuffer = imagecreate(320,240)

do  
    screenlock
    ext.gfx.Triangle( tbuffer, rnd*320, rnd*240, rnd*320, rnd*240, rnd*320, rnd*240, rgba(rnd*255, rnd*255, rnd*255, rnd*255) )
    put(0,0),tbuffer,trans

    ext.gfx.Triangle( 0, rnd*320, rnd*240, rnd*320, rnd*240, rnd*320, rnd*240, rgba(rnd*255, rnd*255, rnd*255, 0) )
    screenunlock
    sleep 1,1
loop until len(inkey)

