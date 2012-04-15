'Simple example of getting the md5sum of some text from the commandline.
'Equivalent to the command: echo -n 'Your text here' | md5sum
#include once "ext/hash.bi"
using ext

print hashes.md5.checksum( command() ) & " *-"
