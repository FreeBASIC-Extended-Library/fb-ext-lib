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

#include once "ext/graphics/image.bi"
#include once "ext/graphics/manip.bi"

namespace ext.gfx

    constructor Image ( byval w_ as uinteger, byval h_ as uinteger, byval def_color as uinteger = RGBA(255,0,255,255) )

        m_img = imagecreate( w_, h_, def_color )

    end constructor

    constructor Image ( byval _x_ as FB.IMAGE ptr )

        setImage( _x_ )

    end constructor

    operator Image.Let ( byval _x_ as FB.IMAGE ptr )

        setImage( _x_ )

    end operator

    sub Image.setImage( byval _x_ as FB.IMAGE ptr )

        if m_img = 0 then
            m_img = _x_
        else
            imagedestroy( m_img )
            m_img = _x_
        end if

    end sub

    constructor Image ( byref _x_ as Image )

        this.m_img = _x_.m_img
        _x_.m_img = 0

    end constructor

    constructor Image ( )
    'nop
    end constructor

    destructor Image ( )

        if m_img <> 0 then imagedestroy( m_img )

    end destructor

    property Image.isEmpty( ) as ext.bool

        return iif( m_img = 0, true, false )

    end property

    sub Image.Display( byval _dest_ as FB.IMAGE ptr, byval _x_ as integer, byval _y_ as integer, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0 )

    select case _method_
        case PSET_
            put _dest_, (_x_,_y_), m_img, PSET
        case PRESET_
            put _dest_, (_x_,_y_), m_img, PRESET
        case TRANS_
            put _dest_, (_x_,_y_), m_img, TRANS
        case AND_
            put _dest_, (_x_,_y_), m_img, AND
        case OR_
            put _dest_, (_x_,_y_), m_img, OR
        case XOR_
            put _dest_, (_x_,_y_), m_img, XOR
        case ALPHA_
            put _dest_, (_x_,_y_), m_img, ALPHA, _al
        end select

    end sub

    sub Image.Display( byval _dest_ as FB.IMAGE ptr, byref _pos as const ext.math.vec2i, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

        Display( _dest_, _pos.x, _pos.y, _method_, _al )

    end sub

    sub Image.Display( byval _x_ as integer, byval _y_ as integer, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

        Display( 0, _x_, _y_, _method_, _al )

    end sub

    sub Image.Display( byref _pos as const ext.math.vec2i, byval _method_ as ext.gfx.DrawMethods = XOR_, byval _al as integer = 0)

        Display( 0, _pos.x, _pos.y, _method_, _al )

    end sub

    function Image.height( ) as ext.SizeType

        return iif(m_img,m_img->height,0)

    end function

    function Image.width( ) as ext.SizeType

        return iif(m_img,m_img->width,0)

    end function

    function Image.pitch( ) as ext.SizeType

        return iif(m_img,m_img->pitch,0)

    end function

    function Image.bpp( ) as ext.SizeType

        return iif(m_img,m_img->bpp,0)

    end function

    operator Image.Cast( ) as FB.IMAGE ptr
        return m_img
    end operator

    function Image.Pixels( byref num_pixels as uinteger = 0 ) as uinteger ptr
        num_pixels = m_img->width * m_img->height
        return FBEXT_FBGFX_PIXELPTR(uinteger,m_img)
    end function


end namespace
