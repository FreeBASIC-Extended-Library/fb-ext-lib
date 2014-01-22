''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include "ext/input.bi"

namespace ext

private sub _def_print( byval x as uinteger, byval y as uinteger, byref data_ as string, byval _color as any ptr = NULL )

    if _color <> 0 then
        var oldc = color()
        var newc = *cast(integer ptr,_color)
        color loword(newc), hiword(newc)
        locate y, x
        print data_
        color loword(oldc), hiword(oldc)
    else
        locate y, x
        print data_
    end if

end sub

private sub _def_gfx_print( byval x as uinteger, byval y as uinteger, byref data_ as string, byval _color as any ptr = NULL )

    if _color <> 0 then
        draw string (x,y), data_,*(cast(integer ptr, _color))
    else
        draw string (x,y), data_
    end if

end sub

constructor xInput

    this.maxlength = 255
    this.password = false
    this.cancel = false
    this.numonly = false
    this.timeout = 0
    if SCREENPTR = 0 then
        this.print_cb = @_def_print
    else
        this.print_cb = @_def_gfx_print
    end if
    this.print_cb_data = NULL

end constructor

function xInput.get( byval x as uinteger = Pos(), byval y as uinteger = Csrlin(), byref prompt as const string = "" ) as string

    Dim As String mykey, blank, display
    Dim As Double mytimer, timerout

    while inkey <> ""
    wend

    If y < 1 Or x < 1 Then
        Return ""
    else
        this.m_y = y
        this.m_x = x
    End If

    If timeout > 0 Then
        timerout = Timer + timeout
    else
        this.m_temp = ""
    end if

    mytimer = Timer +.5

    Do

        mykey = Inkey

        If Len(mykey) > 0 Then
            Select Case mykey
            Case ""  '' This shouldn't happen

            Case Chr(8)  '' Backspace key
                If Len(m_temp) = 1 Then
                    blank = Space(Len(this.m_temp)+1)
                    this.m_temp = ""
                Else
                    If Len(this.m_temp) > 0 Then
                        blank = Space(Len(this.m_temp)+1)
                        this.m_temp = Left(this.m_temp, Len(this.m_temp) - 1)
                    End If
                End If

                this.print_cb(x,y,prompt & blank,this.print_cb_data)

            Case Chr(27) '' Escape key, our cancel key
                If this.cancel Then
                    this.m_temp = Chr(27)
                    Exit Do
                End If

            Case Else  '' This is where the magic happens
                If this.numonly Then
                '' do numeric only input first
                    If mykey[0]<48 Or mykey[0] > 57 Then
                        If mykey[0] <> 13 Then
                            If mykey[0] <> 46 Then
                                mykey = ""
                            End If
                        End If
                    else
                        if mykey[0] <> 46 then
                            if this.callback <> 0 then
                                m_temp_ret = this.callback( mykey[0], this.callback_data )
                                if m_temp_ret = ext.bool.invalid then exit do
                                if m_temp_ret then
                                    this.m_temp &= mykey
                                else
                                    mykey = ""
                                end if
                            else
                                this.m_temp &= mykey
                            end if
                        end if
                    End If
                else
                    If mykey[0] > 31 And mykey[0] < 255 Then
                        If this.timeout > 0 Then timerout = Timer + this.timeout
                        if this.callback <> 0 then
                            m_temp_ret = this.callback( mykey[0], this.callback_data )
                            if m_temp_ret = ext.bool.invalid then exit do
                            if m_temp_ret then
                                this.m_temp &= mykey
                            else
                                mykey = ""
                            end if
                        else
                            this.m_temp &= mykey
                        end if

                    End If
                end if

            End Select

        End If

        '' time to refresh display

        Select Case this.password
        Case false '' Not password entry
            display = prompt & this.m_temp
        Case Else '' Password entry
            display = prompt & String(Len(this.m_temp), "*")
        End Select

        if this.callback <> null then
            m_temp_ret = this.callback(0,this.callback_data)
            if m_temp_ret = invalid then exit do
        end if

        If Timer > mytimer Then
            this.print_cb(x,y,display & "_",this.print_cb_data)
            mytimer = Timer + .5
        Else
            this.print_cb(x,y,display & " ",this.print_cb_data)
        End If

        If timerout > 0 Then
            If Timer > timerout Then Exit Do
        End If

        Sleep 50

    Loop Until mykey = Chr(13) Or Len(this.m_temp) = this.maxlength

    this.print_cb(x,y,display & " ",this.print_cb_data)
    Return this.m_temp

End Function

end namespace
