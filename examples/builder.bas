''Copyright (c) 2007-2014-2012, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

'Short program to build all examples.
'Stores filenames in memory as xml data and outputs 
'to builder.xml at program end.

' Compile with fbc's '-g' command-line switch to see debugging information

#include once "ext/misc.bi"
#include once "ext/xml.bi"
#include once "ext/strings.bi"
#include once "ext/debug.bi"
#include once "ext/xstring.bi"

using ext
using misc
using strings

dim as xml.tree xtree


FBEXT_DPRINT("Starting to build all examples in " & curdir())

chdir exepath()

xtree.root->appendChild("builder")
xtree.root->child("builder")->attribute("base_href") = curdir

var dir_count = -1


for n as FILE_ITER = FILE_ITER(curdir() & "/*",&h10) to ""
	dim temp as string
	temp = n.filename()
	FBEXT_DPRINT(temp)

	if ((temp <> "..") AND (temp <> ".") AND (temp <> ".svn")) then

		xtree.root->child("builder")->appendChild("directory")
		xtree.root->child("builder")->child("directory",dir_count+1)->attribute("name") = temp
		dir_count += 1

	end if
next


for n as integer = 0 to dir_count

	dim as string this_dir
	this_dir = xtree.root->child("builder")->child("directory",n)->attribute("name")

	chdir xtree.root->child("builder")->attribute("base_href") & "/" & this_dir

	var file_count = -1

	for m as FILE_ITER = "*.bas" to ""

	dim temp as string
	temp = m.filename()

	if ((temp <> "..") AND (temp <> ".") AND (temp <> ".svn")) then
		
		xtree.root->child("builder")->child("directory", n)->appendChild("file")
		xtree.root->child("builder")->child("directory", n)->child("file", file_count+1)->attribute("name") = temp
		file_count += 1
		print this_dir &"fbc " & xtree.root->child("builder")->child("directory", n)->child("file", file_count)->attribute("name")
		shell "fbc " & command() & xtree.root->child("builder")->child("directory", n)->child("file", file_count)->attribute("name")

	end if

	next

	FBEXT_DPRINT("file_count = " & file_count)



	FBEXT_DPRINT(curdir())
	chdir xtree.root->child("builder")->attribute("base_href")
	FBEXT_DPRINT(curdir())

next

var x = xstring(cast(string, xtree))

x.replace(">", ">" & chr(strings.CHAR_LF))

dim xout() as string
x.explode(chr(strings.CHAR_LF), xout() )

open "builder.xml" for binary ACCESS WRITE as #1

for n as integer = lbound(xout) to ubound(xout)

	print #1, xout(n)

next

close
