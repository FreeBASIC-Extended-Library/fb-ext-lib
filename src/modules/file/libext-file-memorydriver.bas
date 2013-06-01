'' Copyright (c) 2013, FreeBASIC Extended Library Development Group
''
'' All rights reserved.
''
'' Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''  * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
'' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
'' "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
'' LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
'' A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
'' CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
'' EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
'' PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
'' PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
'' LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
'' NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
'' SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include once "ext/file/detail/common.bi"

namespace ext

    type MemoryFileDriver
        as ubyte ptr d
        as SizeType dlen
        as SizeType l
        as sub(byval as any ptr) ff
    end type

    private function MFopen ( byval t as FileSystemDriver ptr ) as bool
        var x = cast(MemoryFileDriver ptr,t->driverdata)
        if x->d <> 0 andalso x->dlen > 0 then
            return true
        else
            return false
        end if
    end function

    private sub MFclose ( byval t as FileSystemDriver ptr )
        var x = cast(MemoryFileDriver ptr,t->driverdata)
        if x->ff <> 0 then
            x->ff(x->d)
            x->d = NULL
            x->dlen = 0
            x->l = 0
        end if
        delete x
    end sub

    private function MFlof ( byval t as FileSystemDriver ptr ) as ulongint
        var x = cast(MemoryFileDriver ptr,t->driverdata)
        return cast(ulongint,x->dlen)
    end function

    private function MFloc ( byval t as FileSystemDriver ptr ) as ulongint
        var x = cast(MemoryFileDriver ptr,t->driverdata)
        return cast(ulongint,x->l)
    end function

    private function MFseek (  byval t as FileSystemDriverF ptr, byval p as ulongint ) as bool
        dim as uinteger newloc = cast(uinteger,p)
        var x = cast(MemoryFileDriver ptr,t->driverdata)

        if newloc >= x->dlen then
            return false
        else
            x->l = newloc
            return true
        end if

    end function

    private function MFeof (  byval t as FileSystemDriverF ptr ) as bool
        var x = cast(MemoryFileDriver ptr,t->driverdata)
        if x->l < x->dlen then
            return false
        else
            return true
        end if
    end function

    private function MFget ( byval t as FileSystemDriverF ptr, byval pos_ as ulongint, byval p as ubyte ptr, byval n as SizeType ) as SizeType

        if p = 0 then return 0
        var x = cast(MemoryFileDriver ptr,t->driverdata)
        if pos_ <> 0 then
            var pos_test = t->fsseek(t,pos_)
            if pos_test = false then
                return 0
            end if
        end if
        if (x->l + n) <= x->dlen then
            for m as ubyte = 0 to n-1
                p[m] = 0
            next
            for i as uinteger = 0 to n - 1
                p[i] = x->d[x->l+i]
            next
            x->l = x->l + n
        else
            return 0
        end if
        return n

    end function

    private function MFput ( byval t as FileSystemDriverF ptr, byval pos_ as ulongint, byval p as ubyte ptr, byval n as SizeType ) as SizeType

        if p = 0 then return 0

        var x = cast(MemoryFileDriver ptr,t->driverdata)
        if pos_ <> 0 then
            var pos_test = t->fsseek(t,pos_)
            if pos_test = false then
                return 0
            end if
        end if

        if (x->l + n) <= x->dlen then
            for i as uinteger = 0 to n - 1
                x->d[x->l+i] = p[i]
                x->l += 1
            next
        else
            return 0
        end if

        return n

    end function


    function newMemoryFileDriver( byval d as ubyte ptr, byval dlen as SizeType, byval frefun as sub(byval as any ptr) = 0 ) as FileSystemDriver ptr
        var ret = new FileSystemDriver
        var dd = new MemoryFileDriver
            dd->d = d
            dd->dlen = dlen
            dd->l = 0u
            dd->ff = frefun
        ret->driverdata = dd

        ret->fsopen = @MFopen
        ret->fsclose = @MFclose
        ret->fslof = @MFlof
        ret->fsloc = @MFloc
        ret->fsseek = @MFseek
        ret->fseof = @MFeof
        ret->fsget = @MFget
        ret->fsput = @MFput

        return ret

    end function

end namespace 'ext
