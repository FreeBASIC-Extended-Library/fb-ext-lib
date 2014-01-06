''File: ofont.bas
''Description: Demonstration of ext.gfx.ofont class.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include "ext/graphics/font.bi"
using ext.gfx.font

dim as oFont ptr mysmallfont, mylargefont

screenres 320,240,32

mylargefont = new oFont( "#micross.ttf", 40 )
mysmallfont = new oFont( "Vera.ttf", 14 )

with *(mylargefont)
    .drawString 1, 10, "ABCDEFGHIJKLMN"
    .drawString 1, 50, "OPQRSTUVWXYZ"
    .drawString 1, 90, "abcdefghijklmn"
    .drawString 1, 130, "opqrstuvwxyz"

Line (1,50)-(1,90)
print .getWidth("ABCDEFGHIJKLMN")
line (1,1)-(.getWidth("ABCDEFGHIJKLMN") + 1,1), &hff0000
end with

with *(mysmallfont)

    .drawString 1,170, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    .drawString 1,184, "abcdefghijklmnopqrstuvwxyz"

end with
sleep

