''Copyright (c) 2007-2011, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2007, Daniel Verkamp (DrV) http://drv.nu
''Contains code contributed and Copyright (c) 2010, D.J. Peters <d.j.peters@web.de>
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

# include once "ext/conversion/base64.bi"
# include once "ext/detail/common.bi"

namespace ext.conversion.base64

    #define E0(v1) ((v1) shr 2)
    #define E1(v1,v2) ((((v1) and 3) shl 4) + ((v2) shr 4))
    #define E2(v2,v3) ((((v2) and &H0F) shl 2) + ((v3) shr 6))
    #define E3(v3) ((v3) and &H3F)

    function encode overload ( byval src as const ubyte ptr, byval l as ext.SizeType ) as string

        static as string B64
                    B64 =   "ABCDEFGHIJKLMNOPQRSTUVWXYZ" & _
                            "abcdefghijklmnopqrstuvwxyz" & _
                            "0123456789+/"
        var t = ""
        var k = 0u, j = 0u
        if l = 0 then return t

        t = string( ((l+2)\3)*4,"=" )

        For j = 0 To l - ((l Mod 3)+1) Step 3
            t[k+0]=B64[e0(src[j+0])]
            t[k+1]=B64[e1(src[j+0],src[j+1])]
            t[k+2]=B64[e2(src[j+1],src[j+2])]
            t[k+3]=B64[e3(src[j+2])]:k+=4
        Next

        If (l mod 3) = 2 Then
            t[k+0]=B64[e0(src[j+0])]
            t[k+1]=B64[e1(src[j+0],src[j+1])]
            t[k+2]=B64[e2(src[j+1],src[j+2])]
            t[k+3]=61
        ElseIf (l mod 3) = 1 Then
            t[k+0]=B64[e0(src[j+0])]
            t[k+1]=B64[e1(src[j+0],src[j+1])]
            t[k+2]=61
            t[k+3]=61
        End If

        return t

    end function

    Function encode overload ( S As const String ) As String
        return encode( cast(ubyte ptr, @S[0]), len(S))
    End Function

    #undef E0
    #undef E1
    #undef E2
    #undef E3

    '' :::::
    sub decode overload (byval dest as ubyte ptr, byval source as const ubyte ptr, byval source_length as ext.SizeType)

        static _decode_tbl(255) as uinteger => { _
        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, _              ' 0..31
        0,0,0,0,0,0,0,0,0,0,0, _                                                        ' 32..42
        62,0,0,0,63, _                                                                  ' 43 (+), 44..46, 47 (/)
        52,53,54,55,56,57,58,59,60,61, _                                                ' 48..57 (0..9)
        0,0,0,0,0,0,0, _                                                                ' 58..64
        0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25, _          ' 65..90 (A..Z)
        0,0,0,0,0,0, _                                                                  ' 91..96
        26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,_ ' 97..122 (a..z)
        0,0,0,0,0 }                                                 ' 123..127

        source_length \= 4

        for src_ctr as ext.SizeType = 0 to source_length -1
            dim as uinteger buf = (_decode_tbl(source[0]) shl 18) or _
                  (_decode_tbl(source[1]) shl 12) or _
                  (_decode_tbl(source[2]) shl  6) or _
                  (_decode_tbl(source[3]))
            dest[0] = buf shr 16
            dest[1] = (buf shr 8) and &hFF
            dest[2] = buf and &hFF
            source += 4
            dest += 3
        next

    end sub

    '' :::::
    sub decode overload (byref dest as string, byref source as const string )

        var d_len = decoded_length( len(source) )

        dest = space(d_len+1)

        decode( cast(ubyte ptr, @dest[0]), cast(ubyte ptr, @source[0]), len(source) )

    end sub

    '' :::::
    function decoded_length (byval source_length as ext.SizeType) as ext.SizeType

        dim as ext.SizeType ret = (source_length \ 4) * 3
        if source_length mod 4 = 3 then
            ret += 2
        elseif source_length mod 4 = 2 then
            ret += 1
        end if

        return ret

    end function

end namespace 'ext.conversion.base64
