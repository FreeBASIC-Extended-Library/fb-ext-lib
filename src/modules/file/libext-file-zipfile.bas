''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

#include once "ext/file/zipfile.bi"
#include "zip.bi"

namespace ext

constructor ZipFile( byref zfname as const string )
    var erz = 0
    m_data = zip_open( zfname, ZIP_CREATE, @erz )
    if erz > 0 then
        ext.setError(100,"Error opening/creating zipfile: " & erz)
    end if
end constructor

destructor ZipFile()
    zip_close(m_data)
end destructor

private  sub zipfile_fre( byval d as any ptr )
    deallocate( cast(ubyte ptr,d) )
end sub

type ZipFileSystemDriver
        as ubyte ptr d
        as SizeType dlen
        as SizeType l
        as sub(byval as any ptr) ff
        as any ptr z
        as string f
end type

private function MFzip_open ( byval t as FileSystemDriver ptr ) as bool

        var x = cast(ZipFileSystemDriver ptr, t->driverdata)
        var zf = zip_fopen( x->z, x->f, 0 )
        if zf = 0 then return TRUE
        x->d = callocate(x->dlen)
        zip_fread( zf, x->d, x->dlen )
        zip_fclose( zf )
        return FALSE

end function

private sub MFzip_close ( byval t as FileSystemDriver ptr )
        var x = cast(ZipFileSystemDriver ptr, t->driverdata)
        zipfile_fre(x->d)
        if x <> 0 then delete x
end sub

type __zf_MemoryFileDriver
        as ubyte ptr d
        as SizeType dlen
        as SizeType l
        as sub(byval as any ptr) ff
end type

function ZipFile.open( byref zifname as const string ) as File ptr

    #if not __FB_MIN_VERSION__(0,25,0)
    dim as zip_stat_ fileinfo
    #else
    dim as zip_stat fileinfo
    #endif
    zip_stat_init( @fileinfo )

    if zip_stat( m_data, zifname, 0, @fileinfo ) = 0 then

        var md = newMemoryFileDriver(0,cuint(fileinfo.size))
        var x = cast(__zf_MemoryFileDriver ptr,md->driverdata)
        var zfsd = new ZipFileSystemDriver
        zfsd->dlen = x->dlen
        zfsd->z = m_data
        zfsd->f = zifname
        md->fsopen = @MFzip_open
        md->fsclose(md)
        md->fsclose = @MFzip_close

        return new File(md)
    else
        return NULL
    end if

end function

function ZipFile.fileCount( ) as ulongint
    return zip_get_num_entries(m_data,0)
end function

sub ZipFile.fileNames ( fns() as string )

    var cnt = cuint(fileCount())
    if cnt = 0 then return

    redim fns(0 to cnt - 1)

    for n as uinteger = 0 to cnt - 1
        fns(n) = *(zip_get_name(m_data,n,0))
    next

end sub

function ZipFile.add(   byref zifname as const string, _
                                    byval zfil as File ptr, _
                                    byval ovrw as Bool = FALSE ) as Bool

    dim buf as ubyte ptr
    var buf_len = zfil->toBuffer(buf)

    var zsrc = zip_source_buffer(m_data,buf,buf_len,0)
    if zsrc = 0 then
        zip_source_free(zsrc)
        return TRUE
    end if

    var zret = 0

    if ovrw then
        var i = zip_name_locate(m_data,zifname,0)
        if i < 0 then
            zret = zip_add(m_data, zifname, zsrc)
        else
            zret = zip_replace(m_data, i, zsrc)
        end if
    else
        zret = zip_add(m_data, zifname, zsrc)
    end if
    zip_source_free(zsrc)
    if zret <> 0 then return TRUE

    return FALSE

end function

function ZipFile.name( byref orig as const string, byref dest as const string ) as bool

    var orig_i = zip_name_locate(m_data,orig,0)
    if orig_i < 0 then
        return TRUE
    end if

    if zip_rename(m_data, orig_i, dest) <> 0 then
        return TRUE
    else
        return FALSE
    end if

end function

function ZipFile.remove( byref zfname as const string ) as bool

    var orig_i = zip_name_locate(m_data,zfname,0)
    if orig_i < 0 then
        return TRUE
    end if

    if zip_delete(m_data, orig_i) <> 0 then
        return TRUE
    else
        return FALSE
    end if

end function

function ZipFile.forgetChanges( ) as bool
    if zip_unchange_all(m_data) <> 0 then
        return TRUE
    else
        return FALSE
    end if
end function

end namespace
