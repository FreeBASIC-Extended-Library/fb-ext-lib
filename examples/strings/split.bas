''File: split.bas
''Description: Demonstration of ext.strings.split function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include "ext/strings.bi"

sub test (byref delimiter as string, byref s as string, byval limit as integer = 0)

	using ext.strings

	var text = "delimiter=""" & delimiter & """, string=""" & s & """, limit=" & limit & !"\n"
	
	dim result() as string
	var res = split(s, result(), delimiter, limit)
	
	if res then
		var substr_count = ubound(result) + 1
		text &= " " & substr_count & " { "
		for substr as integer = 0 to substr_count - 1
			if substr <> 0 then text &= ", "
			text &= """" & result(substr) & """"
		next
		text &= " }"
	
	else
		text &= " empty delimiter"
	
	end if
	
	print text

end sub

' delimiter=":", string="a:b:c:d", limit=0
'  4 { "a", "b", "c", "d" }
' delimiter=":", string=":a:b:c:d", limit=0
'  5 { "", "a", "b", "c", "d" }
' delimiter=":", string="a:b:c:d:", limit=0
'  5 { "a", "b", "c", "d", "" }
' delimiter=":", string="a:b::c:d", limit=0
'  5 { "a", "b", "", "c", "d" }
' delimiter=":", string="a:b:c:d", limit=1
'  1 { "a:b:c:d" }
' delimiter=":", string="a:b:c:d", limit=3
'  3 { "a", "b", "c:d" }
' delimiter=":", string="a:b:c:d", limit=-1
'  3 { "a", "b", "c" }
' delimiter=":", string="a:b:c:d", limit=-3
'  1 { "a" }
' delimiter="", string="a:b:c:d", limit=0
'  empty delimiter
' delimiter=":", string="", limit=0
'  1 { "" }
' delimiter="x", string="a:b:c:d", limit=0
'  1 { "a:b:c:d" }

Test(":", "a:b:c:d")
Test(":", ":a:b:c:d")
Test(":", "a:b:c:d:")
Test(":", "a:b::c:d")

Test(":", "a:b:c:d", 1)
Test(":", "a:b:c:d", 3)

Test(":", "a:b:c:d", -1)
Test(":", "a:b:c:d", -3)

Test("", "a:b:c:d")
Test(":", "")
Test("x", "a:b:c:d")
