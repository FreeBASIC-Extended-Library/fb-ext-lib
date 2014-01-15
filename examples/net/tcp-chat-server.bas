#include once "ext/net/tcp.bi"
#include once "ext/threads/comm.bi"
#include once "fbgfx.bi" 'for keycodes

using ext

enum PROTOCMD
    REMOVE_CLIENT = -2
    ADD_CLIENT = -1
    QUIT_MSG = 0
    JOIN_MSG = 1
    SEND_MSG = 2
end enum

type chat_client
    as string nick
    as net.TCPsocket socket
    as threads.CommChannel cc
    as any ptr tid
    declare destructor
end type

destructor chat_client
    socket.close()
    threadwait(tid)
end destructor

sub push_cc(byref x as chat_client ptr, arr() as chat_client ptr)
    if @arr(lbound(arr)) <> 0 then
        redim preserve arr(ubound(arr)+1)
    else
        redim arr(0)
    end if
    arr(ubound(arr)) = x
end sub

sub remove_i_from_array_cc( byval index as uinteger, arr() as chat_client ptr )
    var ip1 = index + 1
    if ip1 > ubound(arr) then
        redim preserve arr(ubound(arr)-1)
        return
    end if
    dim temp_arr(0 to ubound(arr)-ip1) as chat_client ptr
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

sub remove_i_from_array_tc( byval index as uinteger, arr() as threads.CommChannel ptr )
    var ip1 = index + 1
    if ip1 > ubound(arr) then
        redim preserve arr(ubound(arr)-1)
        return
    end if
    dim temp_arr(0 to ubound(arr)-ip1) as threads.CommChannel ptr
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

sub push_tc(byref x as threads.CommChannel ptr, arr() as threads.CommChannel ptr)
    if @arr(lbound(arr)) <> 0 then
        redim preserve arr(ubound(arr)+1)
    else
        redim arr(0)
    end if
    arr(ubound(arr)) = x
end sub

sub free_zstring( byval d as any ptr )
    delete[] cast(ubyte ptr,d)
end sub

function copyMsg( byval m as threads.Message ptr ) as threads.Message ptr

    var c = m->command()
    dim newd as ubyte ptr
    dim d as zstring ptr
    if c > 0 then
        d = cast(zstring ptr,m->msgdata())
        newd = new ubyte[len(*d)+1]
        memcpy(newd,d,len(*d)+1)
    end if

    if c > 0 then
        return new threads.Message(c,new threads.MData(newd,@free_zstring))
    else
        return new threads.Message(c)
    end if

end function

sub sendToAll( byval m as threads.Message ptr, cl() as threads.CommChannel ptr )

    for n as uinteger = lbound(cl) to ubound(cl)
            cl(n)->status( copyMsg(m) )
    next

end sub

sub message_router( byval c as any ptr )

    var cc = cast(ext.threads.CommChannel ptr,c)
    dim clients() as threads.CommChannel ptr
    while 1
    var curcmd = cc->recv()
    if curcmd <> null then 'all clients get their command from here
        if curcmd->command() < QUIT_MSG then
            'we handle adding and remove
            if curcmd->command() = ADD_CLIENT then 'add
                push_tc(curcmd->msgdata(),clients())
            end if
        else
            sendToAll(curcmd,clients())
            if curcmd->command() = QUIT_MSG then
                delete curcmd
                exit while
            end if
        end if
        delete curcmd
    end if

    var remove_this = -1

    if @clients(lbound(clients)) <> 0 then
    for n as uinteger = lbound(clients) to ubound(clients)
        if clients(n) = null then continue for
        var x = clients(n)->recv()
        if x <> null then 'all clients send their commands here
            if x->command() = QUIT_MSG then
                remove_this = n
            end if
            cc->send( copyMsg(x) )
            delete x
        end if
    next
    end if
    if remove_this <> -1 then
        remove_i_from_array_tc(remove_this,clients())
        remove_this = -1
    end if
    sleep 1
    wend

end sub

sub client_thread( byval c as any ptr )
    var cm = cast(chat_client ptr,c)

    while 1
        'Read socket
        dim cmd as integer
        if cm->socket.isClosed then
            cmd = &hDEAD
        else
            cm->socket.get(cmd,1,1)
        end if


        select case cmd
        case &hBEEF 'recieved a message
            var temp_msg = cm->socket.getLine()
            var x = new ubyte[len(temp_msg)+1]
            memcpy(x,@(temp_msg[0]),len(temp_msg)+1)
            cm->cc.send(new threads.Message(SEND_MSG,new threads.MData(x,@free_zstring)))
        case &hDEAD 'client is shutting down
            cm->cc.send(new threads.Message(REMOVE_CLIENT))
            exit while
        case &hD00D 'client joined
            cm->nick = cm->socket.getLine()
            var x = new ubyte[len(cm->nick)+1]
            memcpy(x,@(cm->nick[0]),len(cm->nick)+1)
            cm->cc.send(new threads.Message(JOIN_MSG,new threads.MData(x,@free_zstring)))
        end select

        'get response
        var msg = cm->cc.response()

        if msg <> null then

            select case msg->command()
            case SEND_MSG
                cm->socket.put(&hBEEF)
                cm->socket.putLine(*cast(zstring ptr,msg->msgdata()))
            case JOIN_MSG
                cm->socket.put(&hD00D)
                cm->socket.putLine(*cast(zstring ptr,msg->msgdata()) & " joined.")
            case QUIT_MSG
                cm->socket.put(&hDEAD)
            end select
            delete msg
        end if

    wend

end sub

sub main

    var cc = new threads.CommChannel()
    dim mr_t as any ptr 'pities the fool
    dim clients() as chat_client ptr
    var sckt = new net.TCPsocket
    var sckt_e = sckt->server(5678)

    var head = 0
    push_cc(new chat_client,clients())
    ? "Push ESC to exit the server"
    while not multikey(fb.SC_ESCAPE)

    if sckt_e = net.SOCKET_OK then
        var gotit = clients(head)->socket.listenToNew(*sckt,0.001)
        if gotit then 'we got a connection!
            clients(head)->tid = threadcreate(@client_thread,@(clients(head)->cc))
            if head = 0 then
                 mr_t = threadcreate(@message_router,cc)
            end if
            cc->send(new threads.Message(ADD_CLIENT,new threads.mData(@(clients(head)->cc),0)))
            push_cc(new chat_client,clients())
            head += 1
        end if
    end if

    wend

    'cleanup
    cc->send(new threads.Message(QUIT_MSG))
    threadwait(mr_t)
    for n as uinteger = lbound(clients) to ubound(clients)
        delete clients(n) 'destructor calls threadwait
    next

    delete cc
end sub

main
