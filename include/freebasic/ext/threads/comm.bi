''Title: ext/threads/comm.bi
''
'' About: Code License
''  Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef __FBEXT_THREADS_COMM_BI
#define __FBEXT_THREADS_COMM_BI -1

#include once "ext/detail/common.bi"

#inclib "ext-threads"

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
        ''Null if no <Messages> awaiting, or a <Message> ptr
        ''that you must free when done with it using delete.
        declare function response( ) as Message ptr

    private:
        _mess as Messages ptr
        _mutex as any ptr
        _omess as Messages ptr
        _omutex as any ptr
end type

end namespace

#endif
