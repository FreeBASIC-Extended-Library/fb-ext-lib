''File: freetype.bas
''Description: Demonstration of ext.gfx.loadttf function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include "ext/graphics/font.bi"
using ext

dim as FB.IMAGE ptr mysmallfont, mylargefont

screenres 320,240,32



if ( gfx.font.loadttf("#micross.ttf", mylargefont, 32, 128, 40 ) = 1 ) then

draw string (1, 10), "ABCDEFGHIJKLMN", , mylargefont, Alpha
Draw String (1, 50), "OPQRSTUVWXYZ", , mylargefont, Alpha

draw string (1, 90), "abcdefghijklmn", , mylargefont, Alpha
Draw String (1, 130), "opqrstuvwxyz", , mylargefont, Alpha

Line (1,50)-(1,90)
print gfx.font.getTextWidth(mylargefont, "ABCDEFGHIJKLMN")
line (1,1)-(gfx.font.getTextWidth(mylargefont,"ABCDEFGHIJKLMN") + 1,1), &hff0000


Open Cons For Output As #1
Print #1, using "Large Font size: ####, requested: ####."; (mylargefont->height - 1); 40;
Print #1, ""
Close
end if

If ( gfx.font.loadttf("Vera.ttf", mysmallfont, 32, 128, 14 ) = 1 ) then

Draw string (1,170), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", , mysmallfont, ALPHA
Draw string (1,184), "abcdefghijklmnopqrstuvwxyz", , mysmallfont, Alpha
Open Cons For Output As #1
Print #1, using "Small Font size: ####, requested: ####."; (mysmallfont->height - 1); 14;
Print #1, ""
Close
End if

sleep

