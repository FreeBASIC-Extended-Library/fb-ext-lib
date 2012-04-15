''Title: common.bi
''
''About: License
'' Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_FILE_COMMON_BI__
# define FBEXT_FILE_COMMON_BI__ -1

# include once "ext/detail/common.bi"

#if not __FB_MT__
	#inclib "ext-file"
	#ifdef FBEXT_MULTITHREADED
		#error "The multithreaded version of the library must be built using the -mt compiler option."
	#endif
#else
	#inclib "ext-file.mt"
	#ifndef FBEXT_MULTITHREADED
		#define FBEXT_MULTITHREADED 1
	#endif
#endif

# endif ' include guard

