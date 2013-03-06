#include "ext/graphics/font.bi"
using ext

dim as FB.IMAGE ptr mysmallfont, mylargefont

Var font_name = Command(1)
ScreenRes 320,240,32

if len(font_name) = 0 then

    print "Drag a font file onto this executable to preview"
    print "how it will look when loaded at 40pt and 14pt."
    print
    print "Any key to exit."

else

    WindowTitle "Displaying: " & font_name
    if ( gfx.font.loadttf(font_name, mylargefont, 32, 128, 40 ) = 1 ) then

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

    If ( gfx.font.loadttf(font_name, mysmallfont, 32, 128, 14 ) = 1 ) then

        Draw string (1,170), "ABCDEFGHIJKLMNOPQRSTUVWXYZ", , mysmallfont, ALPHA
        Draw string (1,184), "abcdefghijklmnopqrstuvwxyz", , mysmallfont, Alpha
        Open Cons For Output As #1
        Print #1, using "Small Font size: ####, requested: ####."; (mysmallfont->height - 1); 14;
        Print #1, ""
        Close

    End if

end if

Sleep
