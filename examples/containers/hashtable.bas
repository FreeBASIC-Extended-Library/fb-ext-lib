''File: hashtable.bas
''Description: Demonstration of ext.HashTable object.
''
''Copyright (c) 2007-2024 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING)

# include once "ext/containers/hashtable.bi"

fbext_Instanciate(fbext_HashTable, ((single)))

using ext

var myHT = fbext_HashTable((single))(16)

print "Count before insertion: " & myHT.count

print !"Inserting \"One\" as 1.0"
myHT.insert("One", 1.0)

print !"Inserting \"Two\" as 2.0"
myHT.insert("Two", 2.0)

print !"Inserting \"Three\" as 3.0"
myHT.insert("Three", 3.0)

print !"Inserting \"Tacos\" as 4.2"
myHT.insert("Tacos", 4.2)

print !"Inserting \"FBEXT\" as 5.6"
myHT.insert("FBEXT", 5.6)

print "Count after insertion: " & myHT.count

print "One: " & *(myHT.find("One"))

print "Removing Tacos"
myHT.remove("Tacos")

print "Two: " & *(myHT.find("Two"))

print "Removing Three"
myHT.remove("Three")

print "FBEXT: " & *(myHT.find("FBEXT"))

print "Count after 2 removes: " & myHT.count
