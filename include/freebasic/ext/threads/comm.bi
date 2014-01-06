''Title: ext/threads/comm.bi
''
'' About: Code License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef __FBEXT_THREADS_COMM_BI
#define __FBEXT_THREADS_COMM_BI -1

#include once "ext/detail/common.bi"
#include once "ext/threads/detail/common.bi"
#include once "ext/threads/mutex.bi"

#ifndef FBEXT_MULTITHREADED
#print [FBEXT-THREADS] You must use the -mt option to fbc to compile using this module
#endif

namespace ext.threads

''Class: MData
''Simple class for managing data
type MData
    ''Variable: d
    ''Application specific pointer
    d as any ptr
    ''Variable: f
    ''Function to be called to free the memory for <d>
    f as sub( byval as any ptr )
    ''Sub: constructor
    ''
    ''Parameters:
    ''dt - pointer to set to d
    ''frefun - the free function to use
    declare constructor( byval dt as any ptr, byval frefun as sub( byval as any ptr ) )
end type


type ComChannel_f as CommChannel

''Class: Message
type Message

    ''Sub: constructor
    ''Used for creating Messages
    ''
    ''Parameters:
    ''cm - the "command" to pass, this is application dependant
    ''xtra - optional pointer to newly allocated <MData> object (will be managed by Message object)
    ''cc - optional pointer to a <CommChannel> to use for communicating
    declare constructor( byval cm as integer, byval xtra as Mdata ptr = 0, byval cc as ComChannel_f ptr =0)
    declare destructor()

    ''Function: command
    ''Get the application dependant command.
    ''
    ''Returns:
    ''Integer command value
    ''
    declare function command() as integer

    ''Function: msgdata
    ''Gets the data associated with this command (if any)
    ''
    ''Returns:
    ''<Null> if no data, otherwise application dependant data pointer.
    ''
    ''Notes:
    ''*Important*: this data pointer is managed by the <Message> object
    ''and should not be free'd or deleted.
    ''
    declare function msgdata() as any ptr

    private:
    c as integer
    x as MData ptr
    m as ComChannel_f ptr
end type

type Messages
    d as Message ptr
    n as Messages ptr
    declare constructor( byval rhs as Message ptr )
    declare destructor()
end type

''Class: CommChannel
''Used for asynchronus bi-directional communication across threads
type CommChannel
    public:
        declare constructor()
        declare destructor()
        ''Sub: send
        ''Send a message from thread A to thread B
        ''
        ''Parameters:
        ''m - <Message> ptr to send, do not free
        declare sub send( byval m as Message ptr )

        ''Function: recv
        ''Check for any messages from thread A and return the oldest one.
        ''
        ''Returns:
        ''NULL if no <Messages> awaiting, or a <Message> ptr
        ''that you must free when done with it using delete.
        declare function recv( ) as Message ptr

        ''Sub: status
        ''Send a message from thread B to thread A
        ''
        ''Parameters:
        ''m - <Message> ptr to send, do not free
        declare sub status( byval m as Message ptr )

        ''Function: response
        ''Check for any messages from thread B and return the oldest one.
        ''
        ''Returns:
        ''Null if no <Message>s awaiting, or a <Message> ptr
        ''that you must free when done with it using delete.
        declare function response( ) as Message ptr

        ''Function: peekA
        ''Check for any messages from thread B and return a read-only copy
        ''without removing if from the queue. Useful to check if you
        ''want to handle the message or let another consumer of messages
        ''handle it.
        ''
        ''Returns:
        ''Null if no <Message>s awaiting or a <Message> ptr
        ''*DO NOT DELETE THIS POINTER*
        declare function peekA() as Message ptr

        ''Function: peekB
        ''Check for any messages from thread A and return a read-only copy
        ''without removing if from the queue. Useful to check if you
        ''want to handle the message or let another consumer of messages
        ''handle it.
        ''
        ''Returns:
        ''Null if no <Message>s awaiting or a <Message> ptr
        ''*DO NOT DELETE THIS POINTER*
        declare function peekB() as Message ptr

    private:
        _mess as Messages ptr
        _mutex as Mutex ptr
        _omess as Messages ptr
        _omutex as Mutex ptr
end type

end namespace

#endif
