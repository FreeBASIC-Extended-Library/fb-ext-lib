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

#include once "ext/graphics/manip.bi"
#include once "ext/graphics/primitives.bi"

namespace ext.gfx
    
	'' :::::
	sub Triangle ( byval dst as FB.IMAGE ptr = 0, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval x3 as integer, byval y3 as integer, byval col as uinteger = rgba(255,255,255,255) )
        
		dim as uinteger ptr dstptr
        
		dim as integer x, y, dw, dh
        
		dim as integer dx1, dx2, dx3, dy1, dy2, dy3, sx, ex
        
		dim as single d1, d2, d3, lx, rx
        
		if dst = 0 then
			dstptr = screenptr
			screeninfo dw,dh
        else
			dstptr = FBEXT_FBGFX_PIXELPTR( uinteger, dst )
			dw=dst->width
			dh = dst->height
        end if
        
		if y2 < y1 then
			swap y1, y2
			swap x1, x2
        end if
        
		if y3 < y1 then
			swap y3, y1
			swap x3, x1
        end if
        
		if y3 < y2 then
			swap y3, y2
			swap x3, x2
        end if
        
		dx1 = x2 - x1
		dy1 = y2 - y1
		if dy1 <> 0 then
			d1 = dx1 / dy1
        else
			d1 = 0
        end if
        
		dx2 = x3 - x2
		dy2 = y3 - y2
		if dy2 <> 0 then
			d2 = dx2 / dy2
        else
			d2 = 0
        end if
        
		dx3 = x1 - x3
		dy3 = y1 - y3
		if dy3 <> 0 then
			d3 = dx3 / dy3
        else
			d3 = 0
        end if
        
		lx = x1
		rx = x1
        
		if dst = 0 then
			for y = y1 to y2 - 1
				if y>-1 and y<dh then
					sx = lx
					ex = rx
					if sx>ex then swap sx,ex
					if sx<0 then sx = 0
					if ex>dw-1 then ex=dw-1
					for x = sx to ex
						dstptr[ (y * dw ) + x ] = col
                    next
                end if
				lx += d1
				rx += d3
            next
            
			lx = x2
			for y = y2 to y3
				if y>-1 and y<dh then
					sx = lx
					ex = rx
					if sx>ex then swap sx,ex
					if sx<0 then sx = 0
					if ex>dw-1 then ex=dw-1
					for x = sx to ex
						dstptr[ (y * dw ) + x ] = col
                    next
                end if
				lx += d2
				rx += d3
            next
            
        else
			for y = y1 to y2 - 1
				if y>-1 and y<dh then
					sx = lx
					ex = rx
					if sx>ex then swap sx,ex
					if sx<0 then sx = 0
					if ex>dw-1 then ex=dw-1
					for x = sx to ex
						*cast(uinteger ptr, cast(ubyte ptr, dstptr) + y * dst->pitch + x * dst->bpp) = col
                    next
                end if
				lx += d1
				rx += d3
            next
            
			lx = x2
			for y = y2 to y3
				if y>-1 and y<dh then
					sx = lx
					ex = rx
					if sx>ex then swap sx,ex
					if sx<0 then sx = 0
					if ex>dw-1 then ex=dw-1
					for x = sx to ex
						*cast(uinteger ptr, cast(ubyte ptr, dstptr) + y * dst->pitch + x * dst->bpp) = col
                    next
                end if
				lx += d2
				rx += d3
            next
            
        end if
        
    end sub
    
	sub Triangle( byval dst as FB.IMAGE ptr = 0, byref p1 as ext.math.vector2d, byref p2 as ext.math.vector2d, byref p3 as ext.math.vector2d, byval col as uinteger = rgba(255,255,255,255) )
        
		Triangle( dst, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, col )
        
    end sub
    
    
    sub TriangleASM( byval dst as FB.IMAGE ptr = 0, byval x1 as integer, byval y1 as integer, byval x2 as integer, byval y2 as integer, byval x3 as integer, byval y3 as integer, byval col as uinteger = rgba(255,255,255,255) )
        
        dim as any ptr dstptr
        dim as integer dw, dh, dp
        
        if dst = 0 then
            dstptr = screenptr
            screeninfo dw,dh
            dp = dw * 4
        else
            dstptr = cast( any ptr, dst + 1 )
            dw = dst->width
            dh = dst->height
            dp = dst->pitch
        end if
        
        if y2 < y1 then
            swap y1, y2
            swap x1, x2
        end if
        
        if y3 < y1 then
            swap y3, y1
            swap x3, x1
        end if
        
        if y3 < y2 then
            swap y3, y2
            swap x3, x2
        end if
        
        dim as single d1, d2, d3
        
        scope
            dim as integer dx1, dy1
            dx1 = x2 - x1
            dy1 = y2 - y1
            if dy1 <> 0 then
                d1 = dx1 / dy1
            else
                d1 = 0
            end if
        end scope
        
        scope
            dim as integer dx2, dy2
            dx2 = x3 - x2
            dy2 = y3 - y2
            if dy2 <> 0 then
                d2 = dx2 / dy2
            else
                d2 = 0
            end if
        end scope
        
        scope
            dim as integer dx3, dy3
            dx3 = x1 - x3
            dy3 = y1 - y3
            if dy3 <> 0 then
                d3 = dx3 / dy3
            else
                d3 = 0
            end if
        end scope
        
        dim as single lx, rx
        
        lx = x1
        rx = x1
        
        dim as single  lx_incr = any
        dim as single  rx_incr = any
        dim as integer y_start  = any
        dim as integer y_end    = any
        
        for t as integer = 0 to 1
            if t = 0 then
                lx_incr = d1
                rx_incr = d3
                y_start = y1
                y_end   = y2 - 1
            else
                lx_incr = d2
                rx_incr = d3
                y_start = y2
                y_end   = y3
                lx      = x2
            end if
            
            dim as any ptr __dstptr = dstptr + (y_start * dp)
            
            if y_end >= dh then y_end = dh - 1
            
            dim as integer y_draw_count = (y_end - y_start) + 1
            if y_draw_count > 0 then
                dim as integer y = any
                
                asm
                    mov edx, dword ptr [y_draw_count]
                    
                    mov eax, dword ptr [y_start]
                    mov dword ptr [y], eax
                    
                    fld dword ptr [lx_incr]
                    fld dword ptr [rx_incr]
                    fld dword ptr [lx]
                    fld dword ptr [rx]
                    
                    y_inner:
                    
                    cmp dword ptr [y], -1
                    jle no_x_draw
                    sub esp, 4
                    
                    fld st(1)
                    fistp dword ptr [esp]
                    mov esi, dword ptr [esp]
                    
                    fist dword ptr [esp]
                    mov edi, dword ptr [esp]
                    
                    add esp, 4
                    cmp esi, edi
                    jle no_swap
                    
                    mov eax, esi
                    mov esi, edi
                    mov edi, eax
                    
                    no_swap:
                    
                    cmp esi, 0
                    jge no_clip_start_x
                    
                    mov esi, 0
                    
                    no_clip_start_x:
                    
                    mov eax, dword ptr [dw]
                    cmp edi, eax
                    jl no_clip_end_x
                    
                    dec eax
                    mov edi, eax
                    
                    no_clip_end_x:
                    
                    mov ebx, esi
                    shl ebx, 2
                    add ebx, dword ptr [__dstptr]
                    mov ecx, edi
                    sub ecx, esi
                    mov eax, dword ptr [col]
                    inc ecx
                    jle no_x_draw
                    
                    x_inner:
                    
                    mov dword ptr [ebx], eax
                    add ebx, 4
                    dec ecx
                    jnz x_inner
                    
                    no_x_draw:
                    
                    fld st(3)
                    faddp st(2), st(0)
                    
                    fadd st(2)
                    
                    mov eax, dword ptr [dp]
                    add dword ptr [__dstptr], eax
                    
                    inc dword ptr [y]
                    
                    y_test:
                    dec edx
                    jnz y_inner
                    
                    fstp dword ptr [rx]
                    fstp dword ptr [lx]
                    
                    finit
                    
                end asm
            end if
        next t
        
    end sub
    
    sub TriangleASM( byval dst as FB.IMAGE ptr = 0, byref p1 as ext.math.vector2d, byref p2 as ext.math.vector2d, byref p3 as ext.math.vector2d, byval col as uinteger = rgba(255,255,255,255) )
        
		TriangleASM( dst, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, col )
        
    end sub

end namespace 'ext.gfx
