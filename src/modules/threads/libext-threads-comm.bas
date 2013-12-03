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

#include once "ext/threads/comm.bi"

namespace ext.threads

constructor MData( byval dt as any ptr, byval frefun as sub( byval as any ptr ) ) export
    d = dt
    f = frefun
end constructor

destructor Message export
    if x <> 0 then delete x
end destructor

constructor Message( byval cm as integer, byval xtra as Mdata ptr = 0, byval cc as ComChannel_f ptr = 0 ) export
    this.c = cm
    this.x = xtra
    this.m = cc
end constructor

function Message.command ( ) as integer
    return this.c
end function

function Message.msgdata () as any ptr
    if this.x = 0 then
        return 0
    else
        return this.x->d
    end if
end function

constructor Messages( byval rhs as Message ptr ) export
    this.d = rhs
    this.n = 0
end constructor

destructor Messages( ) export
    if this.d <> 0 then delete this.d
    if this.n <> 0 then delete this.n
end destructor

constructor CommChannel export
    _mutex = new Mutex
    _omutex = new Mutex
end constructor

destructor CommChannel export
    if _mess <> 0 then delete _mess
    if _omess <> 0 then delete _omess
    if _mutex <> 0 then delete _mutex
    if _omutex <> 0 then delete _omutex
end destructor

sub CommChannel.send( byval m as Message ptr ) export
    _mutex->lock
    var nm = new Messages(m)
    var stepr = _mess
    var eol = stepr
    while stepr <> 0
        eol = stepr
        stepr = stepr->n
    wend
    if eol = 0 then
        _mess = nm
    else
        eol->n = nm
    end if
    _mutex->unlock
end sub

sub CommChannel.status( byval m as Message ptr ) export
    _omutex->lock
    var nm = new Messages(m)
    var stepr = _omess
    var eol = stepr
    while stepr <> 0
        eol = stepr
        stepr = stepr->n
    wend
    if eol = 0 then
        _omess = nm
    else
        eol->n = nm
    end if
    _omutex->unlock
end sub

function CommChannel.peekA( ) as Message ptr export
    _omutex->lock
    dim as Message ptr ret = 0
    if _omess <> 0 then
        ret = _omess->d
    end if
    _omutex->unlock
    return ret
end function

function CommChannel.peekB( ) as Message ptr export
    _mutex->lock
    dim as Message ptr ret = 0
    if _mess <> 0 then
        ret = _mess->d
    end if
    _mutex->unlock
    return ret
end function

function CommChannel.recv( ) as Message ptr export
    dim res as Message ptr
    _mutex->lock
        if _mess = 0 then
            _mutex->unlock
            return 0
        end if
        var new_mess = _mess->n
        var old_mess = _mess
        _mess->n = 0
        res = _mess->d
        _mess->d = 0
        _mess = new_mess
    _mutex->unlock
    delete old_mess
    return res
end function

function CommChannel.response( ) as Message ptr export
    dim res as Message ptr
    _omutex->lock
        if _omess = 0 then
            _omutex->unlock
            return 0
        end if
        var new_mess = _omess->n
        var old_mess = _omess
        _omess->n = 0
        res = _omess->d
        _omess->d = 0
        _omess = new_mess
    _omutex->unlock
    delete old_mess
    return res
end function

end namespace
