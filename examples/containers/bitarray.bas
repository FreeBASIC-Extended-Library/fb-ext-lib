''File: bitarray.bas
''Description: Demonstration of ext.BitArray object.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/containers/bitarray.bi"
# include once "ext/strings.bi"

var bitstring = ext.strings.repeat("10", 64)
ext.strings.shuffle(bitstring)

var bitarray = ext.BitArray(len(bitstring))
bitarray.load(bitstring)
print "bits: " & bitarray.dump()

if bitarray.isset(0) then print "bit 0 is set"

bitarray.toggle(30)
bitarray.toggle(31)
bitarray.toggle(32)
print "bits: " & bitarray.dump()
