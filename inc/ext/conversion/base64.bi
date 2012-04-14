''Title: conversion/base64.bi
''
''About: License
''Copyright (c) 2007-2011, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2007, Daniel Verkamp (DrV) http://drv.nu
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_BASE64_BI__
#define FBEXT_BASE64_BI__ -1

#include once "ext/detail/common.bi"

#if not __FB_MT__
    #inclib "ext-conversion"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-conversion.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

''Namespace: ext.conversion.base64

namespace ext.conversion.base64

    ''Function: encode
    ''Encodes data into base64
    ''
    ''Parameters:
    ''source - pointer to the raw data to be encoded
    ''source_len - the size of the source data
    ''
    ''Returns:
    ''A base64 encoded representation of the data.
    declare function encode overload ( byval src as const ubyte ptr, byval s_l as ext.SizeType ) as string

    ''Function: encode
    ''Encodes data into base64
    ''
    ''Parameters:
    ''source - string to be encoded
    ''
    ''Returns:
    ''A base64 encoded representation of the data.
    declare function encode overload ( byref src as const string ) as string

    ''Sub: decode
    ''Decodes base64 encoded data into its raw binary form.
    ''
    ''Parameters:
    ''dest - ubyte ptr where data will go.
    ''source - pointer to base64 encode data.
    ''source_length - the length in bytes of the source data.
    ''
    declare sub decode overload (byval dest as ubyte ptr, byval source as const ubyte ptr, byval source_length as ext.SizeType)

    ''Sub: decode
    ''Decodes a base64 encoded string into a unencoded string.
    ''
    ''Parameters:
    ''dest - string where decoded data will go.
    ''source - string holding encoded data.
    ''
    declare sub decode overload (byref dest as string, byref source as const string )

    ''Function: decoded_length
    ''Gives the decoded length of a base64 encoded buffer for sizing the destination buffer.
    ''
    ''Parameters:
    ''source_length - uinteger containing the length of the source in bytes.
    ''
    ''Returns:
    ''uinteger containing the total length of the raw data.
    ''
    declare function decoded_length (byval source_length as ext.SizeType) as ext.SizeType

end namespace 'ext.base64
