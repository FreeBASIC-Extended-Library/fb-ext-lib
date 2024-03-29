''Title: debug.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# pragma once
#ifndef FBEXT_DEBUG_BI__
#define FBEXT_DEBUG_BI__ -1

#include once "ext/detail/common.bi"
#include once "ext/misc.bi"

# if not __FB_DEBUG__
	# define FBEXT_DPRINT(x)

# else

	''Macro: FBEXT_DPRINT
	''Debug printing macro, when compiled with -g this will print to standard error.
	''
	''When compiled normally however, it will be replaced by dummy code to blank it out.
	''
	''Works with all built-in types and any UDT that has a cast to string operator.
	''
	#macro FBEXT_DPRINT(x)
	:
	scope
	   dim as integer FF = freefile(), openres
	
	   openres = open err(for output as #FF)
	
	   if openres = 0 then
	      print #FF, x
	      close #FF
	
	   else
	      print "Unable to open std::err for writing, aborting program"
		print "Last message: " & x
	      end 5
	
	   end if
	
	end scope
	:
	#endmacro

# endif

''Namespace: ext
namespace ext

	''Function: print_buffer
	''This function is useful for pretty printing bytes of data from a memory buffer in a 
	''structured way.
	''
	''Parameters:
	''header - this string will print before the data
	''buf - the memory buffer to print the bytes of
	''blen - the length of the buffer in bytes
	''perRow - how many bytes will appear on each line
	''
	declare sub print_buffer(byref header as const string, byval buf as any ptr, byval blen as SizeType, byval perRow as ulong)

end namespace

#endif 'FBEXT_DEBUG
