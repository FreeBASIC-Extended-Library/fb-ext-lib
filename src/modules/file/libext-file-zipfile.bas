''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
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
    m_data = zip_open( zfname, 0, 0 )
end constructor

destructor ZipFile()
    zip_close(m_data)
end destructor

private  sub zipfile_fre( byval d as any ptr )
    deallocate( cast(ubyte ptr,d) )
end sub

function ZipFile.open( byref zifname as const string ) as File ptr

    dim as zip_stat_ fileinfo
    zip_stat_init( @fileinfo )

    if zip_stat( m_data, zifname, 0, @fileinfo ) = 0 then
        var zf = zip_fopen( m_data, zifname, 0 )
        if zf = 0 then return NULL
        var retbuf = callocate(cuint(fileinfo.size))
        zip_fread( zf, retbuf, cuint(fileinfo.size) )
        zip_fclose( zf )
        return new File(newMemoryFileDriver(retbuf,cuint(fileinfo.size),@zipfile_fre))
    else
        return NULL
    end if

end function

end namespace
