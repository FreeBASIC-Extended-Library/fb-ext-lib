''Title: strings/split.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_STRINGS_SPLIT_BI__
# define FBEXT_STRINGS_SPLIT_BI__ -1

# include once "ext/strings/detail/common.bi"

'' Namespace: ext.strings
namespace ext.strings

    '' Function: Explode
    '' Splits a string into an array.
    ''
    '' Parameters:
    '' subject - the string to split up.
    '' delimit - The delimiter to use when splitting the array, only first character is used.
    '' res() - string array that results will be passed into.
    ''
    '' Returns:
    '' Integer number of delimited strings found.
    ''
    declare function Explode( byref subject as const string, byref delimit as const string, res() as string ) as integer

    '' Function: Join
    '' Joins together a string array.
    ''
    '' Parameters:
    '' subject() - array of strings to join together.
    '' (-*glue*) - optional "glue" to use between strings, defaults to a single space
    ''
    '' Returns:
    '' The assembled string.
    ''
    declare function Join (subject() as const string, byref glue as const string = " ") as string

    '' Function: Split
    '' Splits a string into an array.
    ''
    '' Parameters:
    '' subject - the string to split up.
    '' result() - string array that results will be passed into.
    '' delimiter - The delimiter to use when splitting the array.
    '' limit - the maximum number of substrings to split to.
    ''
    '' Returns:
    '' Integer number of delimited strings found.
    ''
    declare function Split overload (byref subject as const string, result() as string, byref delimiter as const string, byval limit as integer) as integer
end namespace

# endif ' include guard
