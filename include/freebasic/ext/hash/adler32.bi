''Title: hash/adler32.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_HASH_ADLER32_BI__
#define FBEXT_HASH_ADLER32_BI__ -1

#include once "ext/detail/common.bi"

''Namespace: ext.hashes

namespace ext.hashes

	''Function: adler32
	''Returns the adler32 hash of a memory buffer.
	''
	''Parameters:
	''buf - pointer to the buffer to hash.
	''buf_len - the length of the buffer in bytes.
	''adler - optional value to initalize the hash with, defaults to 0
	''
	''Returns:
	''uinteger containing the hash.
	''
	declare function adler32 overload ( byval buf As const any ptr, byval buf_len as uinteger, byval adler as uinteger = 0 ) As uinteger

	''Function: adler32
	''Returns the adler32 hash of a string.
	''
	''Parameters:
	''buf - the string to hash.
	''
	''Returns:
	''uinteger containing the hash.
	''
	declare function adler32 overload ( byref buf as const string ) as uinteger

end namespace ' ext.hashes

#endif 'FBEXT_HASH_ADLER32_BI__
