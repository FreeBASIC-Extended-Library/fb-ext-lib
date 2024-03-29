''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''  * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
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
#include once "ext/graphics/tga.bi"
#include once "ext/graphics/manip.bi"
#include once "ext/file/file.bi"

#define DEFAULT_ALPHA_VALUE 255

#define R_SHIFT 0
#define G_SHIFT 8
#define B_SHIFT 16
#define A_SHIFT 24

#define R_MASK555 31
#define G_MASK555 992
#define B_MASK555 31744

#define CRACKR555(c)  ((((c) And R_MASK555)         * 255) \ 31)
#define CRACKG555(c) (((((c) And G_MASK555) Shr  5) * 255) \ 31)
#define CRACKB555(c) (((((c) And B_MASK555) Shr 10) * 255) \ 31)

#define COLOUR_16TO32_555(c) ((CRACKR555(c) Shl R_SHIFT) Or (CRACKG555(c) Shl G_SHIFT) Or (CRACKB555(c) Shl B_SHIFT) Or (DEFAULT_ALPHA_VALUE Shl A_SHIFT))

namespace ext.gfx.tga

declare function rldecode( byval db as ubyte ptr, byval buflen as const uinteger, byval w as integer, byval h as integer, byval bpp as integer ) as ubyte ptr
declare sub idataToImg( byval data_buf as ubyte ptr, byval img as image ptr, byval bpp as integer )

declare function load_mem( byval src as any ptr, byval src_len as SizeType, byval t as target_e ) as ext.gfx.Image ptr

Function load _
        ( _
                Byref hFile as ext.File, _
                byval t as target_e _
        ) As ext.gfx.Image Ptr

        dim as Image ptr img
        dim as ubyte ptr fbuf

        if t <> TARGET_FBNEW ANDALSO t <> TARGET_OPENGL then return 0

        If hFile.open( ) Then
                Return NULL
        End If

        var fsiz = hFile.toBuffer(fbuf)
        hFile.close()

        img = load_mem(fbuf,fsiz,t)
        delete[] fbuf

        Return img

End Function

private function load_mem( byval src as any ptr, byval src_len as SizeType, byval t as target_e ) as ext.gfx.Image ptr

        Dim As FileHeader ptr tga_info
        Dim As Ubyte Ptr  data_buf

        If src = null orelse src_len < sizeof(FileHeader) Then
                Return NULL
        End If

        tga_info = cast(FileHeader ptr, src)

        Dim As Integer w = tga_info->width
        Dim As Integer h = tga_info->height
        Dim As Integer bpp = tga_info->bitsperpixel \ 8
        Dim As Integer file_data_size

        file_data_size = src_len - (sizeof(FileHeader) + tga_info->idlength)

        data_buf = cast(ubyte ptr, src)+sizeof(FileHeader)+tga_info->idlength

        Select Case As Const tga_info->datatypecode
                Case 2 'Nothing to do, already rgb data

                Case 10
                    data_buf = rldecode( data_buf, file_data_size, w, h, bpp )
                Case Else
                    'unsupported type
                    Return NULL
        End Select

        var img = new image( w, h )

        idataToImg( data_buf, img, bpp )

        If ((tga_info->imagedescriptor And 32) Shr 5) = 0 Then
            var img2 = ext.gfx.flipVertical( img )
            delete img
            return img2
        End If

        Return img

end function

function rldecode( byval data_buf as ubyte ptr, byval buflen as const uinteger, byval w as integer, byval h as integer, byval bpp as integer ) as ubyte ptr

    Dim As Uinteger  data_buf_pos
    Dim As Ubyte Ptr colorbuffer
    Dim As Uinteger  currentpixel
    Dim As Uinteger  currentbyte
    Dim As Ubyte     chunkheader
    Dim As Integer   numpixels
    Dim As Integer   temp_buf_size
    Dim As Ubyte Ptr temp_buf

    numpixels = w * h
    temp_buf_size = (numpixels * bpp)
    temp_buf = allocate(temp_buf_size)

    While currentpixel < numpixels
        chunkheader = data_buf[data_buf_pos]
        data_buf_pos += 1
        If chunkheader < 128 Then
            chunkheader += 1
            For counter As Integer = 0 To chunkheader - 1
                colorbuffer = @data_buf[data_buf_pos]
                data_buf_pos += bpp
                For i As Integer = 0 To bpp - 1
                    temp_buf[currentbyte + i] = colorbuffer[i]
                Next i
                currentbyte += bpp
                currentpixel += 1
            Next counter
        Else
            chunkheader -= 127
            colorbuffer = @data_buf[data_buf_pos]
            data_buf_pos += bpp
            For counter As Integer = 0 To chunkheader - 1
                For i As Integer = 0 To bpp - 1
                    temp_buf[currentbyte + i] = colorbuffer[i]
                Next i
                currentbyte += bpp
                currentpixel += 1
            Next counter
        End If
    Wend

    return temp_buf

end function

sub idataToImg( byval data_buf as ubyte ptr, byval img as image ptr, byval bpp as integer )

    dim as integer h = img->height, w = img->width
        Dim As Ubyte Ptr p1, p2
        Dim As Integer ofs

        p1 = data_buf
        p2 = cast(ubyte ptr,img->Pixels)

        ofs = img->pitch - (img->width * 4)

        For y As Integer = 0 To h - 1
                For x As Integer = 0 To w - 1
                        Select Case As Const bpp
                                Case 2
                                        *cptr( Uinteger Ptr, p2 ) = COLOUR_16TO32_555( *cptr( Ushort Ptr, p1 ) )
                                        p1 += 2
                                Case 3
                                        *cptr( Uinteger Ptr, p2 ) = rgba( p1[2], p1[1], p1[0], DEFAULT_ALPHA_VALUE )
                                        p1 += 3
                                Case 4
                                        *cptr( Uinteger Ptr, p2 ) = *cptr( Uinteger Ptr, p1 )
                                        p1 += 4
                        End Select
                        p2 += 4
                Next x
                p2 += ofs
        Next y

        deallocate( data_buf )

end sub


end namespace
