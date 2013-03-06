''File: grayscale.bas
''Description: Demonstration of ext.gfx.grayscale function.
''
''Copyright (c) 2007-2012 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include once "ext/graphics/manip.bi"
#include once "ext/graphics/bmp.bi"
#include once "fbgfx.bi"

using ext.gfx

screenres 640, 240, 32
windowtitle "A simple example of the grayscale function using a Marmot."
var img1 = bmp.load("marmot.bmp") 'marmot photo provided by http://www.flickr.com/photos/baggis/
locate 10,1
print "Photo provided by: http://www.flickr.com/photos/baggis/"
print
print "Preparing Marmot... ";
var ti = timer
var img2 = grayscale(*img1)
var tout = timer
print "press any key! "
?
print using "Generated in ##.#### seconds"; (tout-ti)
sleep
cls

if img2 = ext.null then
        print "fail"
        sleep
        system
end if
put (1,1), img1, pset
put (321,1), img2, pset

sleep
imagedestroy img1
imagedestroy img2
