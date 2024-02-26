''File: triangle.bas
''Description: Demonstration of flat shaded triangle drawing function.
''
''Copyright (c) 2007-2024 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING)

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
