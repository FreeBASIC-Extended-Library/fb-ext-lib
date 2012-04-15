''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''	* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''	* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''	* Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
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

#include once "ext/graphics/tga.bi"
#include once "ext/graphics/manip.bi"
#include once "ext/file/file.bi"
'#include once "ext/file/console.bi"

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
declare sub idataToImg( byval data_buf as ubyte ptr, byval img as fb.image ptr, byval bpp as integer )

'dim shared as ext.Console con

Function load _
		( _
				Byref file_name As const string _
		) As fb.image Ptr

		Dim As FileHeader tga_info
		Dim As ext.FILE  hFile
		Dim As Ubyte Ptr  tga_id
		Dim As Ubyte Ptr  data_buf

		If hFile.open( file_name ) Then
				'con.WriteLine("File not loaded")
				Return NULL
		End If

		hFile.get( , *cast(ubyte ptr, @tga_info), sizeof( FileHeader ))

		Dim As Integer w = tga_info.width
		Dim As Integer h = tga_info.height
		Dim As Integer bpp = tga_info.bitsperpixel \ 8
		Dim As Integer file_data_size

		file_data_size = hFile.lof() - (sizeof(FileHeader) + tga_info.idlength)

		data_buf = allocate( file_data_size )

		if tga_info.idlength > 0 then
			for n as integer = 0 to tga_info.idlength -1
				dim idfiller as ubyte
				hFile.get( , idfiller )
			next
		end if

		hFile.get( , *data_buf, file_data_size )

		hFile.close()

		Select Case As Const tga_info.datatypecode
				Case 2 'Nothing to do, already rgb data

				Case 10
					data_buf = rldecode( data_buf, file_data_size, w, h, bpp )
				Case Else
					'con.WriteLine("Unsupported tga type")
					'unsupported type
					deallocate( data_buf )
					Return NULL
		End Select

		Dim As fb.image Ptr img

		img = imagecreate( w, h )

		idataToImg( data_buf, img, bpp )

		If ((tga_info.imagedescriptor And 32) Shr 5) = 0 Then
			img = ext.gfx.flipVertical( img )
		End If

		Return img

End Function

function rldecode( byval data_buf as ubyte ptr, byval buflen as const uinteger, byval w as integer, byval h as integer, byval bpp as integer ) as ubyte ptr

	Dim As Uinteger  data_buf_pos
	Dim As Ubyte Ptr colorbuffer
	Dim As Uinteger  currentpixel
	Dim As Uinteger  currentbyte
	Dim As Ubyte	 chunkheader
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

	deallocate( data_buf )
	return temp_buf

end function

sub idataToImg( byval data_buf as ubyte ptr, byval img as fb.image ptr, byval bpp as integer )

	dim as integer h = img->height, w = img->width
		Dim As Ubyte Ptr p1, p2
		Dim As Integer ofs

		p1 = data_buf
		p2 = cptr( Ubyte Ptr, img ) + sizeof( fb.image )

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
