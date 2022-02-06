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

''
''  Independent implementation of MD5 (RFC 1321).
''
''  This code implements the MD5 Algorithm defined in RFC 1321.
''  It is derived directly from the text of the RFC and not from the
''  reference implementation.

#include "ext/hash/md5.bi"
#include "ext/algorithms/detail/common.bi"
#include "ext/error.bi"

#define T1 &hd76aa478
#define T2 &he8c7b756
#define T3 &h242070db
#define T4 &hc1bdceee
#define T5 &hf57c0faf
#define T6 &h4787c62a
#define T7 &ha8304613
#define T8 &hfd469501
#define T9 &h698098d8
#define T10 &h8b44f7af
#define T11 &hffff5bb1
#define T12 &h895cd7be
#define T13 &h6b901122
#define T14 &hfd987193
#define T15 &ha679438e
#define T16 &h49b40821
#define T17 &hf61e2562
#define T18 &hc040b340
#define T19 &h265e5a51
#define T20 &he9b6c7aa
#define T21 &hd62f105d
#define T22 &h02441453
#define T23 &hd8a1e681
#define T24 &he7d3fbc8
#define T25 &h21e1cde6
#define T26 &hc33707d6
#define T27 &hf4d50d87
#define T28 &h455a14ed
#define T29 &ha9e3e905
#define T30 &hfcefa3f8
#define T31 &h676f02d9
#define T32 &h8d2a4c8a
#define T33 &hfffa3942
#define T34 &h8771f681
#define T35 &h6d9d6122
#define T36 &hfde5380c
#define T37 &ha4beea44
#define T38 &h4bdecfa9
#define T39 &hf6bb4b60
#define T40 &hbebfbc70
#define T41 &h289b7ec6
#define T42 &heaa127fa
#define T43 &hd4ef3085
#define T44 &h04881d05
#define T45 &hd9d4d039
#define T46 &he6db99e5
#define T47 &h1fa27cf8
#define T48 &hc4ac5665
#define T49 &hf4292244
#define T50 &h432aff97
#define T51 &hab9423a7
#define T52 &hfc93a039
#define T53 &h655b59c3
#define T54 &h8f0ccc92
#define T55 &hffeff47d
#define T56 &h85845dd1
#define T57 &h6fa87e4f
#define T58 &hfe2ce6e0
#define T59 &ha3014314
#define T60 &h4e0811a1
#define T61 &hf7537e82
#define T62 &hbd3af235
#define T63 &h2ad7d2bb
#define T64 &heb86d391

namespace ext.hashes

'':::
function md5 overload ( byref x as string ) as string

	dim st as md5_state

	md5_init(@st)

	md5_append( @st, @(x[0]), len(x) )

	return md5_finish( @st )

end function

'':::
function md5 ( byref x as ext.File, byval blocksize as uinteger = 1048576 ) as string

	if x.open() = true then return "Checksum could not be calculated, error opening file for reading. Error: " & str(x.LastError) & " - " & GetErrorText(x.LastError)

	var len_file = x.lof()
	dim as uinteger read_size = 0
	dim as ulongint left_in_file = len_file

	if len_file < blocksize then
		read_size = len_file
	else
		read_size = blocksize
	end if


	dim st as md5_state

	md5_init(@st)

	dim buffer as ubyte ptr
	buffer = new ubyte[read_size]
	if buffer = 0 then return "Checksum could not be calculated, error allocating memory."

	while left_in_file >= read_size

		x.get( , *buffer, read_size )

		md5_append( @st, buffer, read_size )

		left_in_file -= read_size

	wend

	delete[] buffer

	if left_in_file > 0 then

		buffer = new ubyte[left_in_file]

		x.get(, *buffer, left_in_file )

		md5_append( @st, buffer, left_in_file )

		delete[] buffer

	end if

	x.close()

	return md5_finish(@st)

end function

'':::
function md5 ( byval x as any ptr, byval nbytes as uinteger ) as string

	dim st as md5_state

	md5_init(@st)

	md5_append(@st, cast( ubyte ptr, x ), nbytes )

	return md5_finish(@st)

end function

private sub md5_process( byval pms as md5_state ptr, byval data_ as const ubyte ptr )

    dim as ulong	a = pms->abcd(0), b = pms->abcd(1), _
	c = pms->abcd(2), d = pms->abcd(3), t

	dim as ulong X2(16)
    dim as const ubyte ptr xp = data_
    dim as const ulong ptr X
	dim as integer iy = 0

	while iy < 16


	X2(iy) = xp[0] + (xp[1] shl 8) + (xp[2] shl 16) + (xp[3] shl 24)
	iy += 1
	xp += 4
	wend

	X = @X2(0)

#define ROTATE_LEFT(x, n) (((x) shl (n)) OR ((x) shr (32 - (n))))

    '' Round 1
    '' Let [abcd k s i] denote the operation
    '' a = b + ((a + F(b,c,d) + X[k] + T[i]) <<< s)
#define F(x, y, z) (((x) AND (y)) OR (NOT(x) AND (z)))
#macro SET(a, b, c, d, k, s, Ti)
  t = a + F(b,c,d) + X[k] + Ti
  a = ROTATE_LEFT(t, s) + b
#endmacro

    ' Do the following 16 operations.
    SET(a, b, c, d,  0,  7,  T1)
    SET(d, a, b, c,  1, 12,  T2)
    SET(c, d, a, b,  2, 17,  T3)
    SET(b, c, d, a,  3, 22,  T4)
    SET(a, b, c, d,  4,  7,  T5)
    SET(d, a, b, c,  5, 12,  T6)
    SET(c, d, a, b,  6, 17,  T7)
    SET(b, c, d, a,  7, 22,  T8)
    SET(a, b, c, d,  8,  7,  T9)
    SET(d, a, b, c,  9, 12, T10)
    SET(c, d, a, b, 10, 17, T11)
    SET(b, c, d, a, 11, 22, T12)
    SET(a, b, c, d, 12,  7, T13)
    SET(d, a, b, c, 13, 12, T14)
    SET(c, d, a, b, 14, 17, T15)
    SET(b, c, d, a, 15, 22, T16)

#undef SET

     '' Round 2
     '' Let [abcd k s i] denote the operation
     '' a = b + ((a + G(b,c,d) + X[k] + T[i]) <<< s)

#define G(x, y, z) (((x) AND (z)) OR ((y) AND NOT(z)))

#macro SET(a, b, c, d, k, s, Ti)
  t = a + G(b,c,d) + X[k] + Ti
  a = ROTATE_LEFT(t, s) + b
#endmacro

    ' Do the following 16 operations.
    SET(a, b, c, d,  1,  5, T17)
    SET(d, a, b, c,  6,  9, T18)
    SET(c, d, a, b, 11, 14, T19)
    SET(b, c, d, a,  0, 20, T20)
    SET(a, b, c, d,  5,  5, T21)
    SET(d, a, b, c, 10,  9, T22)
    SET(c, d, a, b, 15, 14, T23)
    SET(b, c, d, a,  4, 20, T24)
    SET(a, b, c, d,  9,  5, T25)
    SET(d, a, b, c, 14,  9, T26)
    SET(c, d, a, b,  3, 14, T27)
    SET(b, c, d, a,  8, 20, T28)
    SET(a, b, c, d, 13,  5, T29)
    SET(d, a, b, c,  2,  9, T30)
    SET(c, d, a, b,  7, 14, T31)
    SET(b, c, d, a, 12, 20, T32)

#undef SET

     '' Round 3
     '' Let [abcd k s t] denote the operation
     ''   a = b + ((a + H(b,c,d) + X[k] + T[i]) <<< s)

#define H(x, y, z) ((x) XOR (y) XOR (z))

#macro SET(a, b, c, d, k, s, Ti)
  t = a + H(b,c,d) + X[k] + Ti
  a = ROTATE_LEFT(t, s) + b
#endmacro

     ' Do the following 16 operations.
    SET(a, b, c, d,  5,  4, T33)
    SET(d, a, b, c,  8, 11, T34)
    SET(c, d, a, b, 11, 16, T35)
    SET(b, c, d, a, 14, 23, T36)
    SET(a, b, c, d,  1,  4, T37)
    SET(d, a, b, c,  4, 11, T38)
    SET(c, d, a, b,  7, 16, T39)
    SET(b, c, d, a, 10, 23, T40)
    SET(a, b, c, d, 13,  4, T41)
    SET(d, a, b, c,  0, 11, T42)
    SET(c, d, a, b,  3, 16, T43)
    SET(b, c, d, a,  6, 23, T44)
    SET(a, b, c, d,  9,  4, T45)
    SET(d, a, b, c, 12, 11, T46)
    SET(c, d, a, b, 15, 16, T47)
    SET(b, c, d, a,  2, 23, T48)

#undef SET

    '' Round 4
    '' Let [abcd k s t] denote the operation
    ''    a = b + ((a + I(b,c,d) + X[k] + T[i]) <<< s)

#define I(x, y, z) ((y) XOR ((x) OR NOT(z)))

#macro SET(a, b, c, d, k, s, Ti)
  t = a + I(b,c,d) + X[k] + Ti
  a = ROTATE_LEFT(t, s) + b
#endmacro

     ' Do the following 16 operations.
    SET(a, b, c, d,  0,  6, T49)
    SET(d, a, b, c,  7, 10, T50)
    SET(c, d, a, b, 14, 15, T51)
    SET(b, c, d, a,  5, 21, T52)
    SET(a, b, c, d, 12,  6, T53)
    SET(d, a, b, c,  3, 10, T54)
    SET(c, d, a, b, 10, 15, T55)
    SET(b, c, d, a,  1, 21, T56)
    SET(a, b, c, d,  8,  6, T57)
    SET(d, a, b, c, 15, 10, T58)
    SET(c, d, a, b,  6, 15, T59)
    SET(b, c, d, a, 13, 21, T60)
    SET(a, b, c, d,  4,  6, T61)
    SET(d, a, b, c, 11, 10, T62)
    SET(c, d, a, b,  2, 15, T63)
    SET(b, c, d, a,  9, 21, T64)
#undef SET

     ' Then perform the following additions. (That is increment each
     '   of the four registers by the value it had before this block
     '   was started.)

    pms->abcd(0) += a
    pms->abcd(1) += b
    pms->abcd(2) += c
    pms->abcd(3) += d

end sub


sub md5_init( byval pms as md5_state ptr )

    pms->count(0) = 0
	pms->count(1) = 0
    pms->abcd(0) = &h67452301
    pms->abcd(1) = &hefcdab89
    pms->abcd(2) = &h98badcfe
    pms->abcd(3) = &h10325476

end sub


sub md5_append( byval pms as md5_state ptr, byval data_ as const ubyte ptr, byval nbytes as integer )

    dim as const ubyte ptr p = data_
    dim as integer left_ = nbytes
    dim as integer offset = (pms->count(0) shr 3) AND 63
    dim as ulong nbits = (nbytes shl 3)

    if (nbytes <= 0) then return

    ' Update the message length.
    pms->count(1) += nbytes shr 29
    pms->count(0) += nbits
    if (pms->count(0) < nbits) then	pms->count(1) += 1

    ' Process an initial partial block.
    if (offset) then
		var copy = iif((offset + nbytes) > 64 ,64 - offset, nbytes)

		memcpy((@pms->buf(0)) + offset, data_, copy)

		if (offset + copy < 64) then return

		p += copy
		left_ -= copy
		md5_process(pms, @pms->buf(0))
    end if

    ' Process full blocks.
	while left_ >= 64
    	md5_process(pms, p)
		p += 64
		left_ -= 64
	wend


    ' Process a final partial block.
    if (left_ > 0) then memcpy( @(pms->buf(0)), p, left_ )

end sub

function md5_finish ( byval pms as md5_state ptr ) as string

	dim as ubyte digest(16)
    dim as ubyte pad(64)
	dim as ubyte data_(8)
    dim as string ret
	dim remp as string

	pad(0) = &h80
	for n as integer = 1 to 63
		pad(n) = 0
	next

	ret = space(32)

    ' Save the length before padding.
    for i as integer = 0 to 7
	data_(i) = cubyte(pms->count(i shr 2) shr ((i AND 3) shl 3))
	next

    ' Pad to 56 bytes mod 64.
    md5_append( pms, @pad(0), ((55 - (pms->count(0) shr 3)) AND 63) + 1)

    ' Append the length.
    md5_append( pms, @data_(0), 8)

    var cnt = 0

	for i as integer = 0 to 15

		digest(i) = (pms->abcd(i shr 2) shr ((i AND 3) SHL 3))
		remp = hex(digest(i))
		if len(remp) = 1 then remp = "0" & remp

		ret[cnt] = remp[0] : cnt += 1
		ret[cnt] = remp[1] : cnt += 1

	next

	return ret

end function

end namespace
