''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

#define FBEXT_BUILD_NO_GFX_LOADERS
#include once "ext/graphics/manip.bi"

namespace ext.gfx
'' :::::
sub Intensify( byval dst as IMAGE ptr, byval src as const IMAGE ptr, byref positx as integer, byref posity as integer, byref intensity as integer )

    if src = null then exit sub

    static as ulong ptr dstptr, srcptr
    static as ulong transcol = RGBA(255,0,255,0)
    static as integer srcc
    dim as integer iwidth = src->width
    dim as integer iheight= src->height
    static as integer dw, dh, xput, yput
    static as integer sr, sg, sb, sa, na

    if dst = 0 then
        dstptr = screenptr
        screeninfo dw,dh
    else
        dstptr = dst->Pixels
        dw = dst->width
        dh = dst->height
    end if

    srcptr = src->Pixels

    for y as integer = 0 to iheight-1

        yput = y + posity
        if yput>-1 and yput<dh then

            for x as integer = 0 to iwidth-1
                xput = x + positx

                if xput>-1 and xput<dw then

                    srcc = *cast(ulong ptr, cast(ubyte ptr, srcptr) + y * src->pitch + x * src->bpp )

                    sr = ( ( srcc shr 16 ) and 255 )
                    sg = ( ( srcc shr  8 ) and 255 )
                    sb = ( ( srcc        ) and 255 )
                    sa = ( ( srcc shr 24 ) and 255 )

                    sr += intensity
                    if sr<0 then
                        sr = 0
                    elseif sr>255 then
                        sr = 255
                    end if

                    sg += intensity
                    if sg < 0 then
                        sg = 0
                    elseif sg > 255 then
                        sg = 255
                    end if

                    sb += intensity
                    if sb < 0 then
                        sb = 0
                    elseif sb > 255 then
                       sb = 255
                    end if

                    if srcc <> transcol and sa > 0 then
                        if dst = 0 then
                            dstptr[ (yput * dw ) + xput ] = rgba( sr, sg, sb, sa )
                        else
                            *cast(ulong ptr, cast(ubyte ptr, dstptr) + yput * dst->pitch + xput * dst->bpp) = rgba( sr, sg, sb, sa )
                        end if
                    end if

                end if
            next
        end if
    next

end sub

end namespace 'ext.gfx
