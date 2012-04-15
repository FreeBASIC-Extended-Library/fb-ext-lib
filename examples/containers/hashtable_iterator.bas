# include once "ext/containers/hashtable.bi"

declare sub MyIterator ( byref key as const string, byval value as integer ptr )

var MyHT = ext.FBEXT_HASHTABLE((integer))(150)

for n as integer = 1 to 50
	MyHT.Insert("Number: " & n, n)
next

MyHT.ForEach( @MyIterator )

sub MyIterator ( byref key as const string, byval value as integer ptr )

	print !"\"" & key & !"\" => " & *value

end sub
