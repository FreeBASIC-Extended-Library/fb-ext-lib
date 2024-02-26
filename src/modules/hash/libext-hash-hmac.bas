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

    const BLOCK_SIZE = 64ul

    private function dohmac( byval c as function(byval as any ptr, byval as uinteger) as string, byref key as const string, byref msg as const string ) as string

        var tkey = ""
        if len(key) > BLOCK_SIZE then
            tkey = lcase(c(cast(ubyte ptr,@key[0]),len(key)))
        else
            tkey = key & string(BLOCK_SIZE-len(key),0)
        end if
        var okpad = translate(tkey,&h5C,BLOCK_SIZE)
        var ikpad = translate(tkey,&h36,BLOCK_SIZE)

        var p1 = ikpad & msg
        var p2 = c(@(p1[0]),len(p1))
        dim p2l as ulong = int(len(p2)/2)
        var p25 = new ubyte[p2l+1]
        var cnt = 0u
        for n as uinteger = 0 to len(p2)-2 step 2
            p25[cnt] = cubyte("&h" & chr(p2[n]) & chr(p2[n+1]))
            cnt += 1
            if cnt >= p2l then
                exit for
            end if
        next
        p25[p2l] = 0
        var p35l = BLOCK_SIZE + p2l
        var p35 = new ubyte[p35l + 1]
        for n as uinteger = 0 to BLOCK_SIZE-1
            p35[n] = okpad[n]
        next
        cnt = BLOCK_SIZE
        for n as uinteger = 0 to p2l -1
            p35[cnt] = p25[n]
            cnt += 1
        next
        p35[p35l] = 0
        var ret = lcase(c(p35, p35l))
        delete[] p35
        delete[] p25
        return ret

    end function

    function md5 ( byref key as const string, byref msg as const string ) as string
        return dohmac(@ext.hashes.md5,key,msg)
    end function

    function callsha2( byval m as any ptr, byval l as uinteger ) as string
        return ext.hashes.sha2(m, l, ext.hashes.SHA256)
    end function

    function sha256 ( byref key as const string, byref msg as const string ) as string
        return dohmac(@callsha2,key,msg)
    end function

end namespace
