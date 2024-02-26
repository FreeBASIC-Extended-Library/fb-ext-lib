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

#include once "ext/algorithms/detail/common.bi"
#include once "crt/ctype.bi"

namespace ext.strings

function ltrimall( byref s as const string ) as string
    var ret = ""
    for n as long = 0 to len(s)-1
        if isspace(s[n]) <> 0 then
            continue for
        else
            ret = space(len(s)-n)
            memcpy(@ret[0],@s[n],len(ret))
            exit for
        end if
    next
    return ret
end function

function rtrimall( byref s as const string ) as string
    var ret = ""
    for n as long = len(s)-1 to 0 step -1
        if isspace(s[n]) <> 0 then
            continue for
        else
            ret = mid(s,1,n+1)
            exit for
        end if
    next
    return ret
end function

function trimall( byref s as const string ) as string
    return ltrimall(rtrimall(s))
end function

function compact ( byref s as const string ) as string
    var ret = ""
    dim as long cnt = 0
    for n as long = 0 to len(s) -1
        if isspace(s[n])<>0 then
            if cnt = 0 then
                ret &= chr(s[n])
            end if
            cnt += 1
        else
            cnt = 0
            ret &= chr(s[n])
        end if
    next
    return ret
end function

end namespace
