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

#define FBEXT_BUILD_NO_GFX_LOADERS 1
#include once "ext/graphics/image.bi"
# include once "ext/graphics/bmp.bi"
#include once "ext/algorithms/detail/common.bi"

namespace ext.gfx.bmp

    enum bmp_types
        WIN_BMP = &h4d42
        OS2_BMP_ARR = &h4142
        OS2_CLR_ICO = &h4943
        OS2_CLR_PTR = &h5043
        OS2_ICO = &h4349
        OS2_PTR = &h5450
    end enum

    enum bmp_compression_types
        BI_RGB = 0
        BI_RLE8
        BI_RLE4
        BI_BITFIELDS
        BI_JPEG
        BI_PNG
        BI_ALPHABITFIELDS
    end enum
        

    ''type: FileHeader
    ''Provided for users wanting to write bmp manipulation routines
    type FileHeader field = 1
        as ushort       mark
        as ulong     size
        As ushort       res1, res2
        As ulong     offset
    end type

    ''type: InfoHeader
    ''Provided for users wanting to write bmp manipulation routines
    type InfoHeader field = 1
        as ulong     size
        As long      w, h
        As short        planes, bitCount
        As ulong     compression, sizeImage
        As long      ppmX, ppmY
        As ulong     used, important
    end type

    ''type: bmp_header
    ''Provided for users wanting to write bmp manipulation routines
    type bmp_header field = 1
        As FileHeader   bmfh
        As InfoHeader   bmih
    end type

    '' :::::
private sub rowconvert1to32( byval crow as ubyte ptr, byval rowsize as ulong, byval dest as ulong ptr, byval y as ulong, byval p as ulong, byval pal as ulong ptr ) 'CAW!

    var x = 0
    for c as ulong = 0 to rowsize
        var p1 = (crow[c] and &b10000000) shr 7
        var p2 = (crow[c] and &b01000000) shr 6
        var p3 = (crow[c] and &b00100000) shr 5
        var p4 = (crow[c] and &b00010000) shr 4
        var p5 = (crow[c] and &b00001000) shr 3
        var p6 = (crow[c] and &b00000100) shr 2
        var p7 = (crow[c] and &b00000010) shr 1
        var p8 = (crow[c] and &b00000001)
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p1]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p2]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p3]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p4]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p5]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p6]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p7]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p8]
        x += 1
    next

end sub

private sub rowconvert2to32( byval crow as ubyte ptr, byval rowsize as uinteger, byval dest as ulong ptr, byval y as uinteger, byval p as uinteger, byval pal as ulong ptr ) 'CAW!

    var x = 0
    for c as ulong = 0 to rowsize
        var p1 = (crow[c] and &b11000000) shr 6
        var p2 = (crow[c] and &b00110000) shr 4
        var p3 = (crow[c] and &b00001100) shr 2
        var p4 = (crow[c] and &b00000011)
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p1]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p2]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p3]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p4]
        x += 1
    next

end sub

private sub rowconvert4to32( byval crow as ubyte ptr, byval rowsize as ulong, byval dest as ulong ptr, byval y as ulong, byval p as ulong, byval pal as ulong ptr ) 'CAW!

    var x = 0
    for c as ulong = 0 to rowsize
        var p1 = (crow[c] and &b11110000) shr 4
        var p2 = crow[c] and &b00001111
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p1]
        x += 1
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[p2]
        x += 1
    next

end sub

private sub rowconvert8to32( byval crow as ubyte ptr, byval rowsize as ulong, byval dest as ulong ptr, byval y as ulong, byval p as ulong, byval pal as ulong ptr ) 'CAW!

    for x as ulong = 0 to rowsize
        *(dest+culng((y * p + x * 4)/4)) = &hff000000 or pal[crow[x]] 'CAW!
    next

end sub
    
private sub rowconvert16to32( byval crow as ubyte ptr, byval rowsize as ulong, byval dest as ulong ptr, byval y as ulong, byval p as ulong, byval alp as ulong, byval bm as ulong ptr )
    var ccnt = 0  : var ccolr = 0
    var ccolg = 0 : var ccolb = 0
    var cola = 0  : var colb = 0
    var x = 0     : var ccola = 255
    for m as ulong = 0 to rowsize
        select case ccnt
        case 0
            cola = crow[m] : ccnt += 1 'CAW!
        case 1
            colb = crow[m] 'CAW!
            var colc = (colb shl 8) OR cola
            if alp = BI_BITFIELDS then '565
                ccolb = ((colc and bm[0]) shr 11)  * 255/31
                ccolg = ((colc and bm[1]) shr 5) * 255/63
                ccolr = (colc And bm[2]) * 255/31
            else 'x555
                ccolr = ((colc shr 10) and &b11111) * 255/31
                ccolg = ((colc shr 5) and &b11111) * 255/31
                ccolb = ((colc) And &b11111) * 255/31
                ccola = (colc shr 15) * 255
            end if
            *(dest+culng((y * p + x * 4)/4)) = rgba(ccolr,ccolg,ccolb,ccola)
            ccnt = 0
            x += 1
        end select
    next
end sub

private sub rowconvert24to32( byval crow as ubyte ptr, byval rowsize as ulong, byval dest as ulong ptr, byval y as ulong, byval p as ulong ) 'CAW!
    var ccnt = 0  : var ccolr = 0
    var ccolg = 0 : var ccolb = 0
    var x = 0
    for m as ulong = 0 to rowsize
        select case ccnt
        case 0
            ccolb = crow[m] : ccnt += 1 'CAW!
        case 1
            ccolg = crow[m] : ccnt += 1 'CAW!
        case 2
            ccolr = crow[m] 'CAW!
            *(dest + culng((y * p + x * 4)/4)) = rgb(ccolr,ccolg,ccolb)
            ccnt = 0
            x += 1
        end select
    next
end sub 

function load ( byref hFile as File, byval __not_used as target_e = TARGET_FBNEW ) as Image ptr

    dim hdr as bmp_header
    dim bpal as ulong ptr
    
    if hfile.open() = true then return null
    hFile.get(,*cast(ubyte ptr,@hdr),sizeof(hdr))
    
    'only windows bmp supported at this time.
    
    if hdr.bmfh.mark <> WIN_BMP then return null
    
    'only no compression supported for now
    if hdr.bmih.compression <> BI_RGB andalso hdr.bmih.bitCount <> 16 then return null
    
    var ret = new Image(hdr.bmih.w,hdr.bmih.h)
    
    var rowsize = culng(((hdr.bmih.bitCount*hdr.bmih.w+31)\32)*4)
    
    var crow = new ubyte[rowsize] 'CAW!
    var y = hdr.bmih.h - 1

    if ret = null or crow = null then return null 'CAW!

    dim bitmasks as ulong ptr = null

    if hdr.bmih.compression = BI_BITFIELDS then
        bitmasks = new ulong[3]
        hFile.get(,*bitmasks,3)
    elseif hdr.bmih.compression = BI_ALPHABITFIELDS then
        bitmasks = new ulong[4]
        hFile.get(,*bitmasks,4)
    end if

    if hdr.bmih.used > 0 then
        bpal = new ulong[hdr.bmih.used]
        if bpal = null then return null
        hFile.get(,*bpal,hdr.bmih.used)
    end if

    var locx = hFile.loc()

    if locx <> hdr.bmfh.offset then hFile.seek = hdr.bmfh.offset
    
    for n as ushort = 0 to hdr.bmih.h -1
        hFile.get(,*crow,rowsize) 'CAW!
        if hdr.bmih.bitCount <> ret->bpp *8 then
            'convert
            if ret->bpp = 4 then
                select case hdr.bmih.bitCount
                case 1
                    rowconvert1to32(crow,hdr.bmih.w\8,ret->Pixels(),y,ret->pitch(),bpal)
                case 2
                    rowconvert2to32(crow,hdr.bmih.w\4,ret->Pixels(),y,ret->pitch(),bpal)
                case 4
                    rowconvert4to32(crow,hdr.bmih.w\2,ret->Pixels(),y,ret->pitch(),bpal)
                case 8
                    rowconvert8to32(crow,hdr.bmih.w,ret->Pixels(),y,ret->pitch(),bpal)
                case 16
                    rowconvert16to32(crow,hdr.bmih.w*2,ret->Pixels(),y,ret->pitch(),hdr.bmih.compression,bitmasks)
                case 24
                    rowconvert24to32(crow,hdr.bmih.w*3,ret->Pixels(),y,ret->pitch())
                case else
                    return null
                end select
            end if
        else
            memcpy(ret->Pixels()+(n*ret->pitch()),crow,hdr.bmih.w*4) 'CAW!
        end if
        y -= 1
    next
    
    if bitmasks <> null then delete[] bitmasks
    delete[] crow 'CAW!
    delete[] bpal
    hFile.close()

    return ret

end function

end namespace 'ext.gfx.bmp

