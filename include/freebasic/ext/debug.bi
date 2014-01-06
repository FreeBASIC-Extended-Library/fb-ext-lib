''Title: debug.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
#ifndef FBEXT_DEBUG_BI__
#define FBEXT_DEBUG_BI__ -1

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

#endif 'FBEXT_DEBUG
