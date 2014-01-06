''File: tga.bas
''Description: Demonstration of the tga loading function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

#include once "ext/graphics/tga.bi"
#include once "ext/misc.bi"
using ext.gfx

Dim As String       file_name
Dim As Double       t

file_name = Command( 1 )

screenres 800, 600, 32
windowtitle "FBEXT TGA Viewer"

If file_name = "" Then file_name = "fbextlogo.tga"

FBEXT_TIMED_OP_START
var img = tga.load( file_name )
var timeo = FBEXT_TIMED_OP_END

If img <> 0 Then
        Print "Loaded in: " & timeo & " seconds"
        img->Display 16, 16, PSET_
        delete img
Else
        Print "Load error"
End If

Sleep
End
