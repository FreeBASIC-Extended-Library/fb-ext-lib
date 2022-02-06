''Title: hash/md5.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_HASH_MD5_BI__
#define FBEXT_HASH_MD5_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/file/file.bi"

''Namespace: ext.hashes
namespace ext.hashes

''About: High Level API

''Function: md5
''
''Parameters:
''x - string containing the data you wish to retrieve the checksum of.
''
declare function md5 overload ( byref x as string ) as string

''Function: md5
''
''Parameters:
''x - <File> containing the data you wish to retrieve the checksum of.
''blocksize - (Optional) size of data to read from disk.
''
declare function md5 ( byref x as ext.File, byval blocksize as uinteger = 1048576 ) as string

''Function: md5
''
''Parameters:
''x - pointer containing the data you wish to retrieve the checksum of.
''nbytes - the number of bytes that can be read from x.
''
declare function md5 ( byval x as any ptr, byval nbytes as uinteger ) as string

''About: Low Level API

''Type: md5_State
''Represents the internal state needed by the low level md5 functions.
''
''See Also:
''<init> <append> <finish>
''
type md5_state
	as ulong count(2)	' message length in bits, lsw first
    as ulong abcd(4)		' digest buffer
    as ubyte buf(64)
end type

''Sub: md5_init
''Initializes a MD5 state to a known good value.
''
''Parameters:
''pms - pointer to state to initialize.
''
declare sub md5_init( byval pms as md5_state ptr )

''Sub: md5_append
''Adds the checksum of the data passed to the current state.
''
''Parameters:
''pms - pointer to the state.
''data_ - const ptr to the data to checksum
''nbytes - the number of bytes available in data_
''
declare sub md5_append( byval pms as md5_state ptr, byval data_ as const ubyte ptr, byval nbytes as integer )

''Function: md5_finish
''Apply last minute values to the state passed and return the checksum.
''
declare function md5_finish ( byval pms as md5_state ptr ) as string

end namespace

#endif
