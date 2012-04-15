''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
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

# include once "ext/graphics/manip.bi"

namespace ext.gfx

sub Scale2X( byref dst as fb.image ptr = 0, byref src as const fb.image ptr, byref positx as integer, byref posity as integer )
    
    dim as uinteger ptr srcptr = FBEXT_FBGFX_PIXELPTR( uinteger, src )
    
    static as uinteger ptr dstptr
    
    static as integer x2, y2, b, d, e, f, h, e0, e1, e2, e3, dw, dh
    static as uinteger transcol
    
    if dst = 0 then
        dstptr = screenptr
        screeninfo dw,dh
        transcol = RGB(255,0,255)
    else
        dstptr = FBEXT_FBGFX_PIXELPTR( uinteger, dst )
        dw = dst->width
        dh = dst->height
    end if


    for y as integer = 0 to src->height-1
        
        for x as integer = 0 to src->width-1
            
            x2 = (x * 2) + positx

            y2 = (y * 2) + posity
            
            if y>0 then
                b = *cast(uinteger ptr, cast(ubyte ptr, srcptr) + (y-1) * src->pitch + (x) * src->bpp)
            else
                b = 0
            end if
            
            if x>0 then
                d = *cast(uinteger ptr, cast(ubyte ptr, srcptr) + (y) * src->pitch + (x-1) * src->bpp)
            else
                d = 0
            end if
            
            e = *cast(uinteger ptr, cast(ubyte ptr, srcptr) + (y) * src->pitch + (x) * src->bpp)
            
            if x<src->width-1 then
                f = *cast(uinteger ptr, cast(ubyte ptr, srcptr) + (y) * src->pitch + (x+1) * src->bpp)
            else
                f = 0
            end if
            
            if y<src->height-1 then
                h = *cast(uinteger ptr, cast(ubyte ptr, srcptr) + (y+1) * src->pitch + (x) * src->bpp)
            else
                h = 0
            end if
            
            if b <> h and d <> f then
                
                if d = b then 
                    e0 = d 
                else 
                    e0 = e
                end if
                
                if b = f then 
                    e1 = f 
                else 
                    e1 = e
                end if
                
                if d = h then
                    e2 = d 
                else 
                    e2 = e
                end if
                
                if h = f then 
                    e3 = f 
                else 
                    e3 = e
                end if
                
            else

                e0 = e

                e1 = e

                e2 = e

                e3 = e

            end if
            
            if dst = 0 then

                if x2<dw and y2<dh then
                    if e0 <> transcol then
                        dstptr[ ((y2) * dw ) + (x2) ] = e0
                    end if
                end if
                
                if x2<dw-1 and y2<dh then
                    if e1 <> transcol then
                        dstptr[ ((y2) * dw ) + (x2+1) ] = e1
                    end if
                end if
                
                if x2<dw and y2<dh-1 then
                    if e2 <> transcol then
                        dstptr[ ((y2+1) * dw ) + (x2) ] = e2
                    end if
                end if
                
                if x2<dw-1 and y2<dh-1 then
                    if e3<> transcol then
                        dstptr[ ((y2+1) * dw ) + (x2+1) ] = e3
                    end if
                end if
            
            else

                if x2<dst->width and y2<dst->height then
                    *cast(uinteger ptr, cast(ubyte ptr, dstptr) + (y2) * dst->pitch + (x2) * dst->bpp) = e0
                end if
                
                if x2<dst->width-1 and y2<dst->height then
                    *cast(uinteger ptr, cast(ubyte ptr, dstptr) + (y2) * dst->pitch + (x2+1) * dst->bpp) = e1
                end if
                
                if x2<dst->width and y2<dst->height-1 then
                    *cast(uinteger ptr, cast(ubyte ptr, dstptr) + (y2+1) * dst->pitch + (x2) * dst->bpp) = e2
                end if
                
                if x2<dst->width-1 and y2<dst->height-1 then
                    *cast(uinteger ptr, cast(ubyte ptr, dstptr) + (y2+1) * dst->pitch + (x2+1) * dst->bpp) = e3
                end if

            end if
        next
        
    next
    
end sub

end namespace
