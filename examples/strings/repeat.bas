''File: repeat.bas
''Description: Demonstration of ext.strings.repeat function.
''
''Copyright (c) 2007-2024 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING)

# include "ext/strings.bi"

using ext.strings

' AAAAA
'
print repeat(65, 5)

' abcabcabc
'
print repeat("abc", 3)
