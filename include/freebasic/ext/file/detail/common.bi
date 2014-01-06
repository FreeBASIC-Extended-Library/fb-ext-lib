''Title: common.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

namespace ext

        ''Enum: ACCESS_TYPE
        ''Used to specify the access to use when opening a file.
        ''
        ''R - Open the file read-only.
        ''W - Open the file for write access.
        ''RW - Open the file for reading and writing.
        ''
        enum ACCESS_TYPE

            R = 0
            W
            RW

        end enum

type FileSystemDriverF as FileSystemDriver

type drvfsopen as function( byval t as FileSystemDriverF ptr ) as bool
type drvfsclose as sub( byval t as FileSystemDriverF ptr )
type drvfslof as function( byval t as FileSystemDriverF ptr ) as ulongint
type drvfsloc as function( byval t as FileSystemDriverF ptr ) as ulongint
type drvfsseek as function(  byval t as FileSystemDriverF ptr, byval p as ulongint ) as bool
type drvfseof as function(  byval t as FileSystemDriverF ptr ) as bool
type drvfsget as function( byval t as FileSystemDriverF ptr, byval pos_ as ulongint, byval p as ubyte ptr, byval n as SizeType ) as SizeType
type drvfsput as function( byval t as FileSystemDriverF ptr, byval pos_ as ulongint, byval p as ubyte ptr, byval n as SizeType ) as SizeType

''Type: FileSystemDriver
''A group of function pointers to allow access to a specific filesystem.
type FileSystemDriver
    fsopen as drvfsopen
    fsclose as drvfsclose
    fslof as drvfslof
    fsloc as drvfsloc
    fsseek as drvfsseek
    fseof as drvfseof
    fsget as drvfsget
    fsput as drvfsput
    driverdata as any ptr
end type

''Function: newMemoryFileDriver
''Creates a driver allowing one to access a region of memory as if it were a file.
''
''Params:
''d - ubyte ptr to a region of memory that is already allocated and managed by the user.
''dlen - the length (in bytes) of the memory pointed to by d
''
''Returns:
''A fully functioning driver representing a memory region as a file.
''
declare function newMemoryFileDriver( byval d as ubyte ptr, byval dlen as SizeType, byval frefun as sub(byval as any ptr) = 0 ) as FileSystemDriver ptr

end namespace

# endif ' include guard

