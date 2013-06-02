#include once "ext/net/socket.bi"
using ext
'This is just an example, in real code you should use the getRemoteFileTo* functions
'in ext/net/http.bi
var sckt = net.socket
If sckt.client("http://ext.freebasic.net", 80) <> net.SOCKET_OK Then
        Print "Unable to connect to http://ext.freebasic.net, sunspots?"
        End 42
End If

sckt.putHTTPRequest("http://ext.freebasic.net/dev-docs/index.html","GET")

var rheader = " "
var con_len = 0

print "Response (Header):"
while rheader <> ""
rheader = trim(sckt.getLine())
if left(rheader,15) = "Content-Length:" then
    con_len = valint(right(rheader,len(rheader)-15))
end if
print rheader

wend

print "Content --------"
if con_len <> 0 then
    var content = space(con_len)
    sckt.get(*cast(ubyte ptr,@content[0]),con_len,net.BLOCK)
    print content
else
    print "**NO CONTENT**"
end if
sckt.close

