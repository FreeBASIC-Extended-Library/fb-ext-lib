'Simple example of getting the sha256sum of some text from the commandline.
#include once "ext/hash.bi"
using ext

print hashes.sha2.checksum( command() ) & " *-"
