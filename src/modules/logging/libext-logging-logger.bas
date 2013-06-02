''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
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

#include once "ext/log.bi"
#include once "ext/memory.bi"
#include once "vbcompat.bi"

namespace ext

type _log_channel
    public:
    method as LOG_METHODS
    _data as any ptr
    _fdata as any ptr
    _fdata_free as any ptr
    level as LOGLEVEL
    declare constructor()
    declare destructor()
end type

constructor _log_channel
    method = LOG_PRINT
    level = _INFO
end constructor

destructor _log_channel
    if _fdata <> 0 then
        cast(custom_data_free,_fdata_free)(_fdata)
    end if
end destructor

dim shared __log_channel as _log_channel ptr
dim shared __log_nc as uinteger

private function lstr( byval l as LOGLEVEL ) as string
    select case l
    case _DEBUG
        return "DEBUG"
    case _INFO
        return "INFO"
    case _WARN
        return "WARN"
    case _FATAL
        return "FATAL"
    end select
    return "LLAMA"
end function

sub setLogLevel( byval l as LOGLEVEL )
        __log_channel[0].level = l
end sub

sub setLogLevel( byval channel as uinteger, byval l as LOGLEVEL )

    if channel < __log_nc orelse channel = 0 then
    __log_channel[channel].level = l
    end if

end sub

sub setLogMethod overload ( byval m as LOG_METHODS, byval d as any ptr = 0, byval fd as any ptr = 0, byval fdf as any ptr = 0 )
    setLogMethod(0,m,d,fd,fdf)
end sub

sub setLogMethod( byval channel as uinteger, byval m as LOG_METHODS, byval d as any ptr = 0, byval fd as any ptr = 0, byval fdf as any ptr = 0 )

    if channel < __log_nc orelse channel = 0 then
    __log_channel[channel].method = m
    __log_channel[channel]._data = d
    __log_channel[channel]._fdata = fd
    __log_channel[channel]._fdata_free = fdf
    end if

end sub

sub __init_log () constructor
    __log_nc = 1
    __log_channel = new _log_channel[__log_nc]
end sub

sub __destroy_log () destructor
    if __log_channel <> NULL then delete[] __log_channel
    __log_nc = 0
end sub

function setNumberOfLogChannels( byval c as uinteger ) as bool
    if c = __log_nc then return FALSE
    if c > 256 then return TRUE
    var newp = new _log_channel[c]
    if newp <> NULL then
        memcpy(newp,__log_channel,iif(c>__log_nc,__log_nc,c))
        var oldp = __log_channel
        __log_channel = newp
        __log_nc = c
        delete[] oldp
        return FALSE
    end if
    return TRUE
end function

function iso_datetime( byval t as double ) as string

    return format(t,"yyyy-mm-ddThh:mm:ss")

end function

sub __log( byval lvl as LOGLEVEL, _
            byref _msg_ as const string, _
            byref _file_ as const string, _
            byval _line_number_ as integer, _
            byval channel as uinteger = 0 _
            )

    if channel < __log_nc orelse channel = 0 then

    if lvl < __log_channel[channel].level then return

    select case __log_channel[channel].method
    case LOG_NULL
        return
    case LOG_PRINT
        print lstr(lvl) & ": " & _msg_
    case LOG_FILE
        var fname_ = cast(zstring ptr,__log_channel[channel]._data)
        var fname = ""
        if fname_ <> 0  then
            fname = *fname_
        else
            fname = command(0) & ".log"
        end if
        var isodate = ""

        var ff = freefile
        open fname for append access write as #ff
        print #ff, iso_datetime(now) & " " & lstr(lvl) & " " & _msg_ & " -> " & _file_ & ":" & _line_number_
        close #ff
    case LOG_CUSTOM
        cast(log_custom_sub,__log_channel[channel]._data)(lvl,_msg_,_file_,_line_number_,__log_channel[channel]._fdata)
    end select

    end if

end sub

end namespace
