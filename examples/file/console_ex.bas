''File: console_ex.bas
''Description: Demonstration of ext.console functions.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/file/console.bi"

var x = "Hello World!"

for n as integer = 0 to len(x) - 1

	ext.console.Write( x[n] )

next

ext.console.Write(!"\n")

ext.console.WriteLine("From the FreeBASIC Extended Library!")
