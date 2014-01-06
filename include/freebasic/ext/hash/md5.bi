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

''Namespace: ext.hashes.md5
namespace ext.hashes.md5

''About: High Level API

''Function: checksum
''
''Parameters:
''x - string containing the data you wish to retrieve the checksum of.
''
declare function checksum overload ( byref x as string ) as string

''Function: checksum
''
''Parameters:
''x - <File> containing the data you wish to retrieve the checksum of.
''blocksize - (Optional) size of data to read from disk.
''
declare function checksum ( byref x as ext.File, byval blocksize as uinteger = 1048576 ) as string

''Function: checksum
''
''Parameters:
''x - pointer containing the data you wish to retrieve the checksum of.
''nbytes - the number of bytes that can be read from x.
''
declare function checksum ( byval x as any ptr, byval nbytes as uinteger ) as string

''About: Low Level API

''Type: State
''Represents the internal state needed by the low level md5 functions.
''
''See Also:
''<init> <append> <finish>
''
type state
	as uinteger count(2)	' message length in bits, lsw first
    as uinteger abcd(4)		' digest buffer
    as ubyte buf(64)
end type

''Sub: init
''Initializes a MD5 state to a known good value.
''
''Parameters:
''pms - pointer to state to initialize.
''
declare sub init( byval pms as state ptr )

''Sub: append
''Adds the checksum of the data passed to the current state.
''
''Parameters:
''pms - pointer to the state.
''data_ - const ptr to the data to checksum
''nbytes - the number of bytes available in data_
''
declare sub append( byval pms as state ptr, byval data_ as const ubyte ptr, byval nbytes as integer )

''Function: finish
''Apply last minute values to the state passed and return the checksum.
''
declare function finish ( byval pms as state ptr ) as string

end namespace

#endif
