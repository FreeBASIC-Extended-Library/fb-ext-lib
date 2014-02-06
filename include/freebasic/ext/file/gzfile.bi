''Title: file/gzfile.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_FILE_GZFILE_BI__
#define FBEXT_FILE_GZFILE_BI__ -1

#ifndef FBEXT_NO_EXTERNAL_LIBS
#ifndef FBEXT_NO_LIBZ

#include once "ext/file/detail/common.bi"
#include once "ext/file/file.bi"
#include once "ext/error.bi"

''Namespace: ext
namespace ext

''Function: newGZfileDriver
''Create a <FileSystemDriver> capable of reading or writing gzip files.
''
''Parameters:
''fn - the filename of the file to open.
''m - the <ACCESS_TYPE> to request
''
''Returns:
''Pointer to a valid <FileSystemDriver> object
declare function newGZfileDriver( byref fn as string, byval m as ACCESS_TYPE ) as FileSystemDriver ptr

''Function: gzFile
''Open a gzip format file as a <File> object.
''
''Parameters:
''fn - the filename to open
''m - the <ACCESS_TYPE> to request
''
''Returns:
''<File> object
''
declare function gzFile( byref fn as string, byval m as ACCESS_TYPE ) as File

end namespace

#endif
#endif
#endif
