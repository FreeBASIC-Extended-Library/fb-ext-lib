''Title: php/strings.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_PHP_STRINGS_BI__
# define FBEXT_PHP_STRINGS_BI__ -1

# include once "ext/detail/common.bi"

'' Namespace: ext.php
namespace ext.php

    '' Function: AddCSlashes
    ''   *AddCSlashes* returns a copy of the string *text*, with each
    ''   occurrence of any matching character in *chars* prefixed with
    ''   a backslash (\). For example, `AddCSlashes(" [text] ", "[]")`
    ''   evaluates to `" \[text\] "`.
    ''
    '' Parameters:
    ''   text - the text to copy.
    ''   chars - the characters to prefix, if found.
    ''
    '' Returns:
    ''   If *text* is an empty string ("") then an empty string is returned.
    ''   If *chars* is an empty string or has no matching characters from
    ''   *text*, *text* is returned. Otherwise, the new string is returned.
    declare function AddCSlashes ( byref text as const string, byref chars as const string ) as string

    '' Function: AddSlashes
    ''   *AddSlashes* returns *AddCSlashes(*text*, *!"'\"\\"*)*, to prefix
    ''   each occurrence of a quote ('), double-quote (") or backslash (\)
    ''   character with a backslash character.
    ''
    '' Parameters:
    ''   text - the text to copy.
    ''
    '' Returns:
    ''   *AddCSlashes(*text*, *!"'\"\\"*)*
    declare function AddSlashes ( byref text as const string ) as string

    '' Function: Bin2Hex
    ''   *Bin2Hex* returns a string of hexadecimal characters, two for each
    ''   character in the string *text*, representing their ASCII code value.
    ''   Values less than &h10 are left-padded with a zero (asc("0")).
    ''
    '' Parameters:
    ''   text - the text
    ''
    '' Returns:
    ''   If *text* is an empty string (""), then an empty string is returned.
    ''   Otherwise, the new string is returned.
    declare function Bin2Hex ( byref text as const string ) as string

    '' Function: Chunk_Split
    ''   *Chunk_Split* returns a copy of the string *text*, split into
    ''   substrings of a certain size *length* that are suffixed with the
    ''   characters in the string *ending*. For example,
    ''   `Bin2Hex("abcd1234", 3, ":")` evaluates to `"abc:d12:34:"`.
    ''
    '' Parameters:
    ''   text - the text to copy.
    ''   length - the number of characters per substring.
    ''   ending - the characters
    ''
    '' Returns:
    ''   If *text* is an empty string (""), then an empty string is returned.
    ''   Otherwise, the new string is returned.
    declare function Chunk_Split ( byref text as const string, byval length as integer = 76, byref ending as const string = !"\r\n" ) as string

    enum Count_CharsEnum
        all_chars
        used_chars
        unused_chars
    end enum

    '' Function: Count_Chars
    ''   *Count_Chars* gets information about the characters used in a string.
    ''
    '' Parameters:
    ''   text - the string to analyze.
    ''   what - the type of information to return.
    ''
    '' Returns:
    ''   If *what* is *Count_CharsEnum.used_chars*, then a string consisting of
    ''   each unique character in *text* is returned. If *what* is
    ''   *Count_CharsEnum.unused_chars*, then a string constisting of each
    ''   character not used in *text* is returned. Any other value for *what*
    ''   is not supported and an empty string ("") will be returned.
    declare function Count_Chars overload ( byref text as const string, byval what as Count_CharsEnum = used_chars ) as string

    type Count_CharsInfo
        code as uinteger
        count as ext.SizeType
    end type

    '' Function: Count_Chars
    ''   *Count_Chars* gets information about the characters used in a string.
    ''
    '' Parameters:
    ''   text - the string to analyze.
    ''   result - a variable-length array that stores the information.
    ''   what - the type of information to return.
    ''
    '' Returns:
    ''   If *what* is *Count_CharsEnum.all_chars*, then *result* will contain
    ''   usage information on all 256 ASCII characters. If *what* is
    ''   *Count_CharsEnum.used_chars* or *Count_CharsEnum.unused_chars*, then
    ''   *result* will contain information on the used or unused characters,
    ''   respectively, in *text*. In any case, the size of *result* is returned.
    declare function Count_Chars ( byref text as const string, result() as Count_CharsInfo, byval what as Count_CharsEnum = used_chars ) as ext.SizeType

    '' Function: Implode
    ''   *Implode* connects the strings in the array *strings*, placing the
    ''   text in *glue* between them.
    ''
    '' Parameters:
    ''   glue - the string to use as glue.
    ''   strings - the array of strings to glue together.
    ''
    '' Returns:
    ''   If *strings* is an empty array, behavior is undefined. Otherwise,
    ''   each string in the array *strings* is placed end-to-end, in order,
    ''   with the text *glue* in between them. This is the string that is
    ''   returned.
    declare function Implode ( byref glue as const string, strings() as const string ) as string

    '' Function: Join
    ''   *Join* is an alias for *Implode*.
    declare function Join alias "IMPLODE" ( byref glue as const string, strings() as const string ) as string

    '' Function: StrRChr
    ''   Returns the substring of *text* that begins at the last
    ''   occurrence of the character specified in *char* and contains the
    ''   remaining characterse of *text*.
    '' Parameters:
    ''   text - the text to extract the substring from.
    ''   char - a string whose first character is searched for.
    ''
    '' Returns:
    ''   If *char* is an empty string, an empty string is returned. Otherwise,
    ''   *StrRChr(text, char[0])* is returned.
    declare function StrRChr overload ( byref text as const string, byref char as const string ) as string

    '' Function: StrRChr
    ''   Returns the substring of *text* that begins at the last
    ''   occurrence of the character *char* and contains the remaining
    ''   characters of *text*.
    '' Parameters:
    ''   text - the text to extract the substring from.
    ''   char - the character code of the character to search for.
    ''
    '' Returns:
    ''   If *char* is an empty string, an empty string is returned. if *char*
    ''   is not found in the string *text*, then an empty string is returned.
    ''   Otherwise, the found substring is returned.
    declare function StrRChr ( byref text as const string, byval char as ubyte ) as string

end namespace

# endif ' include guard
