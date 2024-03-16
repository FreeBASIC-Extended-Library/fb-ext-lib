''Title: hash/sha3.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Copyright (C) 2015 Andrey Jivsov <crypto@brainhub.org>
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

#ifndef EXT_HASHES_SHA3_BI__
#define EXT_HASHES_SHA3_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/file/file.bi"

#define SHA3_256_DIGEST_SIZE ( 256 / 8)
#define SHA3_384_DIGEST_SIZE ( 384 / 8)
#define SHA3_512_DIGEST_SIZE ( 512 / 8)

#define SHA3_KECCAK_SPONGE_WORDS 25 '(((1600)/8)/sizeof(ulongint))

''Namespace: ext.hashes
namespace ext.hashes

''About: High Level API

''Enum: sha3_keylen
''Valid key lengths for sha2 digests
''
enum sha3_keylen 
    SHA3_256 = 256
    SHA3_384 = 384
    SHA3_512 = 512
end enum

''Function: sha3
''
''Parameters:
''x - string containing the data you wish to retrieve the checksum of.
''keylen - the length of the key you wish to calculate, defaults to 256.
''
declare function sha3 overload ( byref x as string, byval keylen as sha3_keylen = SHA3_256 ) as string

''Function: sha3
''
''Parameters:
''x - <File> containing the data you wish to retrieve the checksum of.
''keylen - the length of the key you wish to calculate, defaults to 256.
''blocksize - (Optional) size of data to read from disk.
''
declare function sha3 ( byref x as ext.File, byval keylen as sha3_keylen = SHA3_256, byval blocksize as uinteger = 1048576 ) as string

''Function: sha3
''
''Parameters:
''x - pointer containing the data you wish to retrieve the checksum of.
''nbytes - the number of bytes that can be read from x.
''keylen - the length of the key you wish to calculate, defaults to 256.
''
declare function sha3 ( byval x as any ptr, byval nbytes as uinteger, byval keylen as sha3_keylen = SHA3_256 ) as string


type sha3_ctx
    as ulongint saved
    as ulongint ptr s
    as ubyte ptr sb
    as uinteger byteIndex
    as uinteger wordIndex
    as uinteger capacityWords
    as sha3_keylen bitSize
end type

declare sub sha3_context_init( byval ctx as sha3_ctx ptr, byval bitSize as sha3_keylen = SHA3_256, byval useKeccak as bool = false )

declare sub sha3_update( byval ctx as sha3_ctx ptr, byval message as const ubyte ptr, _
							byval mlen as uinteger )

declare sub sha3_finalize( byval ctx as sha3_ctx ptr, byval digest as zstring ptr )
declare sub sha3_context_destroy( byval ctx as sha3_ctx ptr )

end namespace

#endif
