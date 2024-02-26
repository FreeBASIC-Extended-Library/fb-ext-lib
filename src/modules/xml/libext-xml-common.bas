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

#include once "ext/xml/detail/common.bi"

namespace ext.xml

    function encode_entities(byref text as const string) as string
        dim as string temp
        for i as integer = 0 to len(text) - 1
            select case text[i]
            case quot
                temp &= "&quot;"
            case amp
                temp &= "&amp;"
            case apos
                temp &= "&apos;"
            case lt
                temp &= "&lt;"
            case gt
                temp &= "&gt;"
            case else
                if text[i] < space_ and not (text[i] = tab_ or text[i] = lf or text[i] = cr) then
                    temp &= "&#" & text[i] & ";"
                elseif text[i] and &b10000000 then
                    dim as integer u
                    i += decode_utf8(cptr(const zstring ptr, @text[i]), u) - 1
                    temp &= "&#" & u & ";"
                else
                    temp &= chr(text[i])
                end if
            end select
        next
        return temp
    end function

    function decode_entities(byref text as const string) as string
        dim as string temp
        dim as integer i = 1, j
        do
            j = instr(i, text, "&")
            if (j) then
                temp &= mid(text, i, j - i)
                i = j + 1
                j = instr(i, text, ";")
                if (j) then
                    select case (mid(text, i, j - i + 1))
                    case "quot;"
                        temp &= """"
                    case "amp;"
                        temp &= "&"
                    case "apos;"
                        temp &= "'"
                    case "lt;"
                        temp &= "<"
                    case "gt;"
                        temp &= ">"
                    case else
                        if text[i - 1] = hash then
                            dim as integer u
                            if text[i] = asc("x") then
                                u = val("&h" & mid(text, i + 2, j - i))
                            else
                                u = val(mid(text, i + 1, j - i))
                            end if
                            if (u) then
                                dim as zstring ptr encoded = encode_utf8(u)
                                if (encoded) then
                                    temp &= *encoded
                                    deallocate(encoded)
                                end if
                            end if
                        else
                            temp &= "&"
                            j = i - 1
                        end if
                    end select
                    i += j - i + 1
                end if
            end if
        loop while (j)
        return temp & mid(text, i)
    end function

    function encode_utf8(byval u as integer) as zstring ptr
        dim as integer n

        if     (u >= &h010000 and u <= &h10ffff) then
            n = 4
        elseif (u >= &h000800 and u <= &h00ffff) then
            n = 3
        elseif (u >= &h000080 and u <= &h0007ff) then
            n = 2
        elseif (u >= &h000000 and u <= &h00007f) then
            n = 1
        else  '' not a UTF-8 character
            return 0
        end if

        dim as zstring ptr dst = callocate(n + 1)

        if (n > 1) then
            for j as integer = 0 to n - 1
                dst[n - 1 - j] = u and iif(j = n - 1, 1 shl (7 - n), 1 shl 6) - 1
                dst[n - 1 - j] or= iif(j = n - 1, not ((1 shl (8 - n)) - 1), &b10000000)
                u shr= 6
            next
        else
            dst[0] = u
        end if

        return dst
    end function

    function decode_utf8(byval src as const zstring ptr, byref u as integer) as integer
        dim as integer n

        if     (src[0] and &b11111000) = &b11110000 then
            n = 4
        elseif (src[0] and &b11110000) = &b11100000 then
            n = 3
        elseif (src[0] and &b11100000) = &b11000000 then
            n = 2
        elseif (src[0] and &b10000000) = &b00000000 then
            n = 0
        else  '' not a UTF-8 character
            n = 0
        end if

        if (n) then
            u = 0

            for j as integer = 0 to n - 1
                if (j <> 0) and (src[j] and &b11000000) <> &b10000000 then
                    goto not_utf8
                end if

                if ((src[j] and &b11111110) = &b11000000 or _
                (src[j]               ) = &b11110101 or _
                (src[j] and &b11111110) = &b11110110 or _
                (src[j] and &b11111100) = &b11111000 or _
                (src[j] and &b11111110) = &b11111100 or _
                (src[j] and &b11111110) = &b11111110) then
                    goto not_utf8
                end if

                u shl= 6
                u or= src[j] and (iif(j = 0, 1 shl (7 - n), 1 shl 6) - 1)
            next
        else
            not_utf8:
            n = 1
            u = src[0]
        end if

        return n
    end function

end namespace
