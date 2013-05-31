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
        declare constructor ( byref zfname as const string )
        declare destructor()
        declare function open( byref zifname as const string ) as File ptr
        private:
        m_data as any ptr
    end type

end namespace

#endif
#endif
#endif
#endif
