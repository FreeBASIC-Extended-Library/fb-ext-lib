'' Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
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

	if m_filehandle <> null then

		..print #m_filehandle, data_

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

	if m_filehandle <> null then

		var amm = iif(amount = 0, ubound(_data), amount)

		for n as integer = lbound(_data) to amm

			..print #m_filehandle, _data(n)

		next n

	end if

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
			..get #m_filehandle, , data_

		else
			..get #m_filehandle, filepos, data_

		end if
	#else
		if filepos = -1 then
			..get #m_filehandle, , data_, amount

		else
			..get #m_filehandle, filepos, data_, amount

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
			..put #m_filehandle, , data_

		else
			..put #m_filehandle, filepos, data_

		end if
	#else
		if filepos = -1 then
			..put #m_filehandle, , data_, amount

		else
			..put #m_filehandle, filepos, data_, amount

		end if
	#endif

	#ifdef FBEXT_MULTITHREADED
	mutexunlock(m_mutex)
	#endif

end sub
:
# endmacro

namespace ext

	fbext_InstanciateMulti(fbext_FilePrint, fbext_BuiltinTypes())
	fbext_InstanciateMulti(fbext_FilePut, fbext_BuiltinTypes())
	fbext_InstanciateMulti(fbext_FileGet, fbext_BuiltinTypes())

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

		var x = iif(..eof(m_filehandle), ext.true, ext.false)

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

		var x = ..lof(m_filehandle)

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

		var x = ..loc(m_filehandle)

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

		..seek #m_filehandle, poz

		#ifdef FBEXT_MULTITHREADED
		mutexunlock(m_mutex)
		#endif

	end property

	'' :::::
	property File.seek( ) as longint

		#ifdef FBEXT_MULTITHREADED
		mutexlock(m_mutex)
		#endif

		var x = ..seek(m_filehandle)

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

	end function

	'' :::::
	function File.linput() as string

		#ifdef FBEXT_MULTITHREADED
		mutexlock(m_mutex)
		#endif

		var x = ""
		line input #m_filehandle, x

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

		if m_filehandle <> 0 then ..close #m_filehandle

		#ifdef FBEXT_MULTITHREADED
		mutexunlock(m_mutex)
		#endif

	end sub

	'' :::::
	destructor File ( )

		#ifdef FBEXT_MULTITHREADED
		mutexdestroy(m_mutex)
		#endif

		if m_filehandle <> 0 then ..close #m_filehandle

	end destructor

end namespace ' ext

