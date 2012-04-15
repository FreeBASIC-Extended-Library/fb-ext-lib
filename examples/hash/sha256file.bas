'Simple example of getting the sha256sum of some file or files from the commandline.
#include once "ext/hash.bi"
#include once "ext/file/file.bi"
using ext

for n as integer = 1 to ( __FB_ARGC__ - 1 )

	print hashes.sha2.checksum( File(command(n)) ) & " *" & command(n)
	
next
