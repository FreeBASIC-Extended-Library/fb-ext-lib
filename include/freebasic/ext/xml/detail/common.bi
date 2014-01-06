''Title: xml/detail/common.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_XML_DETAIL_COMMON_BI__
#define FBEXT_XML_DETAIL_COMMON_BI__ -1

#include once "ext/detail/common.bi"

#if not __FB_MT__
    #inclib "ext-xml"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-xml.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

'' Macro: FBEXT_XML_IS_WHITESPACE
'' returns true if character is a whitespace character.
''
#define FBEXT_XML_IS_WHITESPACE(c) ((c) = &h09 or (c) = &h0a or (c) = &h0d or (c) = &h20)

namespace ext.xml

    '' Enum: char
    '' Contains the ASCII characters that are special or must be escaped in XML.
    ''
    enum char
        tab_   = &h09 '' \t
        lf     = &h0a '' \n
        cr     = &h0d '' \r
        space_ = &h20 '' \s
        exclam = &h21 '' !
        quot   = &h22 '' "
        hash   = &h23 '' #
        amp    = &h26 '' &
        apos   = &h27 '' '
        hyphen = &h2d '' -
        slash  = &h2f '' /
        lt     = &h3c '' <
        eq     = &h3d '' =
        gt     = &h3e '' >
        quest  = &h3f '' ?
        lsqbr  = &h5b '' [
        rsqbr  = &h5d '' ]
    end enum

    '' Function: encode_entities
    '' Encodes special characters in a string to their proper form.
    ''
    '' Parameters:
    '' text - text to encode entities in.
    ''
    '' Returns:
    '' string containing the properly formatted special characters.
    ''
    declare function encode_entities(byref text as const string) as string

    '' Function: decode_entities
    '' Decodes special characters in a string to their standard form.
    ''
    '' Parameters:
    '' text - text to decode entities in.
    ''
    '' Returns:
    '' string containing the unescaped characters.
    ''
    declare function decode_entities(byref text as const string) as string

    '' Function: encode_utf8
    '' Encodes a UTF-8 character to its string representation.
    ''
    '' Parameters:
    '' u - integer representation of the desired UTF-8 character.
    ''
    '' Returns:
    '' zstring ptr, the encoded UTF-8 character.
    ''
    declare function encode_utf8(byval u as integer) as zstring ptr

    '' Function: decode_utf8
    '' Decodes a UTF-8 character from its string representation.
    ''
    '' Parameters:
    '' src - zstring ptr containing the encoded UTF-8 character.
    '' u - integer representation of the encoded UTF-8 character is returned via this parameter.
    ''
    '' Returns:
    '' integer, the number of characters the UTF-8 character occupied while encoded.
    ''
    declare function decode_utf8(byval src as zstring ptr, byref u as integer) as integer

end namespace

#endif 'FBEXT_XML_DETAIL_COMMON_BI__
