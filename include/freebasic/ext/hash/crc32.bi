''Title: hash/crc32.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

#ifndef FBEXT_HASH_CRC32_BI__
#define FBEXT_HASH_CRC32_BI__ -1

#include once "ext/detail/common.bi"

''Namespace: ext.hashes

namespace ext.hashes

	''Function: crc32
	''Calculates the 32 bit cyclic redundancy check of a memory buffer.
	''
	''Parameters:
	''buf - pointer to memory buffer.
	''buf_len - length of buffer in bytes.
	''crc - optional value to initialize the hash with, defaults to 0
	''
	''Returns:
	''ulong containing the hash.
	''
	declare function crc32 overload ( byval buf As const any ptr, byval buf_len as uinteger, byval crc as ulong = 0 ) As ulong

	''Function: crc32
	''Calculates the 32 bit cyclic redundancy check of a string.
	''
	''Parameters:
	''buf - string to hash.
	''
	''Returns:
	''ulong containing the hash.
	''
	declare function crc32 ( byref buf as const string ) as ulong

end namespace ' ext.hashes

#endif 'FBEXT_HASH_CRC32_BI__
