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

#include once "ext/log.bi"
#include once "ext/memory.bi"
#include once "vbcompat.bi"
#include once "crt/time.bi"
#ifdef FBEXT_MULTITHREADED
#include once "ext/threads/comm.bi"
namespace ext
declare sub log_thread ( byval _cc as any ptr )
end namespace
#endif
namespace ext

#ifdef FBEXT_MULTITHREADED
using threads

type ldata
    as integer lvl
    as string file
    as string msg
    as integer lineno
    as integer ch
    declare constructor(byval l as integer, byval f as string, byval m as string, byval ln as integer, c as integer)
end type

constructor ldata(byval l as integer, byval f as string, byval m as string, byval ln as integer, c as integer)
    lvl = l
    file = f
    msg = m
    lineno = ln
    ch = c
end constructor

sub ldata_free( byval rhs as any ptr )
    var r = cast(ldata ptr, rhs)
    delete r
end sub
#endif

type _log_channel
    public:
    method as LOG_METHODS
    _data as any ptr
    _fdata as any ptr
    _fdata_free as any ptr
    level as LOGLEVEL
    declare constructor()
    declare destructor()
    #ifdef FBEXT_MULTITHREADED
    tid as any ptr
    cc as threads.CommChannel
    #endif
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
    #ifdef FBEXT_MULTITHREADED
    __log_channel[0].tid = threadcreate( @log_thread, @__log_channel[0].cc )
    #endif
end sub

sub __destroy_log () destructor
    #ifdef FBEXT_MULTITHREADED
    for n as uinteger = 0 to __log_nc -1
        __log_channel[n].cc.send(new Message(-1))
        threadwait __log_channel[n].tid
    next
    #endif
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
        var oldc = c- __log_nc
        __log_nc = c
        delete[] oldp
        #ifdef FBEXT_MULTITHREADED
        if oldc > 0 then
            for n as uinteger = __log_nc - (oldc + 1) to __log_nc -1
                __log_channel[n].tid = threadcreate( @log_thread, @__log_channel[n].cc )
            next
        end if
        #endif
        return FALSE
    end if
    return TRUE
end function

function iso_datetime( byval t as double ) as string

    #ifdef __FB_WIN32__
        var tzoffset = *__p__timezone()
        var trailer = "Z"
    #endif
    #ifdef __FB_LINUX__
        var tzoffset = __timezone
        var trailer = "Z"
    #endif
    #ifdef __FB_DOS__
        var tzoffset = 0
        var trailer = ""
    #endif

    return format(DateAdd("s",tzoffset,t),"yyyy-mm-ddThh:mm:ss" & trailer)

end function

#ifdef FBEXT_MULTITHREADED
enum LOG_TCOMM explicit
    QUIT = -1
    LOG2PRINT = 0
    LOG2FILE
    LOG2CUSTOM
end enum
#endif

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
        var pmsg = lstr(lvl) & ": " & _msg_
        #ifdef FBEXT_MULTITHREADED
        __log_channel[channel].cc.send(new Message(LOG_TCOMM.LOG2PRINT,new MData(new ldata(0,"",pmsg,0,0),@ldata_free)))
        #else
        print pmsg
        #endif
    case LOG_FILE
        var fname_ = cast(zstring ptr,__log_channel[channel]._data)
        var fname = ""
        if fname_ <> 0  then
            fname = *fname_
        else
            fname = command(0) & ".log"
        end if
        var pmsg = iso_datetime(now) & " " & lstr(lvl) & " " & _msg_ & " -> " & _file_ & ":" & _line_number_

        #ifdef FBEXT_MULTITHREADED
        __log_channel[channel].cc.send(new Message(LOG_TCOMM.LOG2FILE,new MData(new ldata(0,fname,pmsg,0,0),@ldata_free)))
        #else
        var ff = freefile
        open fname for append access write as #ff
        print #ff, pmsg
        close #ff
        #endif
    case LOG_CUSTOM
        #ifdef FBEXT_MULTITHREADED
        var pmsg = " " & _msg_
        pmsg = ltrim(pmsg)
        var pfile = " " & _file_
        pfile = ltrim(pfile)
        __log_channel[channel].cc.send(new Message(LOG_TCOMM.LOG2CUSTOM,new MData(new ldata(lvl,pfile,pmsg,_line_number_,channel),@ldata_free)))
        #else
        cast(log_custom_sub,__log_channel[channel]._data)(lvl,_msg_,_file_,_line_number_,__log_channel[channel]._fdata)
        #endif
    end select

    end if

end sub

#ifdef FBEXT_MULTITHREADED
sub log_thread ( byval _cc as any ptr )
    var cc = cast(threads.CommChannel ptr,_cc)

    do
    var r = cc->recv()
    if r <> 0 then
        var d = cast(ldata ptr,r->msgdata())
        select case r->command
        case LOG_TCOMM.QUIT
            delete r
            exit do
        case LOG_TCOMM.LOG2PRINT
            print d->msg
        case LOG_TCOMM.LOG2FILE
            var ff = freefile
            open d->file for append access write as #ff
            print #ff, d->msg
            close #ff
        case LOG_TCOMM.LOG2CUSTOM
            cast(log_custom_sub,__log_channel[d->ch]._data)(d->lvl,d->msg,d->file,d->lineno,__log_channel[d->ch]._fdata)
        end select
        delete r
    end if
    loop

end sub
#endif

end namespace
