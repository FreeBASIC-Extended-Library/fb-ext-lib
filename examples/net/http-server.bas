#include once "ext/net/http.bi"
#include once "ext/file/file.bi"

declare sub processRequest( byref s as ext.net.TCPsocket )

using ext.net

var mainsckt = TCPsocket()
var listenersckt = new TCPsocket()
mainsckt.server(8080)

? "Now serving the current directory on at localhost:8080"
? "This server should not be used in production as it does not"
? "protect from bad behaviour AT ALL!"
? "Press ESC to stop serving."

while inkey <> chr(27) 'loop until escape

    if listenersckt->listenToNew(mainsckt,1) then
        processRequest(*listenersckt)
        sleep 10,1
        delete listenersckt
        listenersckt = new TCPsocket()
    end if
    sleep 10,1
wend

if listenersckt <> null then delete listenersckt
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

    var rhdrs = new ext.fbext_HashTable((string))()
    rhdrs->Insert("Connection","close") 'common to all responses

    if path = "/" then path = "/index.html" 'autocorrect
    if path = "/index.html" then path = "/index.html"
    if path = "/index.php" then path = "/index.html"

    var f = ext.File(exepath & path)
    if f.open() = ext.false then
        dim fp as ubyte ptr
        var flen = f.toBuffer(fp)
        f.close()
        rhdrs->Insert("Server","EXT::TESTHTTPSERVER")
        rhdrs->Insert("Content-Length",str(flen))
        rhdrs->Insert("Content-Type","text/html")

        sendHTTPheaders(s,,,,OK,*rhdrs)
        s.put(*fp,flen)

    else
        'Error 404, page not found
        rhdrs->Insert("Waffles","Are Good 2.0")
        var page404 = "<html><head><title>Oops!</title></head><body><h1>Error 404</h1><p>The page you requested could not be found.</p></body></html>"
        rhdrs->Insert("Content-Length",str(len(page404)))
        rhdrs->Insert("Content-Type","text/html")
        rhdrs->Insert("Server","EXT::TESTHTTPSERVER")
        sendHTTPheaders(s,,,,NOT_FOUND,*rhdrs)
        s.putString(page404)
    end if


    delete rhdrs
    delete hdrs
    s.close()

end sub
