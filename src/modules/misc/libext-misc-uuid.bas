''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
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

#include once "ext/uuid.bi"

namespace ext.misc

function UUID.isNull() as integer

    for n as integer = 0 to 15
        if d(n) <> 0 then return 0
    next

    return -1

end function

constructor UUID()
    this.clear()
end constructor

constructor UUID( byref rhs as const UUID )
    for n as integer = 0 to 15
        this.d(n) = rhs.d(n)
    next
end constructor

constructor UUID( byref rhs as string )

    if len(rhs) <> 32 andalso len(rhs) <> 38 then
        this.clear()
        return
    end if

    if len(rhs) = 32 then
        var index = 0
        for n as integer = 0 to 31 step 2
            d(index) = valint("&h" & chr(rhs[n]) & chr(rhs[n+1]))
            index += 1
        next n
    else
        var index = 0
        for n as integer = 1 to 8 step 2
            d(index) = valint("&h" & chr(rhs[n]) & chr(rhs[n+1]))
            index += 1
        next
        for n as integer = 10 to 13 step 2
            d(index) = valint("&h" & chr(rhs[n]) & chr(rhs[n+1]))
            index += 1
        next
        for n as integer = 15 to 18 step 2
            d(index) = valint("&h" & chr(rhs[n]) & chr(rhs[n+1]))
            index += 1
        next
        for n as integer = 20 to 23 step 2
            d(index) = valint("&h" & chr(rhs[n]) & chr(rhs[n+1]))
            index += 1
        next
        for n as integer = 25 to 36 step 2
            d(index) = valint("&h" & chr(rhs[n]) & chr(rhs[n+1]))
            index += 1
        next

    end if

end constructor

operator = ( byref lhs as uuid, byref rhs as uuid ) as integer

    for n as integer = 0 to 15
        if lhs.d(n) <> rhs.d(n) then return 0
    next

    return -1

end operator

sub UUID.randomize()

    for n as integer = 0 to 15
        d(n) = int((rnd*256))
    next

    d(6) = (d(6) and &h0F) or &h40

    var rflag = (d(8) and &hF0) shr 4
    select case rflag
    case 8, 9, &hA, &hB
        'do nothing
    case else
        d(8) = (d(8) and &h0F) or &hA0
    end select

end sub

sub UUID.clear()
    for n as integer = 0 to 15
        d(n) = 0
    next
end sub

operator UUID.cast() as string

    var ret = ""
    var index = 0

    for n as integer = 0 to 21

    select case n
    case 0
        ret = "{"
    case 5, 8, 11, 14
        ret &= "-"
    case 21
        ret &= "}"
    case else
        if len(hex(d(index))) = 2 then
            ret &= hex(d(index))
        else
            ret &= "0" & hex(d(index))
        end if
        index += 1
    end select

    next

    return ret

end operator

end namespace
