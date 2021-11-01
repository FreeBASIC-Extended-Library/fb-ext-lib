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
#include once "ext/math/matrix.bi"

namespace ext.gfx

    '' :::::
    sub Rotate( byref dst as IMAGE ptr, byref src as const IMAGE ptr, byref positx as integer, byref posity as integer, byref angle as integer )

        if (src = null) then exit sub

        static as integer x, mx, y, my, col, dw, dh, xput, yput
        static as single nytc, nyts
        static as ext.math.matrix tmat
        static as ulong transcol
        static as ulong ptr dstptr, srcptr

        transcol = rgba(255,0,255,0)

        if dst = 0 then
            dstptr = screenptr
            screeninfo dw,dh
        else
            dstptr = dst->Pixels
            dw = dst->width
            dh = dst->height
        end if

        srcptr = src->Pixels

        dim as integer iwidth = src->width
        dim as integer iheight= src->height
        dim as integer iw2 = src->width\2
        dim as integer ih2 = src->height\2

        tmat.LoadIdentity
        tmat.Translate(iw2, ih2, 0.0)
        tmat.Rotate(0, 0, angle)
        tmat.Translate(-iw2, -ih2, 0.0)

        dim as integer posx = tmat.position.x
        dim as integer posy = tmat.position.y

        dim as single tux = tmat.up.x
        dim as single tuy = tmat.up.y
        dim as single trx = tmat.right.x
        dim as single try = tmat.right.y

        for y = 0 to iheight-1

            yput = y + posity
            if yput>-1 and yput<dh then

                nytc = y*tux + posx
                nyts = y*tuy + posy

                for x = 0 to iwidth-1

                    xput = x + positx
                    if xput>-1 and xput<dw then

                        mx = x*trx + nytc
                        my = x*try + nyts

                        if mx>-1 and my>-1 and mx<src->width and my<src->height then

                            col = *cast(ulong ptr, cast(ubyte ptr, srcptr) + my * src->pitch + mx * src->bpp )
                        else
                            col = transcol
                        end if

                        if dst = 0 then
                            if col<>transcol then
                                dstptr[ (yput * dw ) + xput ] = col
                            end if
                        else
                            *cast(ulong ptr, cast(ubyte ptr, dstptr) + yput * dst->pitch + xput * dst->bpp) = col
                        end if

                    end if
                next

            end if
        next

    end sub

end namespace 'ext.gfx
