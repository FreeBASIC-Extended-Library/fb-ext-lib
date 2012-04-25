#include once "ext/net/http.bi"
#include once "ext/file/file.bi"

declare sub processRequest( byref s as ext.net.TCPsocket )

using ext.net

var mainsckt = TCPsocket()
var listenersckt = TCPsocket()

mainsckt.server(8080)

while inkey <> chr(27) 'loop until escape

    if listenersckt.listenToNew(mainsckt,5) then
        processRequest(listenersckt)
    end if

wend

listenersckt.close()
mainsckt.close()

sub printHeaders( byref k as const string, byval v as string ptr )
    ? k & ": " & *v
end sub

sub processRequest( byref s as TCPsocket )

    var hdrs = readHTTPheaders(s)

    var rtype = *(hdrs->Find("First-Line"))
    var first_space = instr(rtype," ")
    var met = trim(left(rtype,first_space))

    var sec_space = instr(first_space+1,rtype," ")
    var path = trim(mid(rtype,first_space+1,sec_space-first_space))
    var ua = *(hdrs->Find("User-Agent"))

    if trim(ua) = "" orelse trim(path) = "" then
        delete hdrs
        return
    end if

    print "Connection from " & ua & " Requesting: " & path

    var rhdrs = new ext.fbext_HashTable((string))()
        if path = "/" then path = "/index.html"
        ? path
        var f = ext.File(exepath & path)
        if f.open() = ext.false then
        dim fp as ubyte ptr
        var flen = f.toBuffer(fp)
        f.close()
        rhdrs->Insert("Content-Length",str(flen))
        rhdrs->Insert("Content-Type","text/html")

        ? "Response:"
        rhdrs->ForEach(@printHeaders)

        sendHTTPheaders(s,,,,OK,*rhdrs)
        s.put(*fp,flen)

    else
        rhdrs->Insert("Waffles","Are Good 2.0")
        sendHTTPheaders(s,,,,NOT_FOUND,*rhdrs)
    end if

    delete rhdrs
    delete hdrs
    s.close()

end sub
