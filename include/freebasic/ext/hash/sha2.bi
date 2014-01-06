''Title: hash/sha2.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Copyright (C) 2005, 2007 Olivier Gay <olivier.gay@a3.epfl.ch>
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef EXT_HASHES_SHA2_BI__
#define EXT_HASHES_SHA2_BI__ -1

#define SHA224_DIGEST_SIZE ( 224 / 8)
#define SHA256_DIGEST_SIZE ( 256 / 8)
#define SHA384_DIGEST_SIZE ( 384 / 8)
#define SHA512_DIGEST_SIZE ( 512 / 8)

#define SHA256_BLOCK_SIZE  ( 512 / 8)
#define SHA512_BLOCK_SIZE  (1024 / 8)
#define SHA384_BLOCK_SIZE  SHA512_BLOCK_SIZE
#define SHA224_BLOCK_SIZE  SHA256_BLOCK_SIZE

#include once "ext/detail/common.bi"
#include once "ext/file/file.bi"

''Namespace: ext.hashes.sha2
namespace ext.hashes.sha2

''About: High Level API

''Function: checksum
''
''Parameters:
''x - string containing the data you wish to retrieve the checksum of.
''keylen - the length of the key you wish to calculate, defaults to 256.
''
declare function checksum overload ( byref x as string, byval keylen as uinteger = 256 ) as string

''Function: checksum
''
''Parameters:
''x - <File> containing the data you wish to retrieve the checksum of.
''keylen - the length of the key you wish to calculate, defaults to 256.
''blocksize - (Optional) size of data to read from disk.
''
declare function checksum ( byref x as ext.File, byval keylen as uinteger = 256, byval blocksize as uinteger = 1048576 ) as string

''Function: checksum
''
''Parameters:
''x - pointer containing the data you wish to retrieve the checksum of.
''nbytes - the number of bytes that can be read from x.
''keylen - the length of the key you wish to calculate, defaults to 256.
''
declare function checksum ( byval x as any ptr, byval nbytes as uinteger, byval keylen as uinteger = 256 ) as string



type sha256_ctx
    as uinteger tot_len, _len
    as ubyte block(2 * SHA256_BLOCK_SIZE)
    as uinteger h(8)
end type

type sha224_ctx as sha256_ctx

type sha512_ctx
    as uinteger tot_len, _len
    as ubyte block(2 * SHA512_BLOCK_SIZE)
    as ulongint h(8)
end type

type sha384_ctx as sha512_ctx

'224
declare sub sha224_init( byval ctx as sha224_ctx ptr )
declare sub sha224_update( byval ctx as sha224_ctx ptr, byval message as const ubyte ptr, _
							byval mlen as uinteger )

declare sub sha224_final( byval ctx as sha224_ctx ptr, byval digest as zstring ptr )

'256
declare sub sha256_init( byval ctx as sha256_ctx ptr )
declare sub sha256_update( byval ctx as sha256_ctx ptr, byval message as const ubyte ptr, _
							byval len_ as uinteger )

declare sub sha256_final( byval ctx as sha256_ctx ptr, byval digest as zstring ptr )

'384
declare sub sha384_init( byval ctx as sha384_ctx ptr )
declare sub sha384_update( byval ctx as sha384_ctx ptr, byval message as const ubyte ptr, _
							byval mlen as uinteger )

declare sub sha384_final( byval ctx as sha384_ctx ptr, byval digest as zstring ptr )

'512
declare sub sha512_init( byval ctx as sha512_ctx ptr )
declare sub sha512_update( byval ctx as sha512_ctx ptr, byval message as const ubyte ptr, _
							byval mlen as uinteger )

declare sub sha512_final( byval ctx as sha512_ctx ptr, byval digest as zstring ptr )

end namespace

#endif
