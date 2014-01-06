''Title: strings/substr.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_STRINGS_SUBSTR_BI__
# define FBEXT_STRINGS_SUBSTR_BI__ -1

# include once "ext/strings/detail/common.bi"

'' Namespace: ext.strings
namespace ext.strings

	'' Function: tokenize
	'' Splits a string into tokens, similiar to C's strtok.
	''
	'' Parameters:
	'' x - zstring ptr to string to tokenize, should only be passed at first call.
	'' tkns - const string containing the tokens to match on.
	'' lastfound - ubyte ptr, will return the character code of the last found token (0 for EOL)
	''
	'' Returns:
	'' String portion delimited by the first found token (skipping multiple at the beginning if necessary.
	''
	'' Example:
	''(begin code)
	''#include once "ext/strings/substr.bi"
	''
	''var x = "This is a string, and this is the same one."
	''dim as ubyte what = 0
	''
	''var t = ext.strings.tokenize(x, " ,.", @what)
	''
	''while t <> ""
	''	print using !"&  \"&\""; t; chr(what)
	''	t = ext.strings.tokenize(, " ,.", @what)
	''wend
	''(end code)
	''
	declare function tokenize( byval x as zstring ptr = 0, byref tkns as const string, byval lastfound as ubyte ptr = 0, byval eattkns as bool = true ) as string

	'' Function: SubStr
	'' Returns a portion of a string.
	''
	'' Parameters:
	'' subject - the string to return a portion of.
	'' offset - zero-based offset of substring. if negative, specifies
	'' (*-offset*) chars from the end of the string
	''
	'' Returns:
	'' The portion of the string following the offset passed.
	''
	declare function SubStr overload (byref subject as const string, byval offset as integer = 0) as string

	'' Function: SubStr
	'' Returns a portion of a string.
	''
	'' Parameters:
	'' subject - the string to return a portion of.
	'' offset - zero-based offset of substring. if negative, specifies
	'' (*-offset*) chars from the end of the string
	'' length - the number of characters from *offset* to include. if
	'' negative, specifies all but the remaining (-length) characters.
	''
	'' Returns:
	'' The requested sub string.
	''
	declare function SubStr (byref subject as const string, byval offset as integer, byval length as integer) as string

	'' Function: SubStrCompare
	'' Compares a substring with another.
	''
	'' Parameters:
	'' a - A string.
	'' b - A string.
	'' offset - zero-based offset of substring. if negative, specifies
	'' (*-offset*) chars from the end of the string
	''
	'' Returns:
	'' Returns a negative, zero or positive value if *a* is less than, equal to
	'' or greater than *b*, respectively.
	''
	declare function SubStrCompare overload (byref a as const string, byref b as const string, byval offset as integer = 0) as integer

	'' Function: SubStrCompare
	'' Compares a substring with another.
	''
	'' Parameters:
	'' a - A string.
	'' b - A string.
	'' offset - zero-based offset of substring. if negative, specifies
	'' (*-offset*) chars from the end of the string
	'' length - the number of characters from *offset* to include. if
	'' negative, specifies all but the remaining (-length) characters.
	''
	'' Returns:
	'' Returns a negative, zero or positive value if *a* is less than, equal to
	'' or greater than *b*, respectively.
	''
	declare function SubStrCompare (byref a as const string, byref b as const string, byval offset as integer, byval length as integer) as integer

	'' Function: SubStrCount
	'' Finds the number of substrings within a string.
	''
	'' Parameters:
	'' haystack - The string to search.
	'' needle - The substring to search for.
	'' offset - The zero-based offset into the haystack to start the search.
	'' If negative, specifies *-offset* chars from the end of the haystack.
	''
	'' Returns:
	'' The number of times the needle was found in the haystack.
	''
	declare function SubStrCount overload (byref haystack as const string, byref needle as const string, byval offset as integer = 0) as integer

	'' Function: SubStrCount
	'' Finds the number of substrings within a portion of a string.
	''
	'' Parameters:
	'' haystack - The string to search.
	'' needle - The substring to search for.
	'' offset - The zero-based offset into the haystack to start the search.
	'' If negative, specifies *-offset* chars from the end of the haystack.
	'' length - The size of the portion of haystack to search. If
	'' negative, specifies all but the remaining *-length* characters.
	''
	'' Returns:
	'' The number of times the needle was found in the haystack.
	''
	declare function SubStrCount (byref haystack as const string, byref needle as const string, byval offset as integer, byval length as integer) as integer

	'' Function: SubStrReplace
	'' Replaces a substring with another.
	''
	'' Parameters:
	'' subject - The string containing the substring to replace.
	'' replacement - The new substring.
	'' offset - The zero-based offset of the substring. If negative, specifies
	'' *-offset* chars from the end of the subject string
	''
	declare sub SubStrReplace overload (byref subject as string, byref replacement as const string, byval offset as integer = 0)

	'' Function: SubStrReplace
	'' Replaces a substring with another.
	''
	'' Parameters:
	'' subject - The string containing the substring to replace.
	'' replacement - The new substring.
	'' offset - The zero-based offset of the substring. If negative, specifies
	'' *-offset* chars from the end of the subject string
	'' length - The number of characters from *offset* to replace. If
	'' negative, specifies all but the remaining *-length* characters.
	''
	declare sub SubStrReplace (byref subject as string, byref replacement as const string, byval offset as integer, byval length as integer)

end namespace

# endif ' include guard
