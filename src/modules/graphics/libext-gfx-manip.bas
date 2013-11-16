''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
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
# include once "ext/graphics/manip.bi"
#include once "crt.bi"

namespace ext.gfx

        union _color_t
        as uinteger colour 'color value
        type
                as ubyte b 'color blue  component
                as ubyte g 'color green component
                as ubyte r 'color red   component
                as ubyte a 'color alpha component
        end type
        end union

        function grayscale ( byval img as image ptr, byval skip_trans as ext.bool = ext.bool.true ) as image ptr

                #define red_m (299/1000)
                #define gre_m (587/1000)
                #define blu_m (114/1000)

                if img = ext.null then return ext.null
                if img->bpp < 4 then return ext.null

                var ret_img = new Image( img->width, img->height)
                var src = img->Pixels
                var ret = ret_img->Pixels
                dim luma as _color_t

                for y as uinteger = 0 to img->height
                        for x as uinteger = 0 to img->width
                                luma.colour = *cast( uinteger ptr, cast( ubyte ptr, src ) + y * img->pitch + x * img->bpp )
                                if skip_trans = true and luma.r = 255 and luma.g = 0 and luma.b = 255 then
                                        *cast( uinteger ptr, cast( ubyte ptr, ret ) + y * img->pitch + x * img->bpp ) = luma.colour
                                else
                                        'TRAAAAAANSFORM!!!!!
                                        var tmp = cubyte((luma.r * red_m) + _
                                                         (luma.g * gre_m) + _
                                                         (luma.b * blu_m))
                                        luma.r = tmp : luma.g = tmp : luma.b = tmp
                                        *cast( uinteger ptr, cast( ubyte ptr, ret ) + y * img->pitch + x * img->bpp ) = luma.colour
                                end if
                        next x
                next y
                return ret_img

        end function


        sub changeColor ( byref img as IMAGE ptr, byval from_ as uinteger, byval to_ as uinteger, byval include_alpha as ext.bool = ext.bool.false, byval is_font as ext.bool = ext.bool.false )

                if img = ext.null then exit sub
                if img->bpp < 4 then exit sub 'this procedure only operates on 24 & 32 bit bitmaps

                var pitch_ = img->width
                var height_ = img->height
                var len_data = pitch_ * height_
                var pixelptr = img->Pixels
                dim start_data as uinteger = 0

                if (is_font = ext.bool.true) then
                        start_data = pitch_

                end if

                for n as uinteger = start_data to len_data -1

                        var cur_color = cuint(0)
                        if include_alpha = ext.bool.true then
                                cur_color = pixelptr[n]

                        else
                                cur_color = pixelptr[n] and &h00FFFFFF

                        end if

                        if cur_color = from_ then
                                if include_alpha = ext.bool.true then
                                        pixelptr[n] = to_

                                else
                                        pixelptr[n] = (pixelptr[n] and &hFF000000) or to_

                                end if

                        end if

                next n

        end sub

        function flipVertical _
                ( _
                byval img as const image ptr _
                ) as image ptr

                dim as image ptr temp_img
                dim as ubyte ptr    p1
                dim as ubyte ptr    p2

                temp_img = new image( img->width, img->height )

                p1 = cptr( ubyte ptr, img->Pixels ) + ((img->height - 1) * img->pitch)
                p2 = cptr( ubyte ptr, temp_img->Pixels )

                for y as integer = 0 to img->height - 1
                        memcpy( p2, p1, img->pitch )
                        p1 -= img->pitch
                        p2 += img->pitch
                next y

                function = temp_img

        end function

        ''Function: flipHorizontal
        function flipHorizontal( byval src as const image ptr ) as image ptr

                var temp_img = new image( src->width, src->height )

                for d as integer = 0 to src->bpp - 1
                        for y as integer = 0 to src->height - 1
                                var dx = 0
                                for x as integer = src->width - 1 to 0 step -1
                                        pset *temp_img, (dx, y), point(x,y,*src)
                                        dx += 1
                                next x
                        next y
                next d

                function = temp_img

        end function

end namespace 'ext.gfx
