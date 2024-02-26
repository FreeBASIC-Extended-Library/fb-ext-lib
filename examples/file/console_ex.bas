''File: console_ex.bas
''Description: Demonstration of ext.console functions.
''
''Copyright (c) 2007-2024 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING)

# include once "ext/file/console.bi"

var x = "Hello World!"

for n as integer = 0 to len(x) - 1

	ext.console.Write( x[n] )

next

ext.console.Write(!"\n")

ext.console.WriteLine("From the FreeBASIC Extended Library!")
