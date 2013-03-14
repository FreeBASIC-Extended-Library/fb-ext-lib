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

#define FBEXT_BUILD_NO_GFX_LOADERS 1
#include once "ext/graphics/image.bi"
#include once "ext/graphics/jpg.bi"
#include once "jpeglib.bi"

#undef null
#undef true
#undef false

#include once "ext/detail/common.bi"

namespace ext.gfx.jpg

'':::::
function load ( byref filename as const string, byval t as target_e ) as ext.gfx.Image ptr

    dim as FILE ptr fp = fopen( strptr(filename), "rb" )
    if( fp = null ) then return null

    dim jinfo as jpeg_decompress_struct
    dim jerr as jpeg_error_mgr
    dim row as JSAMPARRAY

    jpeg_create_decompress( @jinfo )

    jinfo.err = jpeg_std_error( @jerr )

    jpeg_stdio_src( @jinfo, fp )

    jpeg_read_header( @jinfo, cTRUE )

    jpeg_start_decompress( @jinfo )

    row = jinfo.mem->alloc_sarray(  cast( j_common_ptr, @jinfo ), _
                    JPOOL_IMAGE, _
                    jinfo.output_width * jinfo.output_components, _
                    1 )

    dim img as IMAGE ptr
    img = new image( jinfo.output_width, jinfo.output_height )

    var dst = cast(byte ptr, img->Pixels)

    dim as integer bpp
    screeninfo ,,,bpp

    do while jinfo.output_scanline < jinfo.output_height
            jpeg_read_scanlines( @jinfo, row, 1 )

        imageconvertrow( *row, 24, dst, bpp*8, jinfo.output_width )
        dst += img->pitch

    loop

    jinfo.mem->free_pool( cast(j_common_ptr, @jinfo ), JPOOL_IMAGE )

    jpeg_finish_decompress( @jinfo )
    jpeg_destroy_decompress( @jinfo )
    fclose( fp )

    return img

end function

end namespace
