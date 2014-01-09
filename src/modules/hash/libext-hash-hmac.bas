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

#include once "ext/hash/hmac.bi"

namespace ext.hashes.hmac

    private function translate( byref c as const string, byval t as ubyte, byval l as uinteger ) as string
        var len_c = len(c)
        var ret = space(len_c)
        for n as uinteger = 0 to l -1
            ret[n] = c[n] xor t
        next
        return ret
    end function

    private function dohmac( byval c as function(byval as any ptr, byval as uinteger) as string, byval bs as uinteger, byref key as const string, byref msg as const string ) as string

        var tkey = ""
        if len(key) > bs then
            tkey = lcase(c(@key[0],len(key)))
        elseif len(key) < bs then
            tkey = key + string(bs-len(key),0)
        end if
        var okpad = translate(tkey,&h5C,bs)
        var ikpad = translate(tkey,&h36,bs)

        var p1 = ikpad & msg
        var p2 = lcase(c(@(p1[0]),len(p1)))
        var p25 = space(bs/2)
        var cnt = 0
        for n as uinteger = 0 to len(p2)-2 step 2
            p25[cnt] = cubyte("&h" & chr(p2[n]) & chr(p2[n+1]))
            ? hex(p25[cnt]);
            cnt += 1
            if cnt >= bs/2 then exit for
        next
        ?
        var p3 = okpad & p25

        return lcase(c(@(p3[0]),bs+(bs/2)))

    end function

    function md5_ ( byref key as const string, byref msg as const string ) as string
        return dohmac(@ext.hashes.md5.checksum,64,key,msg)
    end function

    function callsha2( byval m as any ptr, byval l as uinteger ) as string
        return ext.hashes.sha2.checksum(m,l)
    end function

    function sha256 ( byref key as const string, byref msg as const string ) as string
        return dohmac(@callsha2,SHA256_BLOCK_SIZE,key,msg)
    end function

end namespace
