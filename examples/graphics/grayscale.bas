''File: grayscale.bas
''Description: Demonstration of ext.gfx.grayscale function.
''
''Copyright (c) 2007-2024 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING)

#define FBEXT_NO_EXTERNAL_LIBS -1
#include once "ext/graphics/manip.bi"
#include once "ext/graphics/bmp.bi"
#include once "ext/misc.bi"

using ext.gfx

screenres 640, 240, 32
windowtitle "A simple example of the grayscale function using a Marmot."
var img1 = bmp.load("marmot24bit.bmp")
locate 10,1
print "Photo provided by: http://www.flickr.com/photos/baggis/"
print
print "Preparing Marmot... ";
FBEXT_TIMED_OP_START
var img2 = grayscale(img1)
var timeo = FBEXT_TIMED_OP_END
print "press any key! "
print

if img2 = ext.null then
    print "fail"
    sleep
    system
else
    print "Generated in " & timeo & " seconds"
    sleep
end if
cls

img1->Display 1,1, PSET_
img2->Display 321,1, PSET_

sleep
delete img1
delete img2
