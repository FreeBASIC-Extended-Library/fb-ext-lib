#include once "ext/net/http.bi"
using ext

var retlen = 0u
var st = net.HTTP_STATUS.NONE
var sck = net.TCPsocket
sck.client("ext.freebasic.net",80)

var buf = net.getRemoteFileToMemory(sck,"http://ext.freebasic.net/dev-docs/index.html",retlen,st)

sck.close

? "Status: " & st
if buf <> null then
    ? *(cast(zstring ptr,buf))
    delete[] buf
end if

