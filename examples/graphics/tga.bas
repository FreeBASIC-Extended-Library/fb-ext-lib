#include once "ext/graphics/tga.bi"

Dim As String       file_name
Dim As fb.image Ptr img
Dim As Double       t

file_name = Command( 1 )

screenres 800, 600, 32

If file_name = "" Then file_name = "fbextlogo.tga"

t = Timer( )
img = ext.gfx.tga.load( file_name )
t = Timer( ) - t

If img <> 0 Then
        Print Int( t * 1000 ) & "ms"
        Put (16, 16), img, ALPHA
        imagedestroy( img )
Else
        Print "Load error"
End If

Sleep
End
