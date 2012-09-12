''Title: file/directory.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group License. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_FILE_DIRECTORY_BI__
#define FBEXT_FILE_DIRECTORY_BI__ -1

''Namespace: ext
namespace ext

''Class: Directory
''Perform filesystem operations in a platform independant manner.
''
type Directory
    public:
    declare constructor()
    declare constructor( byref path as const string )
    declare constructor( byref rhs as const Directory )
    declare destructor( )

    declare function cd( byref path as string ) as bool
    declare function cdUp( ) as bool
    declare operator cast() as string

    private:
    m_path as string
end type

''Namespace: dir
namespace dir

#if defined(__FB_WIN32__) or defined(__FB_DOS__)
    const SEPERATOR as string = "\"
#else
    const SEPERATOR as string = "/"
#endif

''Function: root
''Returns a <Directory> object pointing to the root of the current
''filesystem. On Unix systems this is "/", on DOS and Windows
''systems this is the root directory of the current drive.
declare function root () as Directory

''Function: rootPath
''Returns a string containing the path of the root of the current
''filesystem. On Unix systems this is "/", on DOS and Windows
''systems this is the root directory of the current drive.
declare function rootPath () as string

''Function: home
''Returns a <Directory> object pointing to the current user's
''home directory. On DOS systems this is equivalent to <root>.
declare function home () as Directory

''Function: homePath
''Returns a string containing the path to the current user's
''home directory. On DOS systems this is equivalent to <rootPath>.
declare function homePath () as string

''Function: temp
''Returns a <Directory> object pointing to the system's temporary
''directory. On Unix systems this is usually "/var". On DOS and
''Windows 9x systems this is usually "C:\TEMP". The location
''varies on Windows NT systems but is set in the environment
''variable %TEMP%.
declare function temp () as Directory

''Function: tempPath
''Returns a string containing the path to the system's temporary
''directory.
declare function tempPath () as string

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

