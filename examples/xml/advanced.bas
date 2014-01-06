''File: advanced.bas
''Description: More Advanced usage of the ext.xml object.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/xml.bi"
# include once "ext/xstring.bi"
# include once "ext/misc.bi"
# include once "datetime.bi"

#define DIR_VER 1.0

dim shared as uinteger fcount

'This subroutine does all the grunt work.
declare sub RecurseInto( byref dirx as string, byval nde as ext.xml.node ptr )

'Main

var base_href = curdir()

dim as ext.xml.tree xtree

xtree.root->appendChild( "dirtree" )->attribute("version") = str(DIR_VER)
xtree.root->child("dirtree")->appendChild("meta")->attribute("last_run") = str(now)

print "Finding files..."
fcount = 0

RecurseInto( base_href, xtree.root->child("dirtree")->appendChild("files") )

'Now we're going to clean up the xml to be more Editor friendly so we can read it.
var x = ext.strings.xstring(cast(string, xtree))

'We're replaceing > with > and a newline
x.replace(">", ">" & !"\n")

'Then we split the xml data string into an array where each element holds one line.
dim xout() as string
x.explode(!"\n", xout() )

chdir base_href

open "dirtree.xml" for binary ACCESS WRITE as #1

'Now we just iterate through the array printing each line.
for n as integer = lbound(xout) to ubound(xout)

	print #1, xout(n)

next

close

? "Files found: " & fcount



sub RecurseInto( byref dirx as string, byval nde as ext.xml.node ptr )

	chdir dirx

	'This loop looks for files.
	for n as ext.misc.FILE_ITER = ext.misc.FILE_ITER(curdir() & "/*",&h21) to ""
		dim temp as string
		temp = n.filename()

		if ((temp <> "..") AND (temp <> ".") AND (temp <> ".svn")) then

			nde->appendChild("file")->attribute("name") = temp
			fcount += 1
		end if
	next

	'This loop looks for directories.
	for n as ext.misc.FILE_ITER = ext.misc.FILE_ITER(curdir() & "/*",&h10) to ""
		dim temp as string
		temp = n.filename()

		if ((temp <> "..") AND (temp <> ".") AND (temp <> ".svn")) then

			nde->appendChild("directory")->attribute("name") = temp

		end if

	next

	'Finally we loop through the directories we just found, calling this function with the new directory path
	'and the node pointer referring to that directory.
	for n as integer = 0 to nde->children("directory") -1
		RecurseInto( nde->child("directory",n)->attribute("name"), nde->child("directory",n) )
	next

	'Now lets backup one dir so if we are a child function the next recursion will be
	'in the proper directory.
	chdir ".."
end sub
