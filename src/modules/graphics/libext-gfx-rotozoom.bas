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

#define FBEXT_BUILD_NO_GFX_LOADERS
#include once "ext/graphics/manip.bi"
#include once "ext/math/detail/common.bi"

namespace ext.gfx
    '' :::::
    sub RotoZoom( byref dst as IMAGE ptr = 0, byref src as const IMAGE ptr, byref positx as integer, byref posity as integer, byref angle as integer, byref zoomx as single, byref zoomy as single )

        static as integer nx, ny, mx, my, col
        static as single nxtc, nxts, nytc, nyts
        static as integer sw2, sh2, dw, dh
        static as single tc,ts
        static as ulong ptr dstptr, srcptr
        static as integer xput, yput, startx, endx, starty, endy
        static as ulong transcol
        static as integer x(3), y(3), xa, xb, ya, yb

        if zoomx <= 0 or zoomy <= 0 then exit sub

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

        sw2 = src->width\2
        sh2 = src->height\2

        tc = cos( angle * ext.math.pi_180 )
        ts = sin( angle * ext.math.pi_180 )

        xa = ((sw2 * zoomx)*tc + (sh2  * zoomy)*ts)
        ya = ((sh2 * zoomy)*tc - (sw2  * zoomx)*ts)

        xb = ((sh2 * zoomx)*ts - (sw2  * zoomy)*tc)
        yb = ((sw2 * zoomy)*ts + (sh2  * zoomx)*tc)

        x(0) = sw2-xa
        x(1) = sw2+xa
        x(2) = sw2-xb
        x(3) = sw2+xb
        y(0) = sh2-ya
        y(1) = sh2+ya
        y(2) = sh2-yb
        y(3) = sh2+yb

        for i as integer = 0 to 3
            for j as integer = i to 3
                if x(i)>=x(j) then
                    swap x(i), x(j)
                end if
            next
        next
        startx = x(0)
        endx = x(3)

        for i as integer = 0 to 3
            for j as integer = i to 3
                if y(i)>=y(j) then
                    swap y(i), y(j)
                end if
            next
        next
        starty = y(0)
        endy = y(3)

        positx-=sw2
        posity-=sh2
        if posity+starty<0 then starty = -posity
        if positx+startx<0 then startx = -positx
        if posity+endy<0 then endy = -posity
        if positx+endx<0 then endx = -positx

        if positx+startx>(dw-1) then startx = (dw-1)-positx
        if posity+starty>(dh-1) then starty = (dh-1)-posity
        if positx+endx>(dw-1) then endx = (dw-1)-positx
        if posity+endy>(dh-1) then endy = (dh-1)-posity
        if startx = endx or starty = endy then exit sub

        for y as integer = starty to endy

            yput = y + posity

            if yput>-1 and yput<dh then

                ny = y - sh2

                nytc = (ny * tc) / zoomy
                nyts = (ny * ts) / zoomy

                for x as integer = startx to endx

                    xput = x+positx

                    if xput>-1 and xput<dW then

                        nx = x - sw2

                        nxtc = (nx * tc) / zoomx
                        nxts = (nx * ts) / zoomx

                        mx = (nxtc - nyts) + sw2
                        my = (nytc + nxts) + sh2

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

#ifdef __FB_64BIT__
  sub RotoZoomASM( byref dst as IMAGE ptr = 0, byref src as const IMAGE ptr, byval positx as integer, byval posity as integer, byref angle as integer, byref zoomx as single, byref zoomy as single = 0, byval transcol as uinteger  = &hffff00ff )
  end sub
#else
  #ifdef __FB_ARM__
    sub RotoZoomASM( byref dst as IMAGE ptr = 0, byref src as const IMAGE ptr, byval positx as integer, byval posity as integer, byref angle as integer, byref zoomx as single, byref zoomy as single = 0, byval transcol as uinteger  = &hffff00ff )
    end sub
  #else
    sub RotoZoomASM( byref dst as IMAGE ptr = 0, byref src as const IMAGE ptr, byval positx as integer, byval posity as integer, byref angle as integer, byref zoomx as single, byref zoomy as single = 0, byval transcol as uinteger  = &hffff00ff )

        'Rotozoom for 32-bit FB.Image by Dr_D(Dave Stanley) and yetifoot(Simon Nash)
        'No warranty implied... use at your own risk ;)

        static as integer mx, my, col, nx, ny
        static as single nxtc, nxts, nytc, nyts
        static as single tcdzx, tcdzy, tsdzx, tsdzy
        static as integer sw2, sh2, dw, dh
        static as single tc, ts, _mx, _my
        static as uinteger ptr dstptr, srcptr, odstptr
        static as integer xput, yput, startx, endx, starty, endy
        static as integer x(3), y(3), xa, xb, ya, yb, lx, ly
        static as ubyte ptr srcbyteptr, dstbyteptr
        static as integer dstpitch, srcpitch, srcbpp, dstbpp, srcwidth, srcheight

        if zoomx = 0 then exit sub
        if zoomy = 0 then zoomy = zoomx

        if dst = 0 then
            dstptr = screenptr
            odstptr = dstptr
            screeninfo dw,dh,,,dstpitch
        else
            dstptr = dst->Pixels
            odstptr = dstptr
            dw = dst->width
            dh = dst->height
            dstbpp = dst->bpp
            dstpitch = dst->pitch
        end if

        srcptr = src->Pixels
        srcbyteptr = cast( ubyte ptr, srcptr )
        dstbyteptr = cast( ubyte ptr, dstptr )

        sw2 = src->width\2
        sh2 = src->height\2
        srcbpp = src->bpp
        srcpitch = src->pitch
        srcwidth = src->width
        srcheight = src->height

        tc = cos( angle * ext.math.pi_180 )
        ts = sin( angle * ext.math.pi_180 )
        tcdzx = tc/zoomx
        tcdzy = tc/zoomy
        tsdzx = ts/zoomx
        tsdzy = ts/zoomy

        xa = sw2 * tc * zoomx + sh2  * ts * zoomx
        ya = sh2 * tc * zoomy - sw2  * ts * zoomy

        xb = sh2 * ts * zoomx - sw2  * tc * zoomx
        yb = sw2 * ts * zoomy + sh2  * tc * zoomy

        x(0) = sw2-xa
        x(1) = sw2+xa
        x(2) = sw2-xb
        x(3) = sw2+xb
        y(0) = sh2-ya
        y(1) = sh2+ya
        y(2) = sh2-yb
        y(3) = sh2+yb

        for i as integer = 0 to 3
            for j as integer = i to 3
                if x(i)>=x(j) then
                    swap x(i), x(j)
                end if
            next
        next
        startx = x(0)
        endx = x(3)

        for i as integer = 0 to 3
            for j as integer = i to 3
                if y(i)>=y(j) then
                    swap y(i), y(j)
                end if
            next
        next
        starty = y(0)
        endy = y(3)

        positx-=sw2
        posity-=sh2
        if posity+starty<0 then starty = -posity
        if positx+startx<0 then startx = -positx
        if posity+endy<0 then endy = -posity
        if positx+endx<0 then endx = -positx

        if positx+startx>(dw-1) then startx = (dw-1)-positx
        if posity+starty>(dh-1) then starty = (dh-1)-posity
        if positx+endx>(dw-1) then endx = (dw-1)-positx
        if posity+endy>(dh-1) then endy = (dh-1)-posity
        if startx = endx or starty = endy then exit sub


        xput = (startx + positx) * 4
        yput = starty + posity
        ny = starty - sh2
        nx = startx - sw2
        nxtc = (nx * tcdzx)
        nxts = (nx * tsdzx)
        nytc = (ny * tcdzy)
        nyts = (ny * tsdzy)
        dstptr += dstpitch * yput \ 4

        dim as integer y_draw_len = (endy - starty) + 1
        dim as integer x_draw_len = (endx - startx) + 1


        'and we're off!
        asm
            mov edx, dword ptr [y_draw_len]

            test edx, edx ' 0?
            jz y_end      ' nothing to do here

            fld dword ptr[tcdzy]
            fld dword ptr[tsdzy]
            fld dword ptr [tcdzx]
            fld dword ptr [tsdzx]

            y_inner:

            fld dword ptr[nxtc]     'st(0) = nxtc, st(1) = tsdzx, st(2) = tcdzx, st(3) = tsdzy, st(4) = tcdzy
            fsub dword ptr[nyts]    'nxtc-nyts
            fiadd dword ptr[sw2]    'nxtc-nyts+sw2

            fld dword ptr[nxts]     'st(0) = nxts, st(1) = tsdzx, st(2) = tcdzx, st(3) = tsdzy, st(4) = tcdzy
            fadd dword ptr[nytc]    'nytc+nxts
            fiadd dword ptr[sh2]    'nxts+nytc+sh2
            'fpu stack returns to: st(0) = tsdzx, st(1) = tcdzx, st(2) = tsdzy, st(3) = tcdzy

            mov ebx, [xput]
            add ebx, [dstptr]

            mov ecx, dword ptr [x_draw_len]

            test ecx, ecx ' 0?
            jz x_end      ' nothing to do here

            x_inner:

            fist dword ptr [my] ' my = _my

            fld st(1)           ' mx = _mx
            fistp dword ptr [mx]

            mov esi, dword ptr [mx]         ' esi = mx
            mov edi, dword ptr [my]         ' edi = my

            ' bounds checking
            test esi, esi       'mx<0?
            js no_draw
            'mov esi, 0

            test edi, edi
            'mov edi, 0
            js no_draw          'my<0?

            cmp esi, dword ptr [srcwidth]   ' mx >= width?
            jge no_draw
            cmp edi, dword ptr [srcheight]  ' my >= height?
            jge no_draw

            ' calculate position in src buffer
            mov eax, dword ptr [srcbyteptr] ' eax = srcbyteptr
            imul edi, dword ptr [srcpitch]  ' edi = my * srcpitch
            add eax, edi
            shl esi, 2
            ' eax becomes src pixel color
            mov eax, dword ptr [eax+esi]
            cmp eax, [transcol]
            je no_draw

            ' draw pixel
            mov dword ptr [ebx], eax
            no_draw:

            fld st(3)
            faddp st(2), st(0) ' _mx += tcdzx
            fadd st(0), st(2) ' _my += tsdzx

            ' increment the output pointer
            add ebx, 4

            ' increment the x loop
            dec ecx
            jnz x_inner

            x_end:

            fstp dword ptr [_my]
            fstp dword ptr [_mx]

            'st(0) = tsdzx, st(1) = tcdzx, st(2) = tsdzy, st(3) = tcdzy
            'nytc += tcdzy
            fld dword ptr[nytc]
            fadd st(0), st(4)
            fstp dword ptr[nytc]

            'st(0) = tsdzx, st(1) = tcdzx, st(2) = tsdzy, st(3) = tcdzy
            'nyts+=tsdzy
            fld dword ptr[nyts]
            fadd st(0), st(3)
            fstp dword ptr[nyts]

            'dstptr += dst->pitch
            mov eax, dword ptr [dstpitch]
            add dword ptr [dstptr], eax

            dec edx
            jnz y_inner

            y_end:

            finit
        end asm

    end sub
  #endif
#endif
end namespace 'ext.gfx
