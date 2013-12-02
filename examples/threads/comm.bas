'An example of using the bi-directional communication channel
'to communicate with mutliple threads

#include once "ext/threads/comm.bi"
using ext.threads

sub thread_a( byval _cc as any ptr )
    var cc = cast(CommChannel ptr,_cc)

    while 1
        var m = cc->recv()
        while m = 0
            m = cc->recv()
        wend

        ? "[THREAD_A] Recieved message: " & m->c
        cc->status(new Message(m->c))
        if m->c = 0 then
            delete m
            exit while
        end if
        delete m
        sleep 10,1
    wend

end sub

sub thread_b( byval _cc as any ptr )
    var cc = cast(CommChannel ptr,_cc)

    while 1
        var m = cc->recv()
        while m = 0
            m = cc->recv()
        wend

        ? "[THREAD_B] Recieved message: " & m->c
        cc->status(new Message(m->c * 2))
        if m->c = 0 then
            delete m
            exit while
        end if
        delete m
        sleep 10,1
    wend

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
            print "[MAIN] Recieved from threads: " & r->c
            if r->c = 0 then
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
