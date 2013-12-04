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

function load( byref fn as const string, byval t as target_e ) as ext.gfx.Image ptr

    var tgif = DGifOpenFilename(fn)
    if tgif = 0 then return null

    if DGifSlurp( tgif ) <> GIF_OK then return null

    var ret = new ext.gfx.Image(tgif->SWidth, tgif->SHeight)
    var dst = ret->Pixels
    var dstc = 0u
    var srcindex = tgif->SavedImages[0].RasterBits
    var cmap = tgif->SColorMap->Colors

    for n as uinteger = 0 to (tgif->SWidth * tgif->SHeight) -1
        dst[dstc] = rgb(cmap[srcindex[n]].red,cmap[srcindex[n]].green,cmap[srcindex[n]].blue)
        dstc += 1
    next

    return ret

end function

end namespace

