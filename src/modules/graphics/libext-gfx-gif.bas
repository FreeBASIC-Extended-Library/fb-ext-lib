''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''GIFLIB Copyright: (C) 1997 Eric S. Raymond <esr@thyrsus.com>
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

#define FBEXT_BUILD_NO_GFX_LOADERS 1
#include once "ext/graphics/image.bi"
#include once "ext/graphics/gif.bi"

#define __GIFLIB_VER__ 4 'we're using v4 api because that's what .24 supported
#include once "gif_lib.bi"

#ifndef __FB_FIXED_GIFLIB__
#undef DGifOpenFileName
#undef DGifOpen
extern "C"
    declare function DGifOpenFileName(byval GifFileName as const zstring ptr, byval err_c as long ptr) as GifFileType ptr
    declare function DGifOpen(byval userPtr as any ptr, byval readFunc as InputFunc, byval err_c as long ptr) as GifFileType ptr
end extern
#endif

namespace ext.gfx.gif

private function loadFrame( byval tgif as GifFileType ptr, byval fn as uinteger ) as ext.gfx.Image ptr

    var dstc = 0u
    var srcindex = tgif->SavedImages[fn].RasterBits
    var cmap = tgif->SColorMap->Colors
    if tgif->SavedImages[fn].ImageDesc.ColorMap <> null then
        cmap = tgif->SavedImages[fn].ImageDesc.ColorMap->Colors
    end if
    var w = tgif->SavedImages[fn].ImageDesc.Width
    var h = tgif->SavedImages[fn].ImageDesc.Height
    var ret = new ext.gfx.Image(w,h)
    var dst = ret->Pixels
    for n as uinteger = 0 to (w*h) -1
        dst[dstc] = rgb(cmap[srcindex[n]].red,cmap[srcindex[n]].green,cmap[srcindex[n]].blue)
        dstc += 1
    next

    return ret

end function

private function gif_input_func cdecl ( byval g as GifFileType ptr, byval b as GifByteType ptr, byval s as long ) as long

    var f = cast(File ptr,g->userData)
    f->get(,*b,s)
    return s

end function

function load( byref fn as ext.File, byval t as target_e ) as ext.gfx.Image ptr

    if fn.open() = true then 
        'print "1 didn't open file"
        return null
    end if

    dim as long dgif_error
    var tgif = DGifOpen(@fn,@gif_input_func, @dgif_error)

    if tgif = 0 then 
        'print "1 tgif is 0, error is: ", *(GifErrorString())
        return null
    end if

    var slurp_ret = DGifSlurp( tgif )
    if slurp_ret <> GIF_OK then 
        'print "1 slurp_ret is: ", slurp_ret
        return null
    end if

    fn.close()

    return loadFrame(tgif,0)

end function

function loadAll( byref fn as const string, byref num_img as uinteger ) as ext.gfx.Image ptr ptr

    dim as long dgif_error
    var tgif = DGifOpenFilename(fn, @dgif_error)
    
    if tgif = 0 then 
        'print "2 tgif is 0, error is: ", *(GifErrorString())
        return null
    end if
    
    var slurp_ret = DGifSlurp( tgif )
    
    if slurp_ret <> GIF_OK then 
        'print "2 slurp_ret is: ", slurp_ret
        return null

    end if

    num_img = tgif->ImageCount
    var ret = new ext.gfx.Image ptr[num_img]

    for n as long = 0 to num_img -1
        ret[n] = loadFrame(tgif,n)
    next

    return ret

end function

end namespace

