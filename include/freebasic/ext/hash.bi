''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_HASH__BI__
# define FBEXT_HASH__BI__ -1

# include once "ext/hash/joaat.bi"
# include once "ext/hash/crc32.bi"
# include once "ext/hash/adler32.bi"
# include once "ext/hash/md5.bi"
# include once "ext/hash/sha2.bi"

#if not __FB_MT__
	#inclib "ext-hash"
	#ifdef FBEXT_MULTITHREADED
		#error "The multithreaded version of the library must be built using the -mt compiler option."
	#endif
#else
	#inclib "ext-hash.mt"
	#ifndef FBEXT_MULTITHREADED
		#define FBEXT_MULTITHREADED 1
	#endif
#endif

# endif ' include guard
