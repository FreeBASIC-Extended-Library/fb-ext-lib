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

#include once "ext/graphics/detail/common.bi"
#include once "ext/containers/hashtable.bi"
#include once "ext/debug.bi"
#define FBEXT_BUILD_NO_GFX_LOADERS
#include once "ext/graphics/image.bi"

using ext.gfx
fbext_Instanciate(fbext_HashTable, ((GraphicsLoader)))

namespace ext.gfx

extern __driver_ht as fbext_HashTable((GraphicsLoader)) ptr

function LoadImage ( byref filename as const string, byval t as target_e = TARGET_FBNEW ) as Image ptr

    if __driver_ht = null then return null

    var sep = instrrev(filename,".")

    var extension = mid(filename,sep+1)

    var loader = __driver_ht->Find(extension)
    if loader = null then
        FBEXT_DPRINT("GraphicsLoader for " & extension & " not found!")
        return null
    end if

    var ret = loader->f(File(filename), t)
    if ret = null orelse ret->isEmpty then
    FBEXT_DPRINT("GraphicsLoader - Something went wrong loading the file")
    end if

    return ret

end function

function LoadImage( byref fn as File, byref filetype as string = "", byval t as target_e = TARGET_FBNEW ) as Image ptr

    var ret = null

    if __driver_ht = null then return null

    var sep = right(fn.fileName,3)
    if sep = "" andalso filetype = "" then return null

    if sep = "" then sep = filetype

    var loader = __driver_ht->Find(sep)
    if loader = null then return null

    ret = loader->f(fn,t)
    
    return ret

end function

end namespace
