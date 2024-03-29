''Title: threads/mutex.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

#ifndef __FBEXT_THREADS_MUTEX
#define __FBEXT_THREADS_MUTEX 1

#include once "ext/threads/detail/common.bi"

''Namespace: ext.threads
namespace ext.threads

''Class: Mutex
type Mutex
    public:
    ''Sub: lock
    declare sub lock()

    ''Sub: unlock
    declare sub unlock()
    declare constructor()
    declare constructor( byref rhs as Mutex )
    declare operator let( byref rhs as Mutex )
    declare destructor()

    private:
    _m as any ptr
end type

end namespace

#endif
