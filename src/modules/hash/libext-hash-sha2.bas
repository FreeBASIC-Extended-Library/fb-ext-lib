''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''Copyright (C) 2005, 2007 Olivier Gay <olivier.gay@a3.epfl.ch>
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
#define fbext_NoBuiltinInstanciations() 1

#include once "ext/memory.bi"
#include once "ext/hash/sha2.bi"
#include once "ext/error.bi"
#include once "ext/math/detail/common.bi"

namespace ext.hashes


function sha2 overload ( byref x as string, byval keylen as uinteger = 256 ) as string

    return sha2(@(x[0]),len(x),keylen)

end function

'':::
function sha2 ( byref x as ext.File, byval keylen as uinteger = 256, byval blocksize as uinteger = 1048576 ) as string

    if x.open() = true then return "Checksum could not be calculated, error opening file for reading. Error: " & str(x.LastError) & " - " & GetErrorText(x.LastError)

    if keylen <> 224 and keylen <> 256 and keylen <> 384 and keylen <> 512 then return "Invalid key length"

    dim as any ptr st

    if keylen < 257 then

        st = new sha256_ctx

    else

        st = new sha512_ctx

    end if

    var len_file = x.lof()
    dim as uinteger read_size = 0
    dim as ulongint left_in_file = len_file

    if len_file < blocksize then
        read_size = len_file
    else
        read_size = blocksize
    end if


    select case keylen
    case 224
        sha224_init(st)
    case 256
        sha256_init(st)
    case 384
        sha384_init(st)
    case 512
        sha512_init(st)
    end select

    dim buffer as ubyte ptr
    buffer = new ubyte[read_size]
    if buffer = 0 then return "Checksum could not be calculated, error allocating memory."

    while left_in_file >= read_size

        x.get( , *buffer, read_size )

        select case keylen
        case 224
            sha224_update( st, buffer, read_size )
        case 256
            sha256_update( st, buffer, read_size )
        case 384
            sha384_update( st, buffer, read_size )
        case 512
            sha512_update( st, buffer, read_size )
        end select

        left_in_file -= read_size

    wend

    delete[] buffer

    if left_in_file > 0 then

        buffer = new ubyte[left_in_file]

        x.get(, *buffer, left_in_file )

        select case keylen
        case 224
            sha224_update( st, buffer, left_in_file )
        case 256
            sha256_update( st, buffer, left_in_file )
        case 384
            sha384_update( st, buffer, left_in_file )
        case 512
            sha512_update( st, buffer, left_in_file )
        end select

        delete[] buffer

    end if

    x.close()

    var retstr = ""

    select case keylen
    case 224
        retstr = space(SHA224_DIGEST_SIZE)
    case 256
        retstr = space(SHA256_DIGEST_SIZE)
    case 384
        retstr = space(SHA384_DIGEST_SIZE)
    case 512
        retstr = space(SHA512_DIGEST_SIZE)
    end select

    select case keylen
    case 224
        sha224_final( st, retstr )
    case 256
        sha256_final( st, retstr )
    case 384
        sha384_final( st, retstr )
    case 512
        sha512_final( st, retstr )
    end select

    if keylen < 257 then

        delete cast(sha256_ctx ptr, st)

    else

        delete cast(sha512_ctx ptr, st)

    end if

    var real_retstr = ""

    for n as integer = 0 to len(retstr) - 1
        var remp = lcase(hex(retstr[n]))
        if len(remp) = 1 then remp = "0" & remp
        real_retstr = real_retstr & remp
    next

    return real_retstr

end function

'':::
function sha2 ( byval x as any ptr, byval nbytes as uinteger, byval keylen as uinteger = 256 ) as string

    if keylen <> 224 AND keylen <> 256 AND keylen <> 384 AND keylen <> 512 then return "Invalid key length"

    dim as any ptr st

    if keylen < 257 then

        st = new sha256_ctx

    else

        st = new sha512_ctx

    end if

    select case keylen
    case 224
        sha224_init(st)
    case 256
        sha256_init(st)
    case 384
        sha384_init(st)
    case 512
        sha512_init(st)
    end select

    select case keylen
    case 224
        sha224_update( st, cast( ubyte ptr, x ), nbytes )
    case 256
        sha256_update( st, cast( ubyte ptr, x ), nbytes )
    case 384
        sha384_update( st, cast( ubyte ptr, x ), nbytes )
    case 512
        sha512_update( st, cast( ubyte ptr, x ), nbytes )
    end select

    var retstr = ""

    select case keylen
    case 224
        retstr = space(SHA224_DIGEST_SIZE)
    case 256
        retstr = space(SHA256_DIGEST_SIZE)
    case 384
        retstr = space(SHA384_DIGEST_SIZE)
    case 512
        retstr = space(SHA512_DIGEST_SIZE)
    end select

    select case keylen
    case 224
        sha224_final( st, retstr )
    case 256
        sha256_final( st, retstr )
    case 384
        sha384_final( st, retstr )
    case 512
        sha512_final( st, retstr )
    end select

    if keylen < 257 then

        delete cast(sha256_ctx ptr, st)

    else

        delete cast(sha512_ctx ptr, st)

    end if

    var real_retstr = ""

    for n as integer = 0 to len(retstr) - 1
        var remp = lcase(hex(retstr[n]))
        if len(remp) = 1 then remp = "0" & remp
        real_retstr = real_retstr & remp
    next

    return real_retstr

end function

#define SHFR(x, n)    (x shr n)
#define SHFR64(x, n) shr64(x,n)
#define ROTR(x, n)   ((x shr n) OR (x shl ((sizeof(x) shl 3) - n)))
#define ROTL(x, n)   ((x shl n) OR (x shr ((sizeof(x) shl 3) - n)))
#define ROTR64(x, n)   shr64(x ,n) OR (shl64(x ,shl64(sizeof(x) , 3) - n))
#define ROTL64(x, n)   shl64(x ,n) OR (shr64(x ,shl64(sizeof(x) , 3) - n))
#define CH(x, y, z)  ((x AND y) XOR (not(x) AND z))
#define MAJ(x, y, z) ((x AND y) XOR (x AND z) XOR (y AND z))

#define SHA256_F1(x) (ROTR(x,  2) XOR ROTR(x, 13) XOR ROTR(x, 22))
#define SHA256_F2(x) (ROTR(x,  6) XOR ROTR(x, 11) XOR ROTR(x, 25))
#define SHA256_F3(x) (ROTR(x,  7) XOR ROTR(x, 18) XOR SHFR(x,  3))
#define SHA256_F4(x) (ROTR(x, 17) XOR ROTR(x, 19) XOR SHFR(x, 10))

#define SHA512_F1(x) (ROTR64(x, 28) XOR ROTR64(x, 34) XOR ROTR64(x, 39))
#define SHA512_F2(x) (ROTR64(x, 14) XOR ROTR64(x, 18) XOR ROTR64(x, 41))
#define SHA512_F3(x) (ROTR64(x,  1) XOR ROTR64(x,  8) XOR SHFR64(x,  7))
#define SHA512_F4(x) (ROTR64(x, 19) XOR ROTR64(x, 61) XOR SHFR64(x,  6))

#macro UNPACK32(x, _str)

    *((_str) + 3) = cast( ubyte, (x)      )
    *((_str) + 2) = cast( ubyte, (x) shr  8)
    *((_str) + 1) = cast( ubyte, (x) shr 16)
    *((_str) + 0) = cast( ubyte, (x) shr 24)

#endmacro

#macro PACK32(_str, x)

    *(x) =   cast(uinteger, *((_str) + 3)      ) _
           OR cast(uinteger, *((_str) + 2) shl  8)  _
           OR cast(uinteger, *((_str) + 1) shl 16)   _
           OR cast(uinteger, *((_str) + 0) shl 24)
#endmacro

#macro UNPACK64(x, _str)

    *((_str) + 7) = cast( ubyte, (x)      )
    *((_str) + 6) = cast( ubyte, (x) shr  8)
    *((_str) + 5) = cast( ubyte, (x) shr 16)
    *((_str) + 4) = cast( ubyte, (x) shr 24)
    *((_str) + 3) = cast( ubyte, (x) shr 32)
    *((_str) + 2) = cast( ubyte, (x) shr 40)
    *((_str) + 1) = cast( ubyte, (x) shr 48)
    *((_str) + 0) = cast( ubyte, (x) shr 56)

#endmacro

#macro PACK64(_str, x)

    *(x) =   cast(ulongint, *((_str) + 7)      )    _
           OR shl64(cast(ulongint, *((_str) + 6)), 8)    _
           OR shl64(cast(ulongint, *((_str) + 5)), 16)    _
           OR shl64(cast(ulongint, *((_str) + 4)), 24)    _
           OR shl64(cast(ulongint, *((_str) + 3)), 32)    _
           OR shl64(cast(ulongint, *((_str) + 2)), 40)    _
           OR shl64(cast(ulongint, *((_str) + 1)), 48)    _
           OR shl64(cast(ulongint, *((_str) + 0)), 56)

#endmacro

#macro SHA256_SCR(i)

    w(i) =  SHA256_F4(w(i -  2)) + w(i -  7)  _
          + SHA256_F3(w(i - 15)) + w(i - 16)
#endmacro

#macro SHA512_SCR(i)

    w(i) =  SHA512_F4(w(i -  2)) + w(i -  7) _
          + SHA512_F3(w(i - 15)) + w(i - 16)
#endmacro

#macro SHA256_EXP(a, b, c, d, e, f, g, h, j)

    t1 = wv(h) + SHA256_F2(wv(e)) + CH(wv(e), wv(f), wv(g)) _
         + sha256_k(j) + w(j)
    t2 = SHA256_F1(wv(a)) + MAJ(wv(a), wv(b), wv(c))
    wv(d) += t1
    wv(h) = t1 + t2
#endmacro

#macro SHA512_EXP(a, b, c, d, e, f, g ,h, j)

    t1 = wv(h) + SHA512_F2(wv(e)) + CH(wv(e), wv(f), wv(g)) _
         + sha512_k(j) + w(j)
    t2 = SHA512_F1(wv(a)) + MAJ(wv(a), wv(b), wv(c))
    wv(d) += t1
    wv(h) = t1 + t2
#endmacro

dim shared sha224_h0(8) as uinteger => _
            {&hc1059ed8, &h367cd507, &h3070dd17, &hf70e5939, _
             &hffc00b31, &h68581511, &h64f98fa7, &hbefa4fa4}

dim shared sha256_h0(8) as uinteger => _
            {&h6a09e667, &hbb67ae85, &h3c6ef372, &ha54ff53a, _
             &h510e527f, &h9b05688c, &h1f83d9ab, &h5be0cd19}

dim shared sha384_h0(8) as ulongint => _
            {&hcbbb9d5dc1059ed8ULL, &h629a292a367cd507ULL, _
             &h9159015a3070dd17ULL, &h152fecd8f70e5939ULL, _
             &h67332667ffc00b31ULL, &h8eb44a8768581511ULL, _
             &hdb0c2e0d64f98fa7ULL, &h47b5481dbefa4fa4ULL}

dim shared sha512_h0(8) as ulongint => _
            {&h6a09e667f3bcc908ULL, &hbb67ae8584caa73bULL, _
             &h3c6ef372fe94f82bULL, &ha54ff53a5f1d36f1ULL, _
             &h510e527fade682d1ULL, &h9b05688c2b3e6c1fULL, _
             &h1f83d9abfb41bd6bULL, &h5be0cd19137e2179ULL}

dim shared sha256_k(64) as uinteger => _
            {&h428a2f98, &h71374491, &hb5c0fbcf, &he9b5dba5, _
             &h3956c25b, &h59f111f1, &h923f82a4, &hab1c5ed5, _
             &hd807aa98, &h12835b01, &h243185be, &h550c7dc3, _
             &h72be5d74, &h80deb1fe, &h9bdc06a7, &hc19bf174, _
             &he49b69c1, &hefbe4786, &h0fc19dc6, &h240ca1cc, _
             &h2de92c6f, &h4a7484aa, &h5cb0a9dc, &h76f988da, _
             &h983e5152, &ha831c66d, &hb00327c8, &hbf597fc7, _
             &hc6e00bf3, &hd5a79147, &h06ca6351, &h14292967, _
             &h27b70a85, &h2e1b2138, &h4d2c6dfc, &h53380d13, _
             &h650a7354, &h766a0abb, &h81c2c92e, &h92722c85, _
             &ha2bfe8a1, &ha81a664b, &hc24b8b70, &hc76c51a3, _
             &hd192e819, &hd6990624, &hf40e3585, &h106aa070, _
             &h19a4c116, &h1e376c08, &h2748774c, &h34b0bcb5, _
             &h391c0cb3, &h4ed8aa4a, &h5b9cca4f, &h682e6ff3, _
             &h748f82ee, &h78a5636f, &h84c87814, &h8cc70208, _
             &h90befffa, &ha4506ceb, &hbef9a3f7, &hc67178f2}

dim shared sha512_k(80) as ulongint= _
            {&h428a2f98d728ae22ULL, &h7137449123ef65cdULL, _
             &hb5c0fbcfec4d3b2fULL, &he9b5dba58189dbbcULL, _
             &h3956c25bf348b538ULL, &h59f111f1b605d019ULL, _
             &h923f82a4af194f9bULL, &hab1c5ed5da6d8118ULL, _
             &hd807aa98a3030242ULL, &h12835b0145706fbeULL, _
             &h243185be4ee4b28cULL, &h550c7dc3d5ffb4e2ULL, _
             &h72be5d74f27b896fULL, &h80deb1fe3b1696b1ULL, _
             &h9bdc06a725c71235ULL, &hc19bf174cf692694ULL, _
             &he49b69c19ef14ad2ULL, &hefbe4786384f25e3ULL, _
             &h0fc19dc68b8cd5b5ULL, &h240ca1cc77ac9c65ULL, _
             &h2de92c6f592b0275ULL, &h4a7484aa6ea6e483ULL, _
             &h5cb0a9dcbd41fbd4ULL, &h76f988da831153b5ULL, _
             &h983e5152ee66dfabULL, &ha831c66d2db43210ULL, _
             &hb00327c898fb213fULL, &hbf597fc7beef0ee4ULL, _
             &hc6e00bf33da88fc2ULL, &hd5a79147930aa725ULL, _
             &h06ca6351e003826fULL, &h142929670a0e6e70ULL, _
             &h27b70a8546d22ffcULL, &h2e1b21385c26c926ULL, _
             &h4d2c6dfc5ac42aedULL, &h53380d139d95b3dfULL, _
             &h650a73548baf63deULL, &h766a0abb3c77b2a8ULL, _
             &h81c2c92e47edaee6ULL, &h92722c851482353bULL, _
             &ha2bfe8a14cf10364ULL, &ha81a664bbc423001ULL, _
             &hc24b8b70d0f89791ULL, &hc76c51a30654be30ULL, _
             &hd192e819d6ef5218ULL, &hd69906245565a910ULL, _
             &hf40e35855771202aULL, &h106aa07032bbd1b8ULL, _
             &h19a4c116b8d2d0c8ULL, &h1e376c085141ab53ULL, _
             &h2748774cdf8eeb99ULL, &h34b0bcb5e19b48a8ULL, _
             &h391c0cb3c5c95a63ULL, &h4ed8aa4ae3418acbULL, _
             &h5b9cca4f7763e373ULL, &h682e6ff3d6b2b8a3ULL, _
             &h748f82ee5defb2fcULL, &h78a5636f43172f60ULL, _
             &h84c87814a1f0ab72ULL, &h8cc702081a6439ecULL, _
             &h90befffa23631e28ULL, &ha4506cebde82bde9ULL, _
             &hbef9a3f7b2c67915ULL, &hc67178f2e372532bULL, _
             &hca273eceea26619cULL, &hd186b8c721c0c207ULL, _
             &heada7dd6cde0eb1eULL, &hf57d4f7fee6ed178ULL, _
             &h06f067aa72176fbaULL, &h0a637dc5a2c898a6ULL, _
             &h113f9804bef90daeULL, &h1b710b35131c471bULL, _
             &h28db77f523047d84ULL, &h32caab7b40c72493ULL, _
             &h3c9ebe0a15c9bebcULL, &h431d67c49c100d4cULL, _
             &h4cc5d4becb3e42b6ULL, &h597f299cfc657e2aULL, _
             &h5fcb6fab3ad6faecULL, &h6c44198c4a475817ULL}

private sub sha256_transf( byval ctx as sha256_ctx ptr, byval message as const ubyte ptr, _
                            byval block_nb as uinteger )

    dim as uinteger w(64)
    dim as uinteger wv(8)
    dim as uinteger t1, t2
    dim sub_block as const ubyte ptr

    for i as integer = 0 to block_nb -1
        sub_block = message + (i shl 6)


        PACK32(@sub_block[ 0], @w( 0)): PACK32(@sub_block[ 4], @w( 1))
        PACK32(@sub_block[ 8], @w( 2)): PACK32(@sub_block[12], @w( 3))
        PACK32(@sub_block[16], @w( 4)): PACK32(@sub_block[20], @w( 5))
        PACK32(@sub_block[24], @w( 6)): PACK32(@sub_block[28], @w( 7))
        PACK32(@sub_block[32], @w( 8)): PACK32(@sub_block[36], @w( 9))
        PACK32(@sub_block[40], @w(10)): PACK32(@sub_block[44], @w(11))
        PACK32(@sub_block[48], @w(12)): PACK32(@sub_block[52], @w(13))
        PACK32(@sub_block[56], @w(14)): PACK32(@sub_block[60], @w(15))

        SHA256_SCR(16): SHA256_SCR(17): SHA256_SCR(18): SHA256_SCR(19)
        SHA256_SCR(20): SHA256_SCR(21): SHA256_SCR(22): SHA256_SCR(23)
        SHA256_SCR(24): SHA256_SCR(25): SHA256_SCR(26): SHA256_SCR(27)
        SHA256_SCR(28): SHA256_SCR(29): SHA256_SCR(30): SHA256_SCR(31)
        SHA256_SCR(32): SHA256_SCR(33): SHA256_SCR(34): SHA256_SCR(35)
        SHA256_SCR(36): SHA256_SCR(37): SHA256_SCR(38): SHA256_SCR(39)
        SHA256_SCR(40): SHA256_SCR(41): SHA256_SCR(42): SHA256_SCR(43)
        SHA256_SCR(44): SHA256_SCR(45): SHA256_SCR(46): SHA256_SCR(47)
        SHA256_SCR(48): SHA256_SCR(49): SHA256_SCR(50): SHA256_SCR(51)
        SHA256_SCR(52): SHA256_SCR(53): SHA256_SCR(54): SHA256_SCR(55)
        SHA256_SCR(56): SHA256_SCR(57): SHA256_SCR(58): SHA256_SCR(59)
        SHA256_SCR(60): SHA256_SCR(61): SHA256_SCR(62): SHA256_SCR(63)

        wv(0) = ctx->h(0): wv(1) = ctx->h(1)
        wv(2) = ctx->h(2): wv(3) = ctx->h(3)
        wv(4) = ctx->h(4): wv(5) = ctx->h(5)
        wv(6) = ctx->h(6): wv(7) = ctx->h(7)

        SHA256_EXP(0,1,2,3,4,5,6,7, 0): SHA256_EXP(7,0,1,2,3,4,5,6, 1)
        SHA256_EXP(6,7,0,1,2,3,4,5, 2): SHA256_EXP(5,6,7,0,1,2,3,4, 3)
        SHA256_EXP(4,5,6,7,0,1,2,3, 4): SHA256_EXP(3,4,5,6,7,0,1,2, 5)
        SHA256_EXP(2,3,4,5,6,7,0,1, 6): SHA256_EXP(1,2,3,4,5,6,7,0, 7)
        SHA256_EXP(0,1,2,3,4,5,6,7, 8): SHA256_EXP(7,0,1,2,3,4,5,6, 9)
        SHA256_EXP(6,7,0,1,2,3,4,5,10): SHA256_EXP(5,6,7,0,1,2,3,4,11)
        SHA256_EXP(4,5,6,7,0,1,2,3,12): SHA256_EXP(3,4,5,6,7,0,1,2,13)
        SHA256_EXP(2,3,4,5,6,7,0,1,14): SHA256_EXP(1,2,3,4,5,6,7,0,15)
        SHA256_EXP(0,1,2,3,4,5,6,7,16): SHA256_EXP(7,0,1,2,3,4,5,6,17)
        SHA256_EXP(6,7,0,1,2,3,4,5,18): SHA256_EXP(5,6,7,0,1,2,3,4,19)
        SHA256_EXP(4,5,6,7,0,1,2,3,20): SHA256_EXP(3,4,5,6,7,0,1,2,21)
        SHA256_EXP(2,3,4,5,6,7,0,1,22): SHA256_EXP(1,2,3,4,5,6,7,0,23)
        SHA256_EXP(0,1,2,3,4,5,6,7,24): SHA256_EXP(7,0,1,2,3,4,5,6,25)
        SHA256_EXP(6,7,0,1,2,3,4,5,26): SHA256_EXP(5,6,7,0,1,2,3,4,27)
        SHA256_EXP(4,5,6,7,0,1,2,3,28): SHA256_EXP(3,4,5,6,7,0,1,2,29)
        SHA256_EXP(2,3,4,5,6,7,0,1,30): SHA256_EXP(1,2,3,4,5,6,7,0,31)
        SHA256_EXP(0,1,2,3,4,5,6,7,32): SHA256_EXP(7,0,1,2,3,4,5,6,33)
        SHA256_EXP(6,7,0,1,2,3,4,5,34): SHA256_EXP(5,6,7,0,1,2,3,4,35)
        SHA256_EXP(4,5,6,7,0,1,2,3,36): SHA256_EXP(3,4,5,6,7,0,1,2,37)
        SHA256_EXP(2,3,4,5,6,7,0,1,38): SHA256_EXP(1,2,3,4,5,6,7,0,39)
        SHA256_EXP(0,1,2,3,4,5,6,7,40): SHA256_EXP(7,0,1,2,3,4,5,6,41)
        SHA256_EXP(6,7,0,1,2,3,4,5,42): SHA256_EXP(5,6,7,0,1,2,3,4,43)
        SHA256_EXP(4,5,6,7,0,1,2,3,44): SHA256_EXP(3,4,5,6,7,0,1,2,45)
        SHA256_EXP(2,3,4,5,6,7,0,1,46): SHA256_EXP(1,2,3,4,5,6,7,0,47)
        SHA256_EXP(0,1,2,3,4,5,6,7,48): SHA256_EXP(7,0,1,2,3,4,5,6,49)
        SHA256_EXP(6,7,0,1,2,3,4,5,50): SHA256_EXP(5,6,7,0,1,2,3,4,51)
        SHA256_EXP(4,5,6,7,0,1,2,3,52): SHA256_EXP(3,4,5,6,7,0,1,2,53)
        SHA256_EXP(2,3,4,5,6,7,0,1,54): SHA256_EXP(1,2,3,4,5,6,7,0,55)
        SHA256_EXP(0,1,2,3,4,5,6,7,56): SHA256_EXP(7,0,1,2,3,4,5,6,57)
        SHA256_EXP(6,7,0,1,2,3,4,5,58): SHA256_EXP(5,6,7,0,1,2,3,4,59)
        SHA256_EXP(4,5,6,7,0,1,2,3,60): SHA256_EXP(3,4,5,6,7,0,1,2,61)
        SHA256_EXP(2,3,4,5,6,7,0,1,62): SHA256_EXP(1,2,3,4,5,6,7,0,63)

        ctx->h(0) += wv(0): ctx->h(1) += wv(1)
        ctx->h(2) += wv(2): ctx->h(3) += wv(3)
        ctx->h(4) += wv(4): ctx->h(5) += wv(5)
        ctx->h(6) += wv(6): ctx->h(7) += wv(7)

    next
end sub

sub sha256_init( byval ctx as sha256_ctx ptr )

    ctx->h(0) = sha256_h0(0): ctx->h(1) = sha256_h0(1)
    ctx->h(2) = sha256_h0(2): ctx->h(3) = sha256_h0(3)
    ctx->h(4) = sha256_h0(4): ctx->h(5) = sha256_h0(5)
    ctx->h(6) = sha256_h0(6): ctx->h(7) = sha256_h0(7)

    ctx->_len = 0
    ctx->tot_len = 0

end sub

sub sha256_update( byval ctx as sha256_ctx ptr, byval message as const ubyte ptr, _
                    byval len_ as uinteger )

    dim as uinteger block_nb, new_len, rem_len, tmp_len
    dim as const ubyte ptr shifted_message

    tmp_len = SHA256_BLOCK_SIZE - ctx->_len
    rem_len = iif(len_ < tmp_len , len_ , tmp_len )

    memcpy(@ctx->block(ctx->_len), message, rem_len)

    if (ctx->_len + len_ < SHA256_BLOCK_SIZE) then
        ctx->_len += len_
        return
    end if

    new_len = len_ - rem_len
    block_nb = new_len / SHA256_BLOCK_SIZE

    shifted_message = message + rem_len

    sha256_transf(ctx, @ctx->block(0), 1)
    sha256_transf(ctx, shifted_message, block_nb)

    rem_len = new_len mod SHA256_BLOCK_SIZE

    memcpy(@ctx->block(0), @shifted_message[block_nb shl 6], rem_len)

    ctx->_len = rem_len
    ctx->tot_len += (block_nb + 1) shl 6
end sub

sub sha256_final( byval ctx as sha256_ctx ptr, byval digest as zstring ptr )

    dim as ulong block_nb, pm_len, len_b

    block_nb = (1 + abs((SHA256_BLOCK_SIZE - 9) _
                     < (ctx->_len mod SHA256_BLOCK_SIZE)))

    len_b = (ctx->tot_len + ctx->_len) shl 3
    pm_len = block_nb shl 6
    memset(@ctx->block(0) + ctx->_len, 0, pm_len - ctx->_len)
    ctx->block(ctx->_len) = &h80
    UNPACK32(len_b, @ctx->block(0) + pm_len - 4)

    sha256_transf(ctx, @ctx->block(0), block_nb)

   UNPACK32(ctx->h(0), cast(ubyte ptr, @digest[ 0]))
   UNPACK32(ctx->h(1), cast(ubyte ptr, @digest[ 4]))
   UNPACK32(ctx->h(2), cast(ubyte ptr, @digest[ 8]))
   UNPACK32(ctx->h(3), cast(ubyte ptr, @digest[12]))
   UNPACK32(ctx->h(4), cast(ubyte ptr, @digest[16]))
   UNPACK32(ctx->h(5), cast(ubyte ptr, @digest[20]))
   UNPACK32(ctx->h(6), cast(ubyte ptr, @digest[24]))
   UNPACK32(ctx->h(7), cast(ubyte ptr, @digest[28]))

end sub

sub sha512_transf( byval ctx as sha512_ctx ptr, byval message as const ubyte ptr, byval block_nb as uinteger )

    dim as ulongint w(80), wv(8), t1, t2
    dim as const ubyte ptr sub_block
    dim as integer j

    for i as integer = 0 to block_nb -1
        sub_block = message + (i shl 7)

        PACK64(@sub_block[  0], @w( 0)): PACK64(@sub_block[  8], @w( 1))
        PACK64(@sub_block[ 16], @w( 2)): PACK64(@sub_block[ 24], @w( 3))
        PACK64(@sub_block[ 32], @w( 4)): PACK64(@sub_block[ 40], @w( 5))
        PACK64(@sub_block[ 48], @w( 6)): PACK64(@sub_block[ 56], @w( 7))
        PACK64(@sub_block[ 64], @w( 8)): PACK64(@sub_block[ 72], @w( 9))
        PACK64(@sub_block[ 80], @w(10)): PACK64(@sub_block[ 88], @w(11))
        PACK64(@sub_block[ 96], @w(12)): PACK64(@sub_block[104], @w(13))
        PACK64(@sub_block[112], @w(14)): PACK64(@sub_block[120], @w(15))

        SHA512_SCR(16): SHA512_SCR(17): SHA512_SCR(18): SHA512_SCR(19)
        SHA512_SCR(20): SHA512_SCR(21): SHA512_SCR(22): SHA512_SCR(23)
        SHA512_SCR(24): SHA512_SCR(25): SHA512_SCR(26): SHA512_SCR(27)
        SHA512_SCR(28): SHA512_SCR(29): SHA512_SCR(30): SHA512_SCR(31)
        SHA512_SCR(32): SHA512_SCR(33): SHA512_SCR(34): SHA512_SCR(35)
        SHA512_SCR(36): SHA512_SCR(37): SHA512_SCR(38): SHA512_SCR(39)
        SHA512_SCR(40): SHA512_SCR(41): SHA512_SCR(42): SHA512_SCR(43)
        SHA512_SCR(44): SHA512_SCR(45): SHA512_SCR(46): SHA512_SCR(47)
        SHA512_SCR(48): SHA512_SCR(49): SHA512_SCR(50): SHA512_SCR(51)
        SHA512_SCR(52): SHA512_SCR(53): SHA512_SCR(54): SHA512_SCR(55)
        SHA512_SCR(56): SHA512_SCR(57): SHA512_SCR(58): SHA512_SCR(59)
        SHA512_SCR(60): SHA512_SCR(61): SHA512_SCR(62): SHA512_SCR(63)
        SHA512_SCR(64): SHA512_SCR(65): SHA512_SCR(66): SHA512_SCR(67)
        SHA512_SCR(68): SHA512_SCR(69): SHA512_SCR(70): SHA512_SCR(71)
        SHA512_SCR(72): SHA512_SCR(73): SHA512_SCR(74): SHA512_SCR(75)
        SHA512_SCR(76): SHA512_SCR(77): SHA512_SCR(78): SHA512_SCR(79)

        wv(0) = ctx->h(0): wv(1) = ctx->h(1)
        wv(2) = ctx->h(2): wv(3) = ctx->h(3)
        wv(4) = ctx->h(4): wv(5) = ctx->h(5)
        wv(6) = ctx->h(6): wv(7) = ctx->h(7)

        j = 0

        do
            SHA512_EXP(0,1,2,3,4,5,6,7,j): j+=1
            SHA512_EXP(7,0,1,2,3,4,5,6,j): j+=1
            SHA512_EXP(6,7,0,1,2,3,4,5,j): j+=1
            SHA512_EXP(5,6,7,0,1,2,3,4,j): j+=1
            SHA512_EXP(4,5,6,7,0,1,2,3,j): j+=1
            SHA512_EXP(3,4,5,6,7,0,1,2,j): j+=1
            SHA512_EXP(2,3,4,5,6,7,0,1,j): j+=1
            SHA512_EXP(1,2,3,4,5,6,7,0,j): j+=1
        loop while (j < 80)

        ctx->h(0) += wv(0): ctx->h(1) += wv(1)
        ctx->h(2) += wv(2): ctx->h(3) += wv(3)
        ctx->h(4) += wv(4): ctx->h(5) += wv(5)
        ctx->h(6) += wv(6): ctx->h(7) += wv(7)
    next
end sub

sub sha512_init( byval ctx as sha512_ctx ptr )

    ctx->h(0) = sha512_h0(0): ctx->h(1) = sha512_h0(1)
    ctx->h(2) = sha512_h0(2): ctx->h(3) = sha512_h0(3)
    ctx->h(4) = sha512_h0(4): ctx->h(5) = sha512_h0(5)
    ctx->h(6) = sha512_h0(6): ctx->h(7) = sha512_h0(7)

    ctx->_len = 0
    ctx->tot_len = 0

end sub

sub sha512_update( byval ctx as sha512_ctx ptr, byval message as const ubyte ptr, byval len_ as uinteger )

    dim as uinteger block_nb, new_len, rem_len, tmp_len
    dim as const ubyte ptr shifted_message

    tmp_len = SHA512_BLOCK_SIZE - ctx->_len
    rem_len = iif(len_ < tmp_len , len_, tmp_len)

    memcpy(@ctx->block(ctx->_len), message, rem_len)

    if (ctx->_len + len_ < SHA512_BLOCK_SIZE) then
        ctx->_len += len_
        return
    end if

    new_len = len_ - rem_len
    block_nb = new_len / SHA512_BLOCK_SIZE

    shifted_message = message + rem_len

    sha512_transf(ctx, @ctx->block(0), 1)
    sha512_transf(ctx, shifted_message, block_nb)

    rem_len = new_len mod SHA512_BLOCK_SIZE

    memcpy(@ctx->block(0), @shifted_message[block_nb shl 7], rem_len)

    ctx->_len = rem_len
    ctx->tot_len += (block_nb + 1) shl 7
end sub

sub sha512_final( byval ctx as sha512_ctx ptr, byval digest as zstring ptr )

    dim as ulong block_nb, pm_len, len_b

    block_nb = 1 + abs((SHA512_BLOCK_SIZE - 17) _
                     < (ctx->_len mod SHA512_BLOCK_SIZE))

    len_b = (ctx->tot_len + ctx->_len) shl 3
    pm_len = block_nb shl 7

    memset(@ctx->block(0) + ctx->_len, 0, pm_len - ctx->_len)
    ctx->block(ctx->_len) = &h80
    UNPACK32(len_b, @(ctx->block(0)) + pm_len - 4)

    sha512_transf(ctx, @ctx->block(0), block_nb)

    UNPACK64(ctx->h(0), @digest[ 0])
    UNPACK64(ctx->h(1), @digest[ 8])
    UNPACK64(ctx->h(2), @digest[16])
    UNPACK64(ctx->h(3), @digest[24])
    UNPACK64(ctx->h(4), @digest[32])
    UNPACK64(ctx->h(5), @digest[40])
    UNPACK64(ctx->h(6), @digest[48])
    UNPACK64(ctx->h(7), @digest[56])

end sub

sub sha384_init( byval ctx as sha384_ctx ptr )

    ctx->h(0) = sha384_h0(0): ctx->h(1) = sha384_h0(1)
    ctx->h(2) = sha384_h0(2): ctx->h(3) = sha384_h0(3)
    ctx->h(4) = sha384_h0(4): ctx->h(5) = sha384_h0(5)
    ctx->h(6) = sha384_h0(6): ctx->h(7) = sha384_h0(7)

    ctx->_len = 0
    ctx->tot_len = 0

end sub

sub sha384_update( byval ctx as sha384_ctx ptr, byval message as const ubyte ptr, byval len_ as uinteger )

    dim as uinteger block_nb, new_len, rem_len, tmp_len
    dim as const ubyte ptr shifted_message

    tmp_len = SHA384_BLOCK_SIZE - ctx->_len
    rem_len = iif(len_ < tmp_len, len_, tmp_len)

    memcpy(@ctx->block(ctx->_len), message, rem_len)

    if (ctx->_len + len_ < SHA384_BLOCK_SIZE) then
        ctx->_len += len_
        return
    end if

    new_len = len_ - rem_len
    block_nb = new_len / SHA384_BLOCK_SIZE

    shifted_message = message + rem_len

    sha512_transf(ctx, @ctx->block(0), 1)
    sha512_transf(ctx, shifted_message, block_nb)

    rem_len = new_len mod SHA384_BLOCK_SIZE

    memcpy(@ctx->block(0), @shifted_message[block_nb shl 7], rem_len)

    ctx->_len = rem_len
    ctx->tot_len += (block_nb + 1) shl 7
end sub

sub sha384_final( byval ctx as sha384_ctx ptr, byval digest as zstring ptr )

    dim as ulong block_nb, pm_len, len_b

    block_nb = (1 + abs((SHA384_BLOCK_SIZE - 17) _
                     < (ctx->_len mod SHA384_BLOCK_SIZE)))

    len_b = (ctx->tot_len + ctx->_len) shl 3
    pm_len = block_nb shl 7

    memset(@ctx->block(0) + ctx->_len, 0, pm_len - ctx->_len)
    ctx->block(ctx->_len) = &h80
    UNPACK32(len_b, @ctx->block(0) + pm_len - 4)

    sha512_transf(ctx, @ctx->block(0), block_nb)

    UNPACK64(ctx->h(0), cast(ubyte ptr,@digest[ 0]))
    UNPACK64(ctx->h(1), cast(ubyte ptr,@digest[ 8]))
    UNPACK64(ctx->h(2), cast(ubyte ptr,@digest[16]))
    UNPACK64(ctx->h(3), cast(ubyte ptr,@digest[24]))
    UNPACK64(ctx->h(4), cast(ubyte ptr,@digest[32]))
    UNPACK64(ctx->h(5), cast(ubyte ptr,@digest[40]))
end sub

sub sha224_init( byval ctx as sha224_ctx ptr )

    ctx->h(0) = sha224_h0(0): ctx->h(1) = sha224_h0(1)
    ctx->h(2) = sha224_h0(2): ctx->h(3) = sha224_h0(3)
    ctx->h(4) = sha224_h0(4): ctx->h(5) = sha224_h0(5)
    ctx->h(6) = sha224_h0(6): ctx->h(7) = sha224_h0(7)

    ctx->_len = 0
    ctx->tot_len = 0
end sub

sub sha224_update( byval ctx as sha224_ctx ptr, byval message as const ubyte ptr, byval len_ as uinteger )

    dim as uinteger block_nb, new_len, rem_len, tmp_len
    dim as const ubyte ptr shifted_message

    tmp_len = SHA224_BLOCK_SIZE - ctx->_len
    rem_len = iif(len_ < tmp_len, len_, tmp_len)

    memcpy(@ctx->block(ctx->_len), message, rem_len)

    if (ctx->_len + len_ < SHA224_BLOCK_SIZE) then
        ctx->_len += len_
        return
    end if

    new_len = len_ - rem_len
    block_nb = new_len / SHA224_BLOCK_SIZE

    shifted_message = message + rem_len

    sha256_transf(ctx, @ctx->block(0), 1)
    sha256_transf(ctx, shifted_message, block_nb)

    rem_len = new_len mod SHA224_BLOCK_SIZE

    memcpy(@ctx->block(0), @shifted_message[block_nb shl 6], rem_len)

    ctx->_len = rem_len
    ctx->tot_len += (block_nb + 1) shl 6

end sub

sub sha224_final( byval ctx as sha224_ctx ptr, byval digest as zstring ptr )

    dim as ulong block_nb, pm_len, len_b

    block_nb = (1 + abs((SHA224_BLOCK_SIZE - 9) _
                     < (ctx->_len mod SHA224_BLOCK_SIZE)))

    len_b = (ctx->tot_len + ctx->_len) shl 3
    pm_len = block_nb shl 6

    memset(@ctx->block(0) + ctx->_len, 0, pm_len - ctx->_len)
    ctx->block(ctx->_len) = &h80
    UNPACK32(len_b, @ctx->block(0) + pm_len - 4)

    sha256_transf(ctx, @ctx->block(0), block_nb)

   UNPACK32(ctx->h(0), cast(ubyte ptr,@digest[ 0]))
   UNPACK32(ctx->h(1), cast(ubyte ptr,@digest[ 4]))
   UNPACK32(ctx->h(2), cast(ubyte ptr,@digest[ 8]))
   UNPACK32(ctx->h(3), cast(ubyte ptr,@digest[12]))
   UNPACK32(ctx->h(4), cast(ubyte ptr,@digest[16]))
   UNPACK32(ctx->h(5), cast(ubyte ptr,@digest[20]))
   UNPACK32(ctx->h(6), cast(ubyte ptr,@digest[24]))


end sub

end namespace
