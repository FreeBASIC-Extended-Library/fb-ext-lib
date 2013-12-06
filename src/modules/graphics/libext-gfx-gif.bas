''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
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
#include once "gif_lib.bi"

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

function load( byref fn as const string, byval t as target_e ) as ext.gfx.Image ptr

    var tgif = DGifOpenFilename(fn)
    if tgif = 0 then return null

    if DGifSlurp( tgif ) <> GIF_OK then return null

    return loadFrame(tgif,0)

end function

function loadAll( byref fn as const string, byref num_img as uinteger ) as ext.gfx.Image ptr ptr

    var tgif = DGifOpenFilename(fn)
    if tgif = 0 then return null

    if DGifSlurp( tgif ) <> GIF_OK then return null

    num_img = tgif->ImageCount
    var ret = new ext.gfx.Image ptr[num_img]

    for n as long = 0 to num_img -1
        ret[n] = loadFrame(tgif,n)
    next

    return ret

end function

end namespace

