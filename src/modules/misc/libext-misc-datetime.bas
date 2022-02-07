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

#include once "ext/datetime.bi"
#include once "vbcompat.bi"
#ifdef __FB_WIN32__
#define WIN32_LEAN_AND_MEAN
#include once "windows.bi"
#else
#include once "crt/time.bi"
#endif

namespace ext.datetime

function formatAsISO( byval t as double, byval n as bool ) as string

    var our_t = t
    if our_t = 0.0 then our_t = now()

    #ifdef __FB_WIN32__
        dim tz as _TIME_ZONE_INFORMATION
        GetTimeZoneInformation(@tz)
        var tzoffset = tz.Bias * 60
        var trailer = "Z"
    #endif
    #ifdef __FB_UNIX__
        var tzoffset = __timezone
        var trailer = "Z"
    #endif
    #ifdef __FB_DOS__
        return format(our_t,"yyyy-mm-ddThh:mm:ss")
    #endif
    if n = false then
        trailer = str(-(tzoffset/(60*60)))
        var poff = instr(trailer,".")
        if poff > 0 then
            var trailer1 = mid(trailer,1,poff-1) & ":"
            trailer = trailer1 & (cdbl("." & mid(trailer,poff+1)) * 60)
        else
            trailer = trailer & ":00"
        end if
        if trailer[0] <> asc("-") then trailer = "+" & trailer
        return format(our_t,"yyyy-mm-ddThh:mm:ss" & trailer)
    end if

    return format(DateAdd("s",tzoffset,our_t),"yyyy-mm-ddThh:mm:ss" & trailer)

end function

end namespace
