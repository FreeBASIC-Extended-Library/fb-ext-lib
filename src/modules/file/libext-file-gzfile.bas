'' Copyright (c) 2024 FreeBASIC Extended Library Development Group
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

#include once "ext/file/file.bi"
#include once "zlib.bi"

namespace ext

    type gzfile_data
        as ACCESS_TYPE a
        as any ptr z
        as string f
    end type

    private function egzopen( byval t as FileSystemDriver ptr ) as bool

        var gzd = cast(gzfile_data ptr,t->driverdata)
        var accesst = ""
        select case gzd->a
        case ACCESS_TYPE.R
            accesst = "rb"
        case ACCESS_TYPE.W
            accesst = "wb"
        case ACCESS_TYPE.A
            accesst = "ab"
        case else
            return true
        end select
        gzd->z = gzopen(gzd->f,accesst)
        if gzd->z = null then return true
        return false

    end function

    private sub egzclose( byval t as FileSystemDriver ptr )
        var gzd = cast(gzfile_data ptr,t->driverdata)
        gzclose(gzd->z)
    end sub

    private function egzlof( byval t as FileSystemDriver ptr ) as ulongint
        var gzd = cast(gzfile_data ptr,t->driverdata)
        if gzd->a <> ACCESS_TYPE.R then
            var tempf = new File(gzd->f)
            if tempf->open() = true then return 0ull
            var tempfl = tempf->lof()
            tempf->seek = tempfl - 4
            dim as uinteger retl
            tempf->get(,retl,1)
            tempf->close()
            delete tempf
            return retl
        end if
        return 0ull
    end function

    private function egzloc( byval t as FileSystemDriver ptr ) as ulongint
        var gzd = cast(gzfile_data ptr,t->driverdata)
        return gztell(gzd->z)
    end function

    private function egzseek(  byval t as FileSystemDriverF ptr, byval p as ulongint ) as bool
        var gzd = cast(gzfile_data ptr,t->driverdata)
        if gzseek(gzd->z,p,0) = -1 then return false
        return true
    end function

    private function egzeof(  byval t as FileSystemDriverF ptr ) as bool
        var gzd = cast(gzfile_data ptr,t->driverdata)
        if gzeof(gzd->z) = 1 then return true
        return false
    end function

    private function egzget( byval t as FileSystemDriverF ptr, byval pos_ as ulongint, byval p as ubyte ptr, byval n as SizeType ) as SizeType
        var gzd = cast(gzfile_data ptr,t->driverdata)
        if pos_ <> 0 then
            if egzseek(t,pos_) = false then return 0
        end if
        return gzread(gzd->z,p,n)
    end function

    private function egzput( byval t as FileSystemDriverF ptr, byval pos_ as ulongint, byval p as ubyte ptr, byval n as SizeType ) as SizeType
        var gzd = cast(gzfile_data ptr,t->driverdata)
        if pos_ <> 0 then
            if egzseek(t,pos_) = false then return 0
        end if
        return gzwrite(gzd->z,p,n)
    end function

    function newGZfileDriver( byref fn as string, byval m as ACCESS_TYPE ) as FileSystemDriverF ptr

        var ret = new FileSystemDriver
        var gzd = new gzfile_data
        gzd->f = fn
        gzd->a = m
        ret->fsopen = @egzopen
        ret->fsclose = @egzclose
        ret->fslof = @egzlof
        ret->fsloc = @egzloc
        ret->fsseek = @egzseek
        ret->fseof = @egzeof
        ret->fsget = @egzget
        ret->fsput = @egzput
        ret->driverdata = gzd
        return ret

    end function

    function gzFile( byref fn as string, byval m as ACCESS_TYPE ) as File
        return File(newGZfileDriver(fn,m))
    end function

end namespace
