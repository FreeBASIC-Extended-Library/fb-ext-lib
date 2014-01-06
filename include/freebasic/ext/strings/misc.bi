''Title: strings/misc.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_STRINGS_MISC_BI__
# define FBEXT_STRINGS_MISC_BI__ -1

# include once "ext/strings/detail/common.bi"

'' Namespace: ext.strings
namespace ext.strings

    '' Function: LevenshteinDistance
    '' Computes the Levenshtein Distance between two strings.
    ''
    '' Parameters:
    '' subject - the string to compute the distance on.
    '' t - the string to find the distance to.
    ''
    '' Returns:
    '' The levenshtein distance of the strings.
    ''
    '' See Also:
    '' http://en.wikipedia.org/wiki/Levenshtein_distance
    ''
    declare function LevenshteinDistance( byref subject as const string, byref t as const string ) as integer

    '' Function: Pos
    ''
    '' Parameters:
    '' haystack - the string to search in.
    '' needle - the string to find.
    '' offset - the character offset to start searching.
    ''
    '' Returns:
    '' Character position of needle.
    ''
    declare function Pos (byref haystack as const string, byref needle as const string, byval offset as integer) as integer

end namespace

# endif ' include guard
