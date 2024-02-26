''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
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

#ifdef __FB_UNIX__

extern "C"
    declare sub openlog( byval as const zstring ptr, byval as integer, byval as integer )
    declare sub syslog(byval as integer,byval as const zstring ptr, ... )
    declare sub closelog()
end extern

#include once "ext/log.bi"

dim shared as ext.bool __syslog_active

sub __syslog_logger destructor
    if __syslog_active then closelog
    __syslog_active = ext.false
end sub

namespace ext.logger

    private function loglevlTosyslog( byval l as LOGLEVEL ) as integer

        var pri = 0

        select case l
        case _DEBUG
            pri = 7
        case _WARN
            pri = 4
        case _INFO
            pri = 6
        case _FATAL
            pri = 3
        end select

        return (((1 shl 3) shl 3) OR pri)

    end function

    private sub sys_logger (   byval l as LOGLEVEL, byref _msg_ as const string, byref _filen_ as const string, _
                                byval _linen_ as integer, byval _data_ as any ptr )

        if __syslog_active = false then openlog(0,0,0)
        __syslog_active = true

        syslog(loglevlTosyslog(l),"%s:%s %s",_filen_,str(_linen_),_msg_)

    end sub

    sub useSYSlog( byval c as uinteger = 0 )
        setLogMethod(c,LOG_CUSTOM,@sys_logger,0,0)
    end sub

end namespace

#endif
