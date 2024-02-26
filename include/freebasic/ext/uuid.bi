''Title: uuid.bi
''
''About: Code License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

#ifndef FBEXT_MISC_UUID_BI__
#define FBEXT_MISC_UUID_BI__ -1

#ifndef FBEXT_MISC
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
#endif

namespace ext.misc

    ''Class: UUID
    ''Represents an Universally Unique Identifier.
    ''
    type UUID
        ''Sub: default constructor
        ''Construct a null UUID.
        ''
        declare constructor()

        ''Sub: copy constructor
        ''Copy an UUID.
        ''
        declare constructor( byref rhs as const UUID )

        ''Sub: constructor
        ''Construct an UUID from a string in one of the following formats:
        '' * 12345678123456781234567812345678
        '' * {12345678-1234-5678-1234-567812345678}
        ''
        declare constructor( byref rhs as string )

        ''Sub: randomize
        ''Generate a random UUID.
        ''
        declare sub randomize()

        ''Sub: clear
        ''Reset an UUID to null.
        ''
        declare sub clear()

        ''Function: isNull
        ''Returns true if the UUID is null.
        ''
        declare function isNull() as integer

        ''Operator: cast
        ''Return a string representative of the UUID in the format:
        '' * {12345678-1234-5678-1234-567812345678}
        ''
        declare operator cast() as string

        'private:
        as ubyte d(16)
    end type

    ''Operator: =
    ''Tests 2 UUIDs for equality.
    ''
    declare operator = ( byref lhs as uuid, byref rhs as uuid ) as integer


end namespace

#endif
