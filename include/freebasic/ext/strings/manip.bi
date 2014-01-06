''Title: strings/manip.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_STRINGS_MANIP_BI__
# define FBEXT_STRINGS_MANIP_BI__ -1

# include once "ext/strings/detail/common.bi"

'' Namespace: ext.strings
namespace ext.strings

    '' Function: InsertInto
    ''  Inserts a string into another string.
    ''
    '' Parameters:
    ''  ins - the string you wish to have inserted.
    ''  into - the string it will be inserted into.
    ''  at - the string index (0 based) for the string to be inserted.
    ''
    '' Returns:
    ''  A newly constructed string with ins inserted in into at position at.
    ''
    '' Example:
    ''  insert( " love ", "Iyou.", 1 ) = "I love you."
    ''
    declare function InsertInto( byref ins as const string, byref into as const string, byval at as uinteger ) as string

    '' Function: Repeat
    ''  Returns a string of length *n* consisting of as many characters with
    ''  the ascii code *ascii_code*.
    ''
    '' Parameters:
    ''  ascii_code - the ascii code of the character to repeat
    ''  n - the number of times to repeat ascii_code
    ''
    '' Returns:
    ''  string containing the repeated ascii_code
    declare function Repeat overload (byval ascii_code as integer, byval n as integer) as string

    '' Function: Repeat
    ''  Returns a string of length *n * len(subject)* consisting of consecutive
    ''  copies of *subject*.
    ''
    '' Parameters:
    ''  subject - the string to repeat.
    ''  n - the number of times to repeat subject
    ''
    '' Returns:
    ''  The string containing the repeated subject
    declare function Repeat (byref subject as const string, byval n as integer) as string

namespace detail

    ' The default buffer size used in ext.strings.Replace.
    const s_DEFAULT_REPBUFSIZE = 1024

end namespace

    '' Sub: Replace
    ''  Replaces all unique occurences of *oldtext* found within *subject*,
    ''  from beginning to end, and replaces them with *newtext*.
    ''
    '' Parameters:
    ''  subject - the text to search and replace in.
    ''  oldtext - text to search for in the string.
    ''  newtext - text to replace oldtext with
    ''
    ''  If the length of either *subject* or *oldtext* is zero (0),
    ''  *ext.strings.Replace* does nothing.
    declare sub Replace overload (byref subject as string, byref oldtext as const string, byref newtext as const string)

    '' Sub: Replace
    ''  Replaces all unique occurrences of each of the strings in *oldtext*, in
    ''  order, that are found within *subject*, with *newtext*.
    ''
    '' Parameters:
    ''  subject - the text to search and replace in.
    ''  oldtext() - the array of strings to search for.
    ''  newtext - the string to replace oldtext() with.
    ''
    ''  For every string *i* in [lbound(*oldtext*), ubound(*oldtext*)],
    ''  (begin code)
    ''      ext.strings.Replace(subject, oldtext(i), newtext)
    ''  (end code)
    ''  is called.
    declare sub Replace (byref subject as string, oldtext() as const string, byref newtext as const string)

    '' Sub: Replace
    ''  Replaces all unique occurrences of each of the strings in *oldtext*, in
    ''  order, that are found within *subject*, with corresponding strings in
    ''  *newtext*, or the empty string ("") if there are no corresponding
    ''  strings.
    ''
    '' Parameters:
    ''  subject - the string to search and replace in.
    ''  oldtext() - the array of strings to search for.
    ''  newtext() - the array of strings to replace with.
    ''
    ''  For every string *i* in [lbound(*oldtext*), lbound(*oldtext*) + n-1],
    ''  where *n* is the minimum size between *oldtext* and *newtext*,
    ''  (begin code)
    ''      ext.strings.Replace(subject, oldtext(i), newtext(i))
    ''  (end code)
    ''  is called. If *oldtext* contains more strings to find as there are
    ''  replcements in *newtext*, then for every string *i* in
    ''  [*n-1*, *ubound(oldtext)*],
    ''  (begin code)
    ''      ext.strings.Replace(subject, oldtext(i), "")
    ''  (end code)
    ''  is called.
    declare sub Replace (byref subject as string, oldtext() as const string, newtext() as const string)

    '' Sub: Replace
    ''  Replaces all unique occurrences of *oldtext*, that are found within each
    ''  of the strings in *subject*, with *newtext*.
    ''
    '' Parameters:
    ''  subject() - string array to search and replace in.
    ''  oldtext - text to search for.
    ''  newtext - text to replace with.
    ''
    ''  For every string *i* in [lbound(*subject*), ubound(*subject*)],
    ''  (begin code)
    ''      ext.strings.Replace(subject(i), oldtext, newtext)
    ''  (end code)
    ''  is called.
    declare sub Replace (subject() as string, byref oldtext as const string, byref newtext as const string)

    '' Sub: Replace
    ''  Replaces all unique occurrences of each of the strings in *oldtext*, in
    ''  order, that are found within each of the strings in *subject*, with
    ''  *newtext*.
    ''
    '' Parameters:
    ''  subject() - string array to search and replace in.
    ''  oldtext() - array of strings to search for.
    ''  newtext - string to replace with.
    ''
    ''  For every string *i* in [lbound(*subject*), ubound(*subject*)],
    ''  (begin code)
    ''      ext.strings.Replace(subject(i), oldtext(), newtext)
    ''  (end code)
    ''  is called.
    declare sub Replace (subject() as string, oldtext() as const string, byref newtext as const string)

    '' Sub: Replace
    ''  Replaces all unique occurrences of each of the strings in *oldtext*, in
    ''  order, that are found within each of the strings in *subject*, with
    ''  corresponding strings from *newtext*, or the empty string ("") if there
    ''  are no corresponding strings.
    ''
    '' Parameters:
    ''  subject() - string array to search and replace in.
    ''  oldtext() - array of strings to search for.
    ''  newtext() - array of strings to replace with.
    ''
    ''  For every string *i* in [lbound(*subject*), ubound(*subject*)],
    ''  (begin code)
    ''      ext.strings.Replace(subject(i), oldtext(), newtext())
    ''  (end code)
    ''  is called.
    declare sub Replace (subject() as string, oldtext() as const string, newtext() as const string)


    '' Function: ReplaceCopy
    ''  Returns a copy of *subject* with all unique occurrences of *oldtext*
    ''  replaced with *newtext*.
    ''
    '' Parameters:
    ''  subject - the text to search in
    ''  oldtext - text to search for in the string.
    ''  newtext - text to replace oldtext with
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      var tmp = subject
    ''      ext.strings.Replace(tmp, oldtext, newtext)
    ''      return tmp
    ''  (end code)
    declare function ReplaceCopy overload (byref subject as const string, byref oldtext as const string, byref newtext as const string) as string

    '' Function: ReplaceCopy
    ''  Returns a copy of *subject* with all unique occurrences of each of the
    ''  strings in *oldtext*, in order, with *newtext*.
    ''
    '' Parameters:
    ''  subject - the text to search.
    ''  oldtext() - the array of strings to search for.
    ''  newtext - the string to replace with.
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      var tmp = subject
    ''      ext.strings.Replace(tmp, oldtext(), newtext)
    ''      return tmp
    ''  (end code)
    declare function ReplaceCopy (byref subject as const string, oldtext() as const string, byref newtext as const string) as string

    '' Function: ReplaceCopy
    ''  Returns a copy of *subject* with all unique occurrences of each of the
    ''  strings in *oldtext* replaced by corresponding strings in *newtext*.
    ''
    '' Parameters:
    ''  subject - the string to search.
    ''  oldtext() - the array of strings to search for.
    ''  newtext() - the array of strings to replace with.
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      var tmp = subject
    ''      ext.strings.Replace(tmp, oldtext(), newtext())
    ''      return tmp
    ''  (end code)
    declare function ReplaceCopy (byref subject as const string, oldtext() as const string, newtext() as const string) as string

    '' Sub: ReplaceCopy
    ''  Assigns the strings in *result* the value of the corresponding strings
    ''  in *subject* with each unique occurrence of *oldtext*, found from
    ''  beginning to end, with *newtext*. *result* is resized occordingly.
    ''
    '' Parameters:
    ''  subject() - array of string to search.
    ''  oldtext - text to search for.
    ''  newtext - string to replace with.
    ''  result() - variable-length string array to store results.
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      redim result(lbound(subject), ubound(subject)) as string
    ''      for i as integer = lbound(subject) to ubound(subject)
    ''          result(i) = ext.strings.Replace(subject(i), oldtext, newtext)
    ''      next i
    ''  (end code)
    declare sub ReplaceCopy (subject() as const string, byref oldtext as const string, byref newtext as const string, result() as string)

    '' Sub: ReplaceCopy
    ''  Assigns the strings in *result*, starting with string at *index*, the
    ''  value of the corresponding strings in *subject* with each unique
    ''  occurrence of *oldtext*, found from beginning to end, with *newtext*.
    ''  *result* is assumed to be large enough.
    ''
    '' Parameters:
    ''  subject() - array of string to search.
    ''  oldtext - text to search for.
    ''  newtext - string to replace with.
    ''  result() - variable-length string array to store results.
    ''  index - starting index of result array.
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      redim result(lbound(subject), ubound(subject)) as string
    ''      for i as integer = lbound(subject) to ubound(subject)
    ''          result(i) = ext.strings.Replace(subject(i), oldtext, newtext)
    ''      next i
    ''  (end code)
    declare sub ReplaceCopy (subject() as const string, byref oldtext as const string, byref newtext as const string, result() as string, byval index as integer)

    '' Sub: ReplaceCopy
    ''
    '' Parameters:
    ''  subject() - array of string to search.
    ''  oldtext() - array of strings to search for.
    ''  newtext - string to replace with.
    ''  result() - string array to copy modifications to.
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      redim result(lbound(subject), ubound(subject)) as string
    ''      for i as integer = lbound(subject) to ubound(subject)
    ''          result(i) = ext.strings.Replace(subject(i), oldtext(), newtext)
    ''      next i
    ''  (end code)
    declare sub ReplaceCopy (subject() as const string, oldtext() as const string, byref newtext as const string, result() as string)

    '' Sub: ReplaceCopy
    ''
    '' Parameters:
    ''  subject() - array of string to search.
    ''  oldtext() - array of strings to search for.
    ''  newtext() - array of strings to replace with.
    ''  result() - string array to copy modifications to.
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      redim result(lbound(subject), ubound(subject)) as string
    ''      for i as integer = lbound(subject) to ubound(subject)
    ''          result(i) = ext.strings.Replace(subject(i), oldtext(), newtext())
    ''      next i
    ''  (end code)
    declare sub ReplaceCopy (subject() as const string, oldtext() as const string, newtext() as const string, result() as string)


    '' Sub: Reverse
    ''  Reverses the order of the characters in *subject*.
    ''
    '' Parameters:
    ''  subject - the string to reverse.
    declare sub Reverse overload (byref subject as string)

    '' Sub: Reverse
    ''  Reverses the order of the characters in each of the strings in
    ''  *subject*.
    ''
    '' Parameters:
    ''  subject() - array of strings to reverse.
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      for i as integer = lbound(subject) to ubound(subject)
    ''          ext.strings.Reverse(subject)
    ''      next i
    ''  (end code)
    declare sub Reverse (subject() as string)


    '' Function: ReverseCopy
    ''  Returns a copy of *subject* with the order of the characters
    ''  reversed.
    ''
    '' Parameters:
    ''  subject - the string to reverse.
    ''
    ''  Behaves like,
    ''  (begin code)
    ''      var tmp = subject
    ''      ext.strings.Reverse(subject)
    ''      return tmp
    ''  (end code)
    declare function ReverseCopy overload (byref subject as const string) as string


    '' Sub: ReverseCopy
    ''  Assigns the strings in *result* the values of the corresponding strings
    ''  in *subject* with the order of the characters in each string reversed.
    ''  *result* is resized so that its upper and lower bounds are the same as
    ''  *subject*
    ''
    '' Parameters:
    ''  subject() - array of strings to reverse.
    ''  result() - array of strings to return results in.
    ''
    ''  For every *n* in [lbound(*subject*), ubound(*subject*)],
    ''  (begin code)
    ''      result(n) = ext.strings.Reverse(subject(n))
    ''  (end code)
    ''  is called.
    declare sub ReverseCopy (subject() as const string, result() as string)

    '' Sub: ReverseCopy
    ''  Assigns the strings in *result*, starting with the string at *index*,
    ''  the values of the corresponding strings in *subject*, starting with the
    ''  first string, with the order of the characters in each string reversed.
    ''  *result* is assumed to be large enough to hold
    ''  *ubound(subject)-lbound(subject)+1* number of strings.
    ''
    '' Parameters:
    ''  subject() - array of strings to reverse.
    ''  result() - array of strings to return results in.
    ''  index - starting index of result array.
    ''
    ''  For every *n* in [lbound(*subject*), ubound(*subject*)] and *m* in
    ''  [*index*, *index* + (ubound(*subject*)-lbound(*subject*) + 1)],
    ''  (begin code)
    ''      result(m) = ext.strings.Reverse(subject(n))
    ''  (end code)
    declare sub ReverseCopy (subject() as const string, result() as string, byval index as integer)

    '' Sub: Rot13
    '' The ROT13 encoding simply shifts every letter by 13 places in the alphabet while leaving
    '' non-alpha characters untouched. Encoding and decoding are done by the same function,
    '' passing an encoded string as argument will return the original version.
    ''
    '' Parameters:
    '' subject - string to encode or decode.
    ''
    declare sub Rot13 (byref subject as string)

    '' Sub: Rot13Copy
    '' The ROT13 encoding simply shifts every letter by 13 places in the alphabet while leaving
    '' non-alpha characters untouched. Encoding and decoding are done by the same function,
    '' passing an encoded string as argument will return the original version.
    ''
    '' Parameters:
    '' subject - string to encode or decode.
    ''
    '' Returns:
    '' the modified string.
    declare function Rot13Copy (byref subject as const string) as string

    '' Sub: shuffle
    '' Randomly shuffles the characters in the string.
    ''
    '' Parameters:
    '' subject - the string to shuffle.
    ''
    declare sub Shuffle overload (byref subject as string)


    '' Sub: Shuffle
    '' Randomly shuffles the characters in each of an array of strings.
    ''
    '' Parameters:
    '' subject() - array of strings to shuffle
    ''
    declare sub Shuffle (subject() as string)


    '' Function: ShuffleCopy
    '' Randomly shuffles the characters in the string.
    ''
    '' Parameters:
    '' subject - the string to shuffle.
    ''
    '' Returns:
    '' the modified string.
    ''
    declare function ShuffleCopy overload (byref subject as const string) as string


    '' Sub: ShuffleCopy
    '' Randomly shuffles the characters in each of an array of strings.
    ''
    '' Parameters:
    '' subject() - array of strings to shuffle
    '' result() - array to place results in
    ''
    declare sub ShuffleCopy (subject() as const string, result() as string)


    '' Sub: UCWords
    '' Capitalizes every word in a string.
    ''
    '' Parameters:
    '' subject - the string to capitalize.
    ''
    declare sub UCWords (byref subject as string)

    '' Function: UCWordsCopy
    '' Capitalizes every word in a string.
    ''
    '' Parameters:
    '' subject - the string to capitalize.
    ''
    '' Returns:
    '' the modifed string.
    ''
    declare function UCWordsCopy (byref subject as const string) as string

end namespace

# endif ' include guard
