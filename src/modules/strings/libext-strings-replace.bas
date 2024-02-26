''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright by John Milton
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

# include once "ext/strings/manip.bi"
# include once "ext/misc.bi"

namespace ext.strings

    '' :::::
Sub Replace (subject As String, oldtext As const String, newtext As const String)
  'replaces all occurances of oldtext in subject with newtext
  Dim As Integer n
  If subject <> "" And oldtext <> "" And oldtext <> newtext Then
    n = Instr(subject, oldtext)
    Do While n <> 0
      subject = Left(subject,n-1) & newtext & Right(subject,Len(subject)- n - Len(oldtext)+ 1)
      n = Instr(n + Len(newtext),subject, oldtext)
    Loop
  Endif
End Sub

    '' :::::
    sub Replace (byref subject as string, oldtext() as const string, byref newtext as const string)

        for i as integer = lbound(oldtext) to ubound(oldtext)
            ext.strings.Replace(subject, oldtext(i), newtext)
        next

    end sub


    '' :::::
    sub Replace (byref subject as string, oldtext() as const string, newtext() as const string)

        var result = subject

        var search_size = ubound(oldtext) - lbound(oldtext) + 1
        var replace_size = ubound(newtext) - lbound(newtext) + 1

        var n = FBEXT_MIN(search_size, replace_size)

        for i as integer = lbound(oldtext) to lbound(oldtext) + n - 1
            ext.strings.Replace(subject, oldtext(i), newtext(i))
        next

        if search_size > replace_size then
            for i as integer = n - 1 to ubound(oldtext)
                ext.strings.Replace(subject, oldtext(i), "")
            next
        end if

    end sub

    '' :::::
    sub replace (subject() as string, byref oldtext as const string, byref newtext as const string)

        for i as integer = lbound(subject) to ubound(subject)
            ext.strings.Replace(subject(i), oldtext, newtext)
        next

    end sub

    '' :::::
    sub replace (subject() as string, oldtext() as const string, byref newtext as const string)

        for i as integer = lbound(subject) to ubound(subject)
            ext.strings.Replace(subject(i), oldtext(), newtext)
        next

    end sub

    '' :::::
    sub replace (subject() as string, oldtext() as const string, newtext() as const string)

        for i as integer = lbound(subject) to ubound(subject)
            replace(subject(i), oldtext(), newtext())
        next

    end sub

end namespace
