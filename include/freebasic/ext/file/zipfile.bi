''Title: file/zipfile.bi
''
''About: License
''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_FILE_ZIPFILE_BI__
#define FBEXT_FILE_ZIPFILE_BI__ -1

#ifndef FBEXT_NO_EXTERNAL_LIBS
#ifndef FBEXT_NO_LIBZ
#ifndef FBEXT_NO_LIBZIP

#include once "ext/file/detail/common.bi"
#include once "ext/file/file.bi"

''Namespace: ext
namespace ext

    ''Class: ZipFile
    ''Represents a readonly zip archive.
    type ZipFile
        ''Sub: constructor
        ''Open a zip archive.
        ''
        ''Parameters:
        ''zfname - the name of the existing zip archive to open
        ''
        declare constructor ( byref zfname as const string )

        ''Sub: destructor
        ''Cleans up memory related to the zip archive itself.
        ''Does not affect any previously created File objects.
        ''
        declare destructor()

        ''Function: open
        ''Open a file inside of a zip archive.
        ''
        ''Parameters:
        ''zifname - the name (including path) of the file to open
        ''
        ''Returns:
        ''On success returns a pointer to a fully formed <File> object that you should delete when no longer needed.
        ''On failure returns NULL.
        ''
        declare function open( byref zifname as const string ) as File ptr
        private:
        m_data as any ptr
    end type

end namespace

#endif
#endif
#endif
#endif
