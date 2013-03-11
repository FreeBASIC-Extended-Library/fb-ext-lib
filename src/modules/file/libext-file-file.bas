''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''
'' All rights reserved.
''
'' Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''  * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
'' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
'' "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
'' LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
'' A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
'' CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
'' EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
'' PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
'' PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
'' LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
'' NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
'' SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# include once "ext/detail/common.bi"
# include once "ext/file/file.bi"


# macro fbext_FilePrint_Define(linkage, T_)
:
' linkage_ ignore, always public.

'' :::::
sub File.print( byref data_ as fbext_TypeName(T_) )

    #ifdef FBEXT_MULTITHREADED
    mutexlock(m_mutex)
    #endif

    if m_fsd <> null then
        #if fbext_TypeName(T_) = string
        generic_print(m_fsd,cast(ubyte ptr,@data_[0]),len(data_))
        #else
        generic_print(m_fsd,cast(ubyte ptr,@data_),sizeof(data_))
        #endif
    else
    if m_filehandle <> null then

        ..print #m_filehandle, data_

    end if
    end if

    #ifdef FBEXT_MULTITHREADED
    mutexunlock(m_mutex)
    #endif

end sub

'' :::::
sub File.print( _data() as fbext_TypeName(T_) , byval amount as integer = 0 )

    #ifdef FBEXT_MULTITHREADED
    mutexlock(m_mutex)
    #endif



        var amm = iif(amount = 0, ubound(_data), amount)

        for n as integer = lbound(_data) to amm

            if m_fsd <> null then
                this.print(_data(n))
            else
                if m_filehandle <> null then
                ..print #m_filehandle, _data(n)
                end if
            end if

        next n


    #ifdef FBEXT_MULTITHREADED
    mutexunlock(m_mutex)
    #endif

end sub
:
# endmacro

# macro fbext_FileGet_Define(linkage_, T_)
:
' linkage_ ignore, always public.

'' :::::
sub File.get( byval filepos as longint = -1, byref data_ as fbext_TypeName(T_), byval amount as integer = 1 )

    #ifdef FBEXT_MULTITHREADED
    mutexlock(m_mutex)
    #endif

    #if fbext_TypeName(T_) = string
        if filepos = -1 then
            if m_fsd <> null then
                m_bytes = m_fsd->fsget(m_fsd,0,cast(ubyte ptr,@data_),amount*len(data_))
            else
                ..get #m_filehandle, , data_
            end if

        else
            if m_fsd <> null then
                m_bytes = m_fsd->fsget(m_fsd,filepos,cast(ubyte ptr,@data_),amount*len(data_))
            else
                ..get #m_filehandle, filepos, data_
            end if

        end if
    #else
        if filepos = -1 then
            if m_fsd <> null then
                m_bytes = m_fsd->fsget(m_fsd,0,cast(ubyte ptr,@data_),amount*sizeof(data_))
            else
                ..get #m_filehandle, , data_, amount
            end if

        else
            if m_fsd <> null then
                m_bytes = m_fsd->fsget(m_fsd,filepos,cast(ubyte ptr,@data_),amount*sizeof(data_))
            else
                ..get #m_filehandle, filepos, data_, amount
            end if

        end if
    #endif

    #ifdef FBEXT_MULTITHREADED
    mutexunlock(m_mutex)
    #endif

end sub
:
# endmacro

# macro fbext_FilePut_Define(linkage_, T_)
:
' linkage_ ignore, always public.

'' :::::
sub File.put( byval filepos as longint = -1, byref data_ as fbext_TypeName(T_), byval amount as integer = 1 )

    #ifdef FBEXT_MULTITHREADED
    mutexlock(m_mutex)
    #endif

    #if fbext_TypeName(T_) = string
        if filepos = -1 then
            if m_fsd <> null then
                m_bytes = m_fsd->fsput(m_fsd,0,cast(ubyte ptr,@data_),amount*len(data_))
            else
                ..put #m_filehandle, , data_
            end if

        else
            if m_fsd <> null then
                m_bytes = m_fsd->fsput(m_fsd,filepos,cast(ubyte ptr,@data_),amount*len(data_))
            else
                ..put #m_filehandle, filepos, data_
            end if

        end if
    #else
        if filepos = -1 then
            if m_fsd <> null then
                m_bytes = m_fsd->fsput(m_fsd,0,cast(ubyte ptr,@data_),amount*sizeof(data_))
            else
                ..put #m_filehandle, , data_, amount
            end if

        else
            if m_fsd <> null then
                m_bytes = m_fsd->fsput(m_fsd,filepos,cast(ubyte ptr,@data_),amount*sizeof(data_))
            else
                ..put #m_filehandle, filepos, data_, amount
            end if

        end if
    #endif

    #ifdef FBEXT_MULTITHREADED
    mutexunlock(m_mutex)
    #endif

end sub
:
# endmacro

namespace ext

    function File.getBytesRW() as ulongint
        return m_bytes
    end function

    private sub generic_print( byval t as FileSystemDriver ptr, byval d as ubyte ptr, byval n as SizeType )

        #ifdef __FB_WIN32__
            var lineending = !"\r\n"
        #else
            var lineending = !"\n"
        #endif

        for i as uinteger = 0 to n-1
            var r = t->fsput(t,0,@d[i],1)
            if r <> 1 then return
        next

        'if t->fsput(t,0,d,n) <> n then return
        for i as integer = 0 to len(lineending)-1
            t->fsput(t,0,cast(ubyte ptr,@lineending[n]),1)
        next

    end sub

    fbext_InstanciateMulti(fbext_FilePrint, fbext_BuiltinTypes())
    fbext_InstanciateMulti(fbext_FilePut, fbext_BuiltinTypes())
    fbext_InstanciateMulti(fbext_FileGet, fbext_BuiltinTypes())

    function File.toBuffer( byref dest as ubyte ptr ) as SizeType

        dim as SizeType flen = lof()

        dest = new ubyte[flen]

        if dest = null then return 0

        get(,*dest, flen)

        return flen

    end function

    '' :::::
    constructor File ( byref filename as const string, byval acc as ACCESS_TYPE = R )

        m_filename = filename
        m_filehandle = 0
        m_access = acc
        m_lasterror = 0

        #ifdef FBEXT_MULTITHREADED

        m_mutex = mutexcreate()

        #endif

    end constructor

    '' :::::
    constructor File ( byval fsd as FileSystemDriver ptr )
        m_fsd = fsd
    end constructor

    '' :::::
    constructor File ( )

        m_filename = ""
        m_filehandle = 0
        m_access = -1
        m_lasterror = 0

        #ifdef FBEXT_MULTITHREADED
        m_mutex = mutexcreate()
        #endif

    end constructor

    '' :::::
    function File.eof( ) as ext.bool

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        var x = false

        if m_fsd <> null then
            x = m_fsd->fseof(m_fsd)
        else
            x = iif(..eof(m_filehandle), ext.true, ext.false)
        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif

        return x

    end function

    '' :::::
    property File.handle() as integer
        return m_filehandle
    end property

    '' :::::
    function File.lof() as longint

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        dim x as longint

        if m_fsd <> null then
            x = m_fsd->fslof(m_fsd)
        else
            x = ..lof(m_filehandle)
        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif

        return x

    end function

    '' :::::
    function File.loc() as longint

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        dim x as longint

        if m_fsd <> null then
            x = m_fsd->fsloc(m_fsd)
        else
            x = ..loc(m_filehandle)
        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif

        return x

    end function

    '' :::::
    property File.seek( byval poz as longint )

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        if m_fsd <> null then
            m_fsd->fsseek(m_fsd,poz)
        else
            ..seek #m_filehandle, poz
        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif

    end property

    '' :::::
    property File.seek( ) as longint

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        dim x as longint

        if m_fsd <> null then
            x = m_fsd->fsloc(m_fsd)
        else
            x = ..seek(m_filehandle)
        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif

        return x

    end property

    '' :::::
    function File.open( byref filename as const string, byval acc as ACCESS_TYPE = R ) as ext.bool

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        m_filename = filename
        m_access = acc

        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif

        return open()

    end function

    '' :::::
    property File.LastError() as integer
        return m_lasterror
    end property

    '' :::::
    function File.open() as ext.bool

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        if m_fsd <> null then
        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif
            return m_fsd->fsopen(m_fsd)
        else

        m_filehandle = freefile

        if m_filename <> "" then

            var ret = 0

            select case m_access
            case 0
            ret = ..open(m_filename, for binary, ACCESS READ, as m_filehandle)

            case 1
            ret = ..open(m_filename, for binary, ACCESS WRITE, as m_filehandle)

            case 2
            ret = ..open(m_filename, for binary, ACCESS READ WRITE, as m_filehandle)

            end select

            if ret <> 0 then
                m_lasterror = ret

                #ifdef FBEXT_MULTITHREADED
                mutexunlock(m_mutex)
                #endif

                return ext.true

            else
                #ifdef FBEXT_MULTITHREADED
                mutexunlock(m_mutex)
                #endif

                return ext.false

            end if

        else

            #ifdef FBEXT_MULTITHREADED
            mutexunlock(m_mutex)
            #endif

            return ext.true

        end if

        end if

    end function

    private function generic_readline ( byval fsd as FileSystemDriver ptr ) as string

        var ret = ""

        dim as ubyte x

        while not fsd->fseof(fsd)

            var res = fsd->fsget(fsd,0,@x,1)
            if res = 0 orelse x = 0 orelse x = 255 then exit while

            if x <> 13 then
                if x <> 10 then
                    ret &= chr(x)
                else
                    exit while
                end if
            else
                res = fsd->fsget(fsd,0,@x,1)
                if res = 0 orelse x = 0 then exit while
                if x <> 10 then
                    var cloc = fsd->fsloc(fsd)
                    fsd->fsseek(fsd,cloc-1)
                    continue while
                end if
                exit while
            end if
        wend

        return ret

    end function

    '' :::::
    function File.readLine() as string

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        var x = ""

        if m_fsd <> 0 then
            x = generic_readline(m_fsd)
        else
            line input #m_filehandle, x
        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif

        return x

    end function

    '' :::::
    sub File.close()

        #ifdef FBEXT_MULTITHREADED
        mutexlock(m_mutex)
        #endif

        if m_fsd <> 0 then
            m_fsd->fsclose(m_fsd)
        else
            if m_filehandle <> 0 then ..close #m_filehandle
        end if

        #ifdef FBEXT_MULTITHREADED
        mutexunlock(m_mutex)
        #endif

    end sub

    '' :::::
    destructor File ( )

        this.close

        #ifdef FBEXT_MULTITHREADED
        mutexdestroy(m_mutex)
        #endif

        if m_fsd <> 0 then delete m_fsd

    end destructor

end namespace ' ext

