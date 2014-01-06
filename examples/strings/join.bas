''File: join.bas
''Description: Demonstration of ext.strings.join function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include "ext/strings.bi"

using ext.strings

dim strings(3) as string = { "a", "b", "c", "d" }

' a b c d
'
print join(strings())

' abcd
'
print join(strings(), "")

' a
' b
' c
' d
'
print join(strings(), !"\r\n")
