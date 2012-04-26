#include once "ext/net/http.bi"
#include once "ext/file/file.bi"

declare sub processRequest( byref s as ext.net.TCPsocket )

using ext.net

var mainsckt = TCPsocket()
var listenersckt = TCPsocket()
mainsckt.server(8080) 'we just specify the port we want to serve on

? "Now serving the current directory on at localhost:8080"
? "This server should not be used in production as it does not"
? "protect from bad behaviour AT ALL!"
? "Press ESC to stop serving."

while inkey <> chr(27) 'loop until escape

    if listenersckt.listenToNew(mainsckt,1) then 'wait for 1 second for a new request
        processRequest(listenersckt)
        'listenersckt is closed by processRequest at the end, but if there was
        'an error it could still be open
        listenersckt.close()
    end if
    sleep 10,1
wend

listenersckt.close()
mainsckt.close()

sub processRequest( byref s as TCPsocket )

    var hdrs = readHTTPheaders(s)

    var rtype = *(hdrs->Find("First-Line"))
    var first_space = instr(rtype," ")
    var met = trim(left(rtype,first_space)) 'get the requested method, this server only supports GET

    var sec_space = instr(first_space+1,rtype," ")
    var path = trim(mid(rtype,first_space+1,sec_space-first_space)) 'the actual requested path
    var ua = *(hdrs->Find("User-Agent")) 'The user-agent connecting to the server.

    if trim(ua) = "" orelse trim(path) = "" then    'per http rfc user-agent should not be blank,
        delete hdrs                                 'and gotta know where to direct the request.
        return
    end if

    var rhdrs = new ext.fbext_HashTable((string))()
    rhdrs->Insert("Connection","close") 'common to all responses

    if path = "/" then path = "/index.html" 'autocorrect, this would also work for sub directories
    if path = "/index.html" then path = "/index.html" 'in a more complete server
    if path = "/index.php" then path = "/index.html"

    var f = ext.File(exepath & path)
    if f.open() = ext.false then 'try to open the requested file, false means no error opening
        dim fp as ubyte ptr
        var flen = f.toBuffer(fp) 'load the file into memory for serving
        f.close()
        rhdrs->Insert("Content-Length",str(flen)) 'gotta say how much data we have to send
        rhdrs->Insert("Content-Type","text/html") 'this would typically come from a MIME database of some sort

        sendHTTPheaders(s,,,,OK,*rhdrs) 'send our headers
        s.put(*fp,flen) 'and send the file.

    else
        'Error 404, page not found
        'we can still send some page data though.
        rhdrs->Insert("Waffles","Are Good") 'http says we can add additional headers no problem
        var page404 = "<html><head><title>Oops!</title></head><body><h1>Error 404</h1><p>The page you requested could not be found.</p></body></html>"
        rhdrs->Insert("Content-Length",str(len(page404)))
        rhdrs->Insert("Content-Type","text/html")
        sendHTTPheaders(s,,,,NOT_FOUND,*rhdrs)
        s.putString(page404)
    end if


    delete rhdrs 'and we clean up and close the socket.
    delete hdrs
    s.close()

end sub
