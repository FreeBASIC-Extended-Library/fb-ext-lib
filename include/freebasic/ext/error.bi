''Title: error.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_ERR_BI__
# define FBEXT_ERR_BI__ -1

#if not __FB_MT__
    #inclib "ext-error"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-error.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

''Namespace: ext

namespace ext

    ''Enum: Error Codes
    ''Allows you easy access to every error code FreeBASIC can produce.
    ''
    ''  ERR_NO_ERROR
    ''
    ''  ERR_ILLEGAL_FUNCTION_CALL
    ''
    ''  ERR_FILE_NOT_FOUND
    ''
    ''  ERR_FILE_IO_ERROR
    ''
    ''  ERR_OUT_OF_MEMORY
    ''
    ''  ERR_ILLEGAL_RESUME
    ''
    ''  ERR_ARRAY_OUT_OF_BOUNDS
    ''
    ''  ERR_NULL_POINTER_ACCESS
    ''
    ''  ERR_NO_PRIVILEGES
    ''
    ''  ERR_INTERRUPTED_SIGNAL
    ''
    ''  ERR_ILLEGAL_INSTRUCTION
    ''
    ''  ERR_FLOAT_ERROR
    ''
    ''  ERR_SEG_VIOLATION
    ''
    ''  ERR_TERMINATION_REQUEST
    ''
    ''  ERR_ABNORMAL_TERMINATION
    ''
    ''  ERR_QUIT_REQUEST
    ''
    enum
        ERR_NO_ERROR
        ERR_ILLEGAL_FUNCTION_CALL
        ERR_FILE_NOT_FOUND
        ERR_FILE_IO_ERROR
        ERR_OUT_OF_MEMORY
        ERR_ILLEGAL_RESUME
        ERR_ARRAY_OUT_OF_BOUNDS
        ERR_NULL_POINTER_ACCESS
        ERR_NO_PRIVILEGES
        ERR_INTERRUPTED_SIGNAL
        ERR_ILLEGAL_INSTRUCTION
        ERR_FLOAT_ERROR
        ERR_SEG_VIOLATION
        ERR_TERMINATION_REQUEST
        ERR_ABNORMAL_TERMINATION
        ERR_QUIT_REQUEST
    end enum

    ''Function: GetErrorText
    ''Retrieves the English description of an error number
    ''
    ''Parameters:
    ''err_number - the error number to retrieve.
    ''
    ''Returns:
    ''String containing the error message.
    ''
    declare function GetErrorText (byval err_number as integer) as string

    ''Sub: setError
    ''Allows the user to set a custom error message for use in other code.
    ''
    ''Parameters:
    ''err_num - Integer value > 0 of the error code, user values should be above 100
    ''msg - String containing the English description of the error (not necessary for built-in codes. (optional)
    ''
    declare sub setError( byval err_num as integer, byref msg as string = "" )

    ''Function: getError
    ''Returns the last error, as an integer code reported by
    '' the Extended Library or other user code.
    ''
    declare function getError( ) as integer

    ''Sub: clearError
    ''Clears any stored error code.
    ''
    declare sub clearError( )

end namespace

# endif ' include guard
