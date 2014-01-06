''File: triangle.bas
''Description: Demonstration of flat shaded triangle drawing function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include once "ext/graphics/primitives.bi"
using ext.gfx

screenres 320,240,32
var tbuffer = new image(320,240)

do
    screenlock
    Triangle( tbuffer, rnd*320, rnd*240, rnd*320, rnd*240, rnd*320, rnd*240, rgba(rnd*255, rnd*255, rnd*255, rnd*255) )
    tbuffer->Display 0, 0,trans_

    Triangle( 0, rnd*320, rnd*240, rnd*320, rnd*240, rnd*320, rnd*240, rgba(rnd*255, rnd*255, rnd*255, 0) )
    screenunlock
    sleep 1,1
loop until len(inkey)
