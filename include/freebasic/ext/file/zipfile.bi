''Title: file/zipfile.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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
#include once "ext/error.bi"

''Namespace: ext
namespace ext

    ''Class: ZipFile
    ''Represents a zip archive.
    type ZipFile
        ''Sub: constructor
        ''Open a zip archive.
        ''
        ''Parameters:
        ''zfname - the name of the existing zip archive to open or to create
        ''
        ''Notes:
        ''If there is a problem opening/creating the archive then ext.getError will be set to non-zero.
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

        ''Function: fileCount
        ''Returns the number of files in the archive.
        declare function fileCount( ) as ulongint

        ''Sub: fileNames
        ''Get an array of all the files in the archive.
        ''
        ''Parameters:
        ''fns - array that will hold the filenames
        ''
        declare sub fileNames ( fns() as string )

        ''Function: add
        ''Adds a <File> to the archive optionally overwriting an existing file.
        ''
        ''Parameters:
        ''zifname - the file name inside of the zipfile to use
        ''zfil - the (pointer to) the <File> to add (or replace)
        ''ovrw - <Bool> defaults to False; Whether to overwrite an existing file.
        ''
        ''Returns:
        ''False on Success, True on Error
        declare function add(   byref zifname as const string, _
                                    byval zfil as File ptr, _
                                    byval ovrw as Bool = FALSE ) as Bool

        ''Function: name
        ''Renames a file in the archive.
        ''
        ''Parameters:
        ''orig - the current filename
        ''dest - the desired filename
        ''
        ''Returns:
        ''False on Success, True on Error
        declare function name( byref orig as const string, byref dest as const string ) as bool

        ''Function: remove
        ''Removes a file from the archive.
        ''
        ''Parameters:
        ''zfname - the filename to remove
        ''
        ''Returns:
        ''False on Success, True on Error
        declare function remove( byref zfname as const string ) as bool

        ''Function: forgetChanges
        ''Attempt to revert any unsaved changes to the archive.
        ''
        ''Returns:
        ''False on Success, True on Error
        declare function forgetChanges( ) as bool

        private:
        m_data as any ptr
    end type

end namespace

#endif
#endif
#endif
#endif
