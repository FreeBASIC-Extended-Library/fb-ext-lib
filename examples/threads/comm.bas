'An example of using the bi-directional communication channel
'to communicate with mutliple threads

#include once "ext/threads/comm.bi"
using ext.threads

sub thread_a( byval _cc as any ptr )
    var cc = cast(CommChannel ptr,_cc)

    while 1
        var m = cc->recv()
        if m <> 0 then
            ? "[THREAD_A] Recieved message: " & m->command
            cc->status(new Message(m->command))
            if m->command = 0 then
                delete m
                exit while
            end if
            delete m
        end if
        sleep 10,1
    wend

    ? "[THREAD_A] QUIT"

end sub

sub thread_b( byval _cc as any ptr )
    var cc = cast(CommChannel ptr,_cc)

    while 1
        var m = cc->recv()
        if m <> 0 then
            ? "[THREAD_B] Recieved message: " & m->command
            cc->status(new Message(m->command * 2))
            if m->command = 0 then
                delete m
                exit while
            end if
            delete m
        end if
        sleep 10,1
    wend

    ? "[THREAD_B] QUIT"

end sub

scope 'main

    var cc = new CommChannel()
    var tid = threadcreate( @thread_a, cc )
    var tid2 = threadcreate( @thread_b, cc )

    sleep 100

    for n as integer = 10 to 0 step -1
        cc->send(new Message(n))
    next
    cc->send(new Message(0))

    sleep 100

    var r = cc->response()

    do
        if r <> 0 then
            print "[MAIN] Recieved from threads: " & r->command
            if r->command = 0 then
                delete r
                exit do
            end if
            delete r
        end if
        r = cc->response()
    loop


    threadwait tid
    threadwait tid2

    delete cc

end scope
