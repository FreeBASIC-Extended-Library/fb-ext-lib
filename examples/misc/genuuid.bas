'This program is a simple example of using the UUID class
#include once "ext/misc.bi"

using ext

var cmd = lcase(command())
if cmd = "-h" orelse cmd = "--help" then
    ? "genuuid - Generates a random UUID."
    ? "Powered by: " & FBEXT_VERSION_STRING
    end 1
end if

randomize timer

var r = new misc.UUID()
r->randomize()
? *r
delete r
