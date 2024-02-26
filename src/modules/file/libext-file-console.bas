''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
'' All rights reserved.
''
'' Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
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
# include once "ext/file/console.bi"

namespace ext

    dim shared __Console as Console_ ptr

    private sub make_console () constructor
        __Console = new Console_()
    end sub

    private sub destroy_console() destructor
        if __Console <> 0 then delete __Console
    end sub

    namespace console
        function ReadLine() as string
            return __Console->ReadLine()
        end function

        # macro fbext_realConsoleWrite_Define(linkage_, T_)
        :
        sub Write( byref x as fbext_TypeName(T_) )
            __Console->Write(x)
        end sub

        sub WriteLine( byref x as fbext_TypeName(T_) )
            __Console->WriteLine(x)
        end sub
        :
        # endmacro

        fbext_InstanciateMulti(fbext_realConsoleWrite, fbext_NumericTypes() (((string))) )
        
    end namespace

    '' :::::
    constructor Console_ ( )
    
        # ifdef FBEXT_MULTITHREADED
            m_mutex = mutexcreate()
        # endif
        
    end constructor
    
    '' :::::
    destructor Console_ ( )
    
        # ifdef FBEXT_MULTITHREADED
        mutexdestroy( m_mutex )
        # endif
    
        if m_filehandlei <> 0 then close #m_filehandlei
        if m_filehandleo <> 0 then close #m_filehandleo
    
    end destructor

    sub Console_.m_oi()
        m_filehandlei = freefile
        m_lasterror = open cons(for input, as #m_filehandlei)
    end sub

    sub Console_.m_oo()
        m_filehandleo = freefile
        m_lasterror = open cons(for output, as #m_filehandleo)
    end sub
    
    '' :::::
    function Console_.ReadLine( ) as string
    
        # ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        # endif

        if m_filehandlei = 0 then m_oi
        
        var x = ""
    
        line input #m_filehandlei, x
    
        # ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        # endif
    
        return x
    
    end function
    
    '' :::::
    property Console_.LastError( ) as integer
    
        # ifdef FBEXT_MULTITHREADED
        mutexlock( m_mutex )
        # endif
    
        var x = m_lasterror
    
        # ifdef FBEXT_MULTITHREADED
        mutexunlock( m_mutex )
        # endif
    
        return x
    
    end property
    
    # macro fbext_ConsoleWrite_Define(linkage_, T_)
    :
        ' linkage_ is ignored, always public.
        
        '' :::::
        sub Console_.WriteLine ( byref x as fbext_TypeName(T_) )
        
            # ifdef FBEXT_MULTITHREADED
            mutexlock( m_mutex )
            # endif

            if m_filehandleo = 0 then m_oo
            
            print #m_filehandleo, x & !"\n";
        
            # ifdef FBEXT_MULTITHREADED
            mutexunlock( m_mutex )
            # endif
        
        end sub
        
        '' :::::
        sub Console_.Write ( byref x as fbext_TypeName(T_) )
        
            # ifdef FBEXT_MULTITHREADED
            mutexlock( m_mutex )
            # endif

            if m_filehandleo = 0 then m_oo

            print #m_filehandleo, x;
        
            # ifdef FBEXT_MULTITHREADED
            mutexunlock( m_mutex )
            # endif
        
        end sub
    :
    # endmacro
    
    fbext_InstanciateMulti(fbext_ConsoleWrite, fbext_NumericTypes() (((string))) )

end namespace ' ext

