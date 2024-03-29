''Title: misc.bi
''
''About: About this Module
''The misc module holds several useful yet small function, macros and classes
''that don't necessarily belong anywhere else.
''
''About: Code License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# pragma once
#ifndef FBEXT_MISC
#define FBEXT_MISC -1

#include once "ext/detail/common.bi"
#include once "string.bi"

'include other misc module headers
#include once "ext/uuid.bi"
#include once "ext/input.bi"
#include once "ext/datetime.bi"


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

    ''Macro: FBEXT_TIMED_OP_START
    ''Start timing a sequence of events.
    ''
    ''Note:
    ''You should only use this macro once per scope.
    #define FBEXT_TIMED_OP_START var __ext_time_op_in = timer

    ''Macro: FBEXT_TIMED_OP_END
    ''Ends timing a sequence of events.
    ''
    ''Note:
    ''You should only use this macro once per scope.
    ''
    ''Returns:
    ''string containing a formatted value of the time difference in seconds.
    #define FBEXT_TIMED_OP_END format(timer-__ext_time_op_in,"#####0.######")

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
