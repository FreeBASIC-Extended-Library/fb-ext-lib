'Simple example of getting the md5sum of some file or files from the commandline.
'Output is compatible with the md5sum command.
#include once "ext/hash.bi"
#include once "ext/file/file.bi"
using ext

for n as integer = 1 to ( __FB_ARGC__ - 1 )

	print hashes.md5.checksum( File(command(n)) ) & " *" & command(n)
	
next
