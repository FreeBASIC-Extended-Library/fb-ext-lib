''File: GetTextWidth.bas
''Description: Demonstration of ext.gfx.loadttf and ext.gfx.GetTextWidth functions.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include "ext/graphics/font.bi"
using ext

dim as FB.IMAGE ptr mysmallfont

screenres 320,240,32

paint (1,1),&hFFFFFF


if ( gfx.font.loadttf("Vera.ttf", mysmallfont) = 1 ) then

draw string (8,8), "This is a small test of the GetTextWidth Function.", , mysmallfont, ALPHA

var text_width = gfx.font.GetTextWidth( mysmallfont, "This is a small test of the GetTextWidth Function." )

line (6,6)-(6 + text_width, 6 + mysmallfont->height),&hFF0000, B

end if


sleep

