''File: xstring.bas
''Description: Demonstration of ext.strings.xstring object.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/xstring.bi"
using ext.strings

dim as xstring myxstring = "Hello, World!"
var s2 = myxstring

print myxstring

myxstring.reverse()

print myxstring

print myxstring <> "Hai, World!"
print myxstring = "Hai, World!"

myxstring.reverse()

print myxstring + " Tacos Rule!"
myxstring.replace(" Tacos Rule!", "")

print myxstring

print myxstring & " From FreeBASIC"

print instr(myxstring, ",") 'You may use xstring with any procedure that takes a string

scope
	var sx = xstring("the freeBASIC extended library development team")
	sx.ucwords()
	print sx
end scope

scope
	var s1 = xstring("apple")
	s1 &= "peaches"
	s1 &= "grapes" & s1
	print s1

end scope

'xstring also supports the operators - and *
var mystr = xstring("testing, testing, testing")
mystr -= ","
print mystr

mystr *= 2
print mystr

print -mystr
