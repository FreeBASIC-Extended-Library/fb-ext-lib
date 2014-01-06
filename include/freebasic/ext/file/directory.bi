''Title: file/directory.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group License. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_FILE_DIRECTORY_BI__
#define FBEXT_FILE_DIRECTORY_BI__ -1

#include once "ext/file/detail/common.bi"

''Namespace: ext
namespace ext

''Class: Directory
''Perform filesystem operations in a platform independant manner.
''This object is also <Printable>
''
type Directory
    public:
    ''Sub: Default constructor
    ''Creates a Directory object that points to the current directory.
    declare constructor()

    ''Sub: Path constructor
    ''Creates a Directory object that points to the specified path.
    ''
    ''Parameters:
    ''path - the path to set
    ''
    declare constructor( byref path as const string )

    ''Sub: Copy Constructor
    ''Create an Directory object from a previously created Directory
    ''
    ''Parameters:
    ''rhs - the Directory object to copy from
    ''
    declare constructor( byref rhs as const Directory )
    declare destructor( )

    ''Function: cd
    ''Changes to the specified directory.
    ''
    ''Parameters:
    ''path - the path to change to
    ''
    ''Returns:
    ''True on success, False on Error
    ''
    declare function cd( byref path as string ) as bool

    ''Function: cdUp
    ''Change the directory up one level.
    ''
    ''Returns:
    ''True if successful, False if at the root
    ''
    declare function cdUp( ) as bool

    ''Function: exists
    ''Check if the specified file or path exist.
    ''
    ''Parameters:
    ''p - the file or path to check
    ''
    ''Returns:
    ''True if p exists, False if it does not or error.
    ''
    declare function exists( byref p as const string ) as bool

    ''Function: activate
    ''Actually changes the directory in the context of the program so
    ''other functions operate in this path.
    ''
    ''Returns:
    ''True on Success, False on error
    ''
    declare function activate() as bool

    declare operator cast() as string

    private:
    m_path as string
end type

''Namespace: dir
namespace dir

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
    const SEPERATOR as string = "\"
    const OTHER_SEPERATOR as string = "/"
#else
    const SEPERATOR as string = "/"
    const OTHER_SEPERATOR as string = "\"
#endif

''Function: root
''Returns a <Directory> object pointing to the root of the current
''filesystem. On Unix systems this is "/", on DOS and Windows
''systems this is the root directory of the current drive.
declare function root () as Directory

''Function: home
''Returns a <Directory> object pointing to the current user's
''home directory. On DOS systems this is equivalent to <root>.
declare function home () as Directory

''Function: temp
''Returns a <Directory> object pointing to the system's temporary
''directory. On Unix systems this is usually "/var". On DOS and
''Windows 9x systems this is usually "C:\TEMP". The location
''varies on Windows NT systems but is set in the environment
''variable %TEMP%.
declare function temp () as Directory

''Function: toNativeSeperators
''Converts all seperators in the passed string to the seperators
''the current platform expects.
''
''Parameters:
''pathn - string containing the path with possibly different path seperators
''
''Returns:
''String containing only seperators recognized by the current platform.
declare function toNativeSeparators( byref pathn as const string ) as string

''Function: cleanPath
''Removes all multiple directory separators
declare function cleanPath( byref pathn as const string ) as string

end namespace
end namespace

#endif

