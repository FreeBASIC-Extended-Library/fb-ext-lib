''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
#ifndef FBEXT_CONVERSION_BI__
#define FBEXT_CONVERSION_BI__ -1

#include once "ext/conversion/base64.bi"

#if not __FB_MT__
	#inclib "ext-conversion"
	#ifdef FBEXT_MULTITHREADED
		#error "The multithreaded version of the library must be built using the -mt compiler option."
	#endif
#else
	#inclib "ext-conversion.mt"
	#ifndef FBEXT_MULTITHREADED
		#define FBEXT_MULTITHREADED 1
	#endif
#endif

#endif 'FBEXT_CONVERSION_BI__
