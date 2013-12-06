#include once "ext/net/http.bi"
using ext

var retlen = 0u
var st = net.HTTP_STATUS.NONE

var buf = net.getRemoteFileToMemory("http://ext.freebasic.net/dev-docs/index.html",retlen,st)

? "Status: " & st
if buf <> null then
    ? *(cast(zstring ptr,buf))
    delete[] buf
end if

