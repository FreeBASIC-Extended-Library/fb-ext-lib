''File: replace.bas
''Description: Demonstration of ext.strings.replace and replace_copy functions.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include "ext/strings.bi"

using ext.strings

dim strings(3) as string = _
{ _
	"John likes to fly kites.", _
	"'Flying kites is fun,' said John.", _
	"December 25th is John's birthday.", _
	"On his birthday, John received a brand new kite." _
}

dim oldtexts(1) as const string = { "John", "kite" }
dim newtexts(1) as const string = { "Luke", "airplane" }

ext.strings.replace(strings(), oldtexts(), newtexts())

' Luke likes to fly airplanes.
' 'Flying airplanes is fun,' said Luke.
' December 25th is Luke's birthday.
' On his birthday, Luke received a brand new airplane.
'
for i as integer = lbound(strings) to ubound(strings)
	print strings(i)
next

' Thequickbrownfox
'
print ReplaceCopy("The quick brown fox", " ", "")
