'https://github.com/brainhub/SHA3IUF
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''Copyright (C) 2015 Andrey Jivsov <crypto@brainhub.org>
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
#include once "ext/hash/sha3.bi"
#include once "ext/error.bi"
#include once "ext/math/detail/common.bi"

#define SHA3_ROTL64(x, y) (((x) shl (y)) OR ((x) shr ((sizeof(ulongint)*8) - (y))))

namespace ext.hashes

function sha3 overload ( byref x as string, byval keylen as sha3_keylen = SHA3_256 ) as string

    return sha3(@(x[0]),len(x),keylen)

end function

'':::
function sha3 ( byref x as ext.File, byval keylen as sha3_keylen = SHA3_256, byval blocksize as uinteger = 1048576 ) as string

    if x.open() = true then return "Checksum could not be calculated, error opening file for reading. Error: " & str(x.LastError) & " - " & GetErrorText(x.LastError)

    if keylen <> 256 and keylen <> 384 and keylen <> 512 then return "Invalid key length"

    dim as sha3_ctx ptr st = new sha3_ctx

    var len_file = x.lof()
    dim as uinteger read_size = 0
    dim as ulongint left_in_file = len_file

    if len_file < blocksize then
        read_size = len_file
    else
        read_size = blocksize
    end if


    select case keylen
    case SHA3_256
        sha3_256_init(st)
    case SHA3_384
        sha3_384_init(st)
    case SHA3_512
        sha3_512_init(st)
    end select

    dim buffer as ubyte ptr
    buffer = new ubyte[read_size]
    if buffer = 0 then return "Checksum could not be calculated, error allocating memory."

    while left_in_file >= read_size

        x.get( , *buffer, read_size )

        sha3_update( st, buffer, read_size )

        left_in_file -= read_size

    wend

    delete[] buffer

    if left_in_file > 0 then

        buffer = new ubyte[left_in_file]

        x.get(, *buffer, left_in_file )

        sha3_update( st, buffer, left_in_file )

        delete[] buffer

    end if

    x.close()

    var retstr = ""

    select case keylen
    case SHA3_256
        retstr = space(SHA3_256_DIGEST_SIZE)
    case SHA3_384
        retstr = space(SHA3_384_DIGEST_SIZE)
    case SHA3_512
        retstr = space(SHA3_512_DIGEST_SIZE)
    end select

    sha3_final( st, retstr )

    sha3_deinit( st )
    
    delete st

    var real_retstr = ""

    for n as integer = 0 to len(retstr) - 1
        var remp = lcase(hex(retstr[n]))
        if len(remp) = 1 then remp = "0" & remp
        real_retstr = real_retstr & remp
    next

    return real_retstr

end function

'':::
function sha3 ( byval x as any ptr, byval nbytes as uinteger, byval keylen as sha3_keylen = SHA3_256 ) as string

    if keylen <> 256 AND keylen <> 384 AND keylen <> 512 then return "Invalid key length"

    dim as sha3_ctx ptr st = new sha3_ctx

    select case keylen
    case SHA3_256
        sha3_256_init(st)
    case SHA3_384
        sha3_384_init(st)
    case SHA3_512
        sha3_512_init(st)
    end select

    sha3_update (st, cast( ubyte ptr, x ), nbytes )
    
    var retstr = ""

    select case keylen
    case SHA3_256
        retstr = space(SHA3_256_DIGEST_SIZE)
    case SHA3_384
        retstr = space(SHA3_384_DIGEST_SIZE)
    case SHA3_512
        retstr = space(SHA3_512_DIGEST_SIZE)
    end select

    sha3_final( st, retstr )

    sha3_deinit( st )

    delete st

    var real_retstr = ""

    for n as integer = 0 to len(retstr) - 1
        var remp = lcase(hex(retstr[n]))
        if len(remp) = 1 then remp = "0" & remp
        real_retstr = real_retstr & remp
    next

    return real_retstr

end function

dim shared keccakf_rndc(24) as ulongint = _
{ _
    (&h0000000000000001ULL), (&h0000000000008082ULL), _
    (&h800000000000808aULL), (&h8000000080008000ULL), _
    (&h000000000000808bULL), (&h0000000080000001ULL), _
    (&h8000000080008081ULL), (&h8000000000008009ULL), _
    (&h000000000000008aULL), (&h0000000000000088ULL), _
    (&h0000000080008009ULL), (&h000000008000000aULL), _
    (&h000000008000808bULL), (&h800000000000008bULL), _
    (&h8000000000008089ULL), (&h8000000000008003ULL), _
    (&h8000000000008002ULL), (&h8000000000000080ULL), _
    (&h000000000000800aULL), (&h800000008000000aULL), _
    (&h8000000080008081ULL), (&h8000000000008080ULL), _
    (&h0000000080000001ULL), (&h8000000080008008ULL) _
}

dim shared keccakf_rotc(24) as ubyte = _
{ _
    1, 3, 6, 10, 15, 21, 28, 36, 45, 55, 2, 14, 27, 41, 56, 8, 25, 43, 62, _
    18, 39, 61, 20, 44 _
}

dim shared keccakf_piln(24) as ubyte = _
{ _
    10, 7, 11, 17, 18, 3, 5, 16, 8, 21, 24, 4, 15, 23, 19, 13, 12, 2, 20, _
    14, 22, 9, 6, 1 _
}

sub sha3_init( byval ctx as sha3_ctx ptr, byval bitSize as sha3_keylen = SHA3_256)
    ctx->bitSize = bitSize
    ctx->s = new ulongint[25]
    ctx->sb = cast(ubyte ptr, ctx->s)
    ctx->capacityWords = 2 * (bitSize) \ (8 * sizeof(ulongint))
end sub

sub sha3_deinit( byval ctx as sha3_ctx ptr )
    if (ctx->s <> null) then
        delete[] (ctx->s)
    endif
end sub

sub sha3_256_init( byval ctx as sha3_ctx ptr )
    sha3_init(ctx, SHA3_256)
end sub

sub sha3_384_init( byval ctx as sha3_ctx ptr )
    sha3_init(ctx, SHA3_384)
end sub

sub sha3_512_init( byval ctx as sha3_ctx ptr )
    sha3_init(ctx, SHA3_512)
end sub

sub sha3_update( byval ctx as sha3_ctx ptr, byval message as const ubyte ptr, byval mlen as uinteger )
    '0...7 -- how much is needed to have a word
    dim as uinteger old_tail = (8 - ctx->byteIndex) AND 7
    dim as uinteger words
    dim as uinteger tail
    
    if (mlen < old_tail) then
        for n_ as longint = mlen to 0 step -1
            var n = cuint(n_)
            ctx->saved OR= culngint(message[n] SHL (ctx->byteIndex * 8))
            ctx->byteIndex += 1
        next n_
        return
    end if

    if (old_tail) then 'will have one word to process
        mlen -= old_tail
        while (old_tail > 0)
            ctx->saved OR= culngint((*message)) shl (ctx->byteIndex * 8)
            ctx->byteIndex += 1
            message += 1
            old_tail -= 1
        wend
        'now ready to add saved to the sponge
        ctx->s[ctx->wordIndex] XOR= ctx->saved
        ctx->byteIndex = 0
        ctx->saved = 0
    end if

    'now work in full words directly from input
    words = mlen / sizeof(ulongint)
    tail = mlen - words * sizeof(ulongint)

    if (words > 0) then
        for i as uinteger = 0 to words
            dim t as ulongint = culngint(message[0]) OR _
                (culngint(message[1]) SHL 8 * 1) OR _
                (culngint(message[2]) SHL 8 * 2) OR _
                (culngint(message[3]) SHL 8 * 3) OR _
                (culngint(message[4]) SHL 8 * 4) OR _
                (culngint(message[5]) SHL 8 * 5) OR _
                (culngint(message[6]) SHL 8 * 6) OR _
                (culngint(message[7]) SHL 8 * 7) 

            ctx->s[ctx->wordIndex] XOR= t

            message += sizeof(ulongint)
        next i
    end if

    while (tail > 0)
        ctx->saved OR= culngint(*message) SHL (ctx->byteIndex * 8)
        message += 1
        ctx->byteIndex += 1
    wend
end sub

sub keccakf(byval s as ulongint ptr)
    dim as ulongint t
    dim as ulongint bc(5)

    const KECCAK_ROUNDS = 24
    for round as integer = 0 to (KECCAK_ROUNDS - 1)
        ' Theta
        for i as integer = 0 to 4
            bc(i) = s[i] XOR s[i + 5] XOR s[i + 10] XOR s[i + 15] XOR s[i + 20]
        next i

        for i as integer = 0 to 4
            t = bc((i + 4) mod 5) XOR SHA3_ROTL64(bc((i + 1) MOD 5), 1)
            for j as integer = 0 to 24
                s[j + i] XOR= t
            next j
        next i

        ' Rho Pi
        t = s[1]
        for i as integer = 0 to 23
            var j = keccakf_piln(i)
            bc(0) = s[j]
            s[j] = SHA3_ROTL64(t, keccakf_rotc(i))
            t = bc(0)
        next i

        ' Chi
        for j as integer = 0 to 24 step 5
            for i as integer = 0 to 4
                bc(i) = s[j + i]
            next i
            for i as integer = 0 to 4
                s[j + i] XOR= (NOT(bc((i + 1) MOD 5)) AND bc((i + 2) MOD 5))
            next i
        next j

        ' Iota
        s[0] XOR= keccakf_rndc(round)
    next round
end sub

sub sha3_final( byval ctx as sha3_ctx ptr, byval digest as zstring ptr )
    dim as ulongint t = shl64(((&h02ull OR shl64(1, 2))), ((ctx->byteIndex) * 8))
    
    ctx->s[ctx->wordIndex] XOR= (ctx->saved XOR t)
    ctx->s[25 - (ctx->capacityWords - 1)] XOR= &h8000000000000000ULL
    keccakf(ctx->s)

    for n as integer = 0 to (cast(integer, ctx->bitSize) / 8)
        digest[n] = asc(hex(ctx->sb[n]))
    next n
end sub

end namespace