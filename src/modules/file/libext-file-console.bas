''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
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

    '' :::::
    constructor Console ( byval io as ConsoleIO = con_stdout )
    
    	# ifdef FBEXT_MULTITHREADED
    		m_mutex = mutexcreate()
    	# endif
    
    	m_filehandle = freefile
    	m_mode = io
    
    	select case m_mode
    	case con_stdout
    		m_lasterror = Open cons ( For OUTPUT, as m_filehandle )
    
    	case con_stdin
    		m_lasterror = Open cons ( For INPUT, as m_filehandle )
    
    	case else
    		m_lasterror = -1
    	end select
    
    end constructor
    
    '' :::::
    destructor Console ( )
    
    	# ifdef FBEXT_MULTITHREADED
    	mutexdestroy( m_mutex )
    	# endif
    
    	print #m_filehandle, ""
    	close #m_filehandle
    
    end destructor
    
    '' :::::
    function Console.ReadLine( ) as string
    
    	# ifdef FBEXT_MULTITHREADED
    	mutexlock( m_mutex )
    	# endif
    
    	if m_mode <> con_stdin then 
    		m_lasterror = -1
    	# ifdef FBEXT_MULTITHREADED
    	mutexunlock( m_mutex )
    	# endif
    		return ""
    
    	end if
    
    	var x = ""
    
    	line input #m_filehandle, x
    
    	# ifdef FBEXT_MULTITHREADED
    	mutexunlock( m_mutex )
    	# endif
    
    	return x
    
    end function
    
    '' :::::
    property Console.LastError( ) as integer
    
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
        sub Console.WriteLine ( byref x as fbext_TypeName(T_) )
        
        	# ifdef FBEXT_MULTITHREADED
        
        	# endif
        
        	if m_mode <> con_stdout then 
        		m_lasterror = -1
        
        	else
        		print #m_filehandle, x & !"\n";
        
        	end if
        
        	# ifdef FBEXT_MULTITHREADED
        
        	# endif
        
        end sub
        
        '' :::::
        sub Console.Write ( byref x as fbext_TypeName(T_) )
        
        	# ifdef FBEXT_MULTITHREADED
        
        	# endif
        
        	if m_mode <> con_stdout then
        		m_lasterror = -1
        
        	else
        		print #m_filehandle, x;
        
        	end if
        
        	# ifdef FBEXT_MULTITHREADED
        
        	# endif
        
        end sub
    :
    # endmacro
    
    fbext_InstanciateMulti(fbext_ConsoleWrite, fbext_NumericTypes() (((string))) )

end namespace ' ext

