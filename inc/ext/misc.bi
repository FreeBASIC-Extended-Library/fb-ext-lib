''Title: misc.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
#ifndef FBEXT_MISC
#define FBEXT_MISC

#if not __FB_MT__
	#inclib "ext-misc"
	#ifdef FBEXT_MULTITHREADED
		#error "The multithreaded version of the library must be built using the -mt compiler option."
	#endif
#else
	#inclib "ext-misc.mt"
	#ifndef FBEXT_MULTITHREADED
		#define FBEXT_MULTITHREADED 1
	#endif
#endif

''Namespace: ext.misc

namespace ext.misc

	''Macro: FBEXT_MIN
	''
	# define FBEXT_MIN(a, b) iif((a) < (b), (a), (b))

	''Macro: FBEXT_MAX
	''
	# define FBEXT_MAX(a, b) iif((a) < (b), (b), (a))

	''Macro: FBEXT_SWAP
	''Type independant value swapper.
	''
	# macro FBEXT_SWAP(a, b)
	scope
		var tmp = a
		a = b
		b = tmp
	end scope
	# endmacro


	''Class: FILE_ITER
	''Provides a simple way to iterate through a directory structure.
	''
	'' never use this in multiple threads or this on one thread
	'' and DIR() on another, etc...
	''
	''Provides overloaded operators for FOR, STEP and NEXT to allow this syntax:
	''(start code)
	''for n as ext.misc.FILE_ITER("path/to/search", attribute) to "" 'or any string you would like to stop at
	''   print n.filename()
	''next
	''(end code)
	''The attribute is optional and can be left off compeletely. Defaults to files.
	''
	type FILE_ITER
		
		declare constructor( byref path as string )
		declare constructor( byref path as string, byval attrib_ as integer )
		
		declare operator for( )
		declare operator step( )
		declare operator next( byref end_cond as FILE_ITER ) as integer
		
		''Function: filename
		''Returns the current filename.
		''
		''Returns:
		''string containing the latest filename.
		''
		declare function filename( ) as string
	'private:

		as string p_pathname, p_latest
		as integer attrib
		
	end type

end namespace

#endif 'FBEXT_MISC
