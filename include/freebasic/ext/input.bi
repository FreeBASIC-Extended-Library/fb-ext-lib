''File: input.bi
''
''About: Code License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_INPUT_BI__
#define FBEXT_INPUT_BI__ 1

#include once "ext/detail/common.bi"

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

''Namespace: ext
namespace ext

    ''Class: xInput
    ''Provides a more extensible input capability than the standard
    ''input functions.
    type xInput

        Public:
        ''Variable: maxLength (uinteger)
        ''Set to non-zero and the input will be truncated at this number of characters.
        ''Defaults to 255.
        as uinteger maxLength

        ''Variable: password (bool)
        ''If true input is treated as a password and not displayed.
        ''Defaults to false.
        as bool password

        ''Variable: cancel (bool)
        ''If true input can be cancelled by pressing the ESC key.
        ''Defaults to false.
        as bool cancel

        ''Variable: numOnly (bool)
        ''If true input can only be numerical, defaults to false
        as bool numOnly

        ''Variable: timeout (double)
        ''If non-zero return what has been entered so far after # of seconds.
        as double timeout

        ''Variable: print_cb (sub ptr)
        ''Callback function used to print the current string at (x,y)
        ''Defaults are appropriate for most cases.
        print_cb as sub( byval x as uinteger, byval y as uinteger, byref str as string, byval data_ as any ptr )

        ''Variable: print_cb_data (any ptr)
        ''Passed to print_cb function when called.
        ''
        ''Notes:
        ''When using the default fbgfx callback this can be set to
        ''a pointer to an integer that will be used as the color.
        print_cb_data as any ptr

        ''Variable: callback (function ptr)
        ''Can be used as either a verification function or general callback
        ''allowing you to perform other functions in the background.
        ''Your function should be prepared to handle ch as 0 to allow backgroud
        ''updating without affecting the input. callback is called before
        ''print_cb (or the default printer if in use.)
        ''If you return <true> then the character in ch will be added to
        ''the input, if you return <false> it will not and if you return
        ''<invalid> then the get function will exit.
        callback as function( byval ch as uinteger, byval data_ as any ptr ) as bool

        ''Variable: callback_data (any ptr)
        ''Passed to callback function when called.
        callback_data as any ptr

        ''Function: get
        ''Get input from the user.
        ''
        ''Parameters:
        ''x - the x position to start input at, default: fb's pos function
        ''y - the y position to start input at, defalut: fb's csrlin function
        ''
        ''Returns:
        ''CHR(27) on user cancel or the entered string
        declare Function get( x as uinteger = Pos(), y as uinteger = Csrlin() ) as string
        declare constructor()

        Private:
        as string m_temp
        as uinteger m_temp_ret
        as uinteger m_y
        as uinteger m_x

    end type

end namespace
#endif
