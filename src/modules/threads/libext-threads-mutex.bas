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

#include once "ext/memory/sharedptr.bi"
#include once "ext/threads/mutex.bi"

type mutex_imp
    declare constructor()
    declare destructor()
    m as any ptr
end type

destructor mutex_imp()
    mutexdestroy m
end destructor

constructor mutex_imp()
    m = mutexcreate
end constructor

namespace ext
    fbext_Instanciate(fbext_SharedPtr, ((mutex_imp)))
end namespace

namespace ext.threads

operator Mutex.let( byref rhs as Mutex )
    this._m = new fbext_SharedPtr((mutex_imp))(*cast(fbext_SharedPtr((mutex_imp)) ptr, rhs._m))
end operator

constructor Mutex( byref rhs as Mutex )
    this = rhs
end constructor

sub Mutex.lock()
    var m = cast(fbext_SharedPtr((mutex_imp)) ptr,this._m)->get()
    mutexlock m->m
end sub

sub Mutex.unlock()
    var m = cast(fbext_SharedPtr((mutex_imp)) ptr,this._m)->get()
    mutexunlock m->m
end sub

constructor Mutex()
    this._m = new fbext_SharedPtr((mutex_imp))(new mutex_imp)
end constructor

destructor Mutex()
    var m = cast(fbext_SharedPtr((mutex_imp)) ptr,this._m)
    delete m
end destructor

end namespace
