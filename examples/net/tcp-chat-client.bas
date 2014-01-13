#include once "ext/net/tcp.bi"
#include once "ext/input.bi"
using ext

dim shared msgs() as string

sub remove_i_from_array( byval index as uinteger, arr() as string )
    var ip1 = index + 1
    if ip1 > ubound(arr) then
        redim preserve arr(ubound(arr)-1)
        return
    end if
    dim temp_arr(0 to ubound(arr)-ip1) as string
    var i = 0
    for n as integer = ip1 to ubound(arr)
        temp_arr(i) = arr(n)
        i += 1
    next
    redim preserve arr(ubound(arr)-1)
    i = 0
    for n as integer = index to ubound(arr)
        arr(n) = temp_arr(i)
        i += 1
    next
end sub

sub push(byref x as string, arr() as string)
    if @arr(lbound(arr)) <> 0 then
        redim preserve arr(ubound(arr)+1)
    else
        redim arr(0)
    end if
    arr(ubound(arr)) = x
end sub

dim shared sckt as net.TCPsocket ptr
dim shared connected as bool

function updateScreen( byval ch as uinteger, byval data_ as any ptr ) as bool

    if ubound(msgs) > (hiword(width())-3) then remove_i_from_array(0,msgs())
    cls
    if connected then
        ? "Enter /quit to exit"
    else
        ? "Enter address to connect to."
    end if
    ? ">"
    for n as uinteger = lbound(msgs) to ubound(msgs)
        locate n+3,1
        ? left(msgs(n),loword(width()))
    next

    var cmd = 0
    if sckt->get(cmd,1,0.001) <> 0 then

        select case cmd
        case &hBEEF,&hD00D 'regular message or join msg
            push(sckt->getLine(),msgs())
        case &hDEAD 'server quit
            connected = invalid
        end select

    end if

    return TRUE

end function

sckt = new net.TCPsocket
var x = xInput()
with x
    .maxLength = loword(width())-2
    .callback = @updateScreen
end with

var nick = ""
if command() <> "" then
    nick = command()
else
    nick = "Anonymous"
end if

var input_str = ""
while input_str <> "/quit"
    input_str = ""
    input_str = trim(x.get(2,2))
    if connected = false then
        var i = sckt->client(input_str,5678)
        if i <> net.SOCKET_OK then
            push("Could not connect to " & input_str,msgs())
        else
            sckt->put(&hD00D)
            sckt->putLine(nick)
            push("Connected to " & input_str,msgs())
            connected = true
        end if
        continue while
    end if

    if connected = invalid then
        push("Disconnected from server.",msgs())
        connected = false
        continue while
    end if

    if input_str <> "" andalso connected then

        sckt->put(&hBEEF)
        sckt->putLine(input_str)

    end if
wend

sckt->close()
