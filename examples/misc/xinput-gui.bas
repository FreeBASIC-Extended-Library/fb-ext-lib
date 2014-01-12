#include once "ext/input.bi"
using ext

dim shared asking as bool
function updateScreen( byval ch as uinteger, byval data_ as any ptr ) as bool
    cls
    print chr(201) & string(22,205) & chr(187)
    if asking then
        print chr(186) & "         Hello        " & chr(186)
    else
        print chr(186) & "  What is your name?  " & chr(186)
    end if
    print chr(186) & string(22,32 ) & chr(186)
    print chr(186) & string(22,32 ) & chr(186)
    print chr(200) & string(22,205) & chr(188)
    return true
end function

sub myprinter( byval x as uinteger, byval y as uinteger, byref data_ as string, byval _nu as any ptr = 0 )
    draw string (x,y), data_
end sub

screenres 320, 240, 32
windowtitle "Please answer the question."

var x = xInput()

with x
    .maxLength = 20
    .callback = @updateScreen
    .print_cb = @myprinter
end with

updateScreen(0,0)

var yname = x.get(2*8,3*8)

asking = true

updateScreen(0,0)
windowtitle "Thank you."

myprinter(2*8,3*8, yname,0)

sleep
