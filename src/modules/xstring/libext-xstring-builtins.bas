''Copyright (c) 2007-2011, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# include once "ext/xstring.bi"

namespace ext.strings

	'' :::::
	sub xstring.Trim()
		this.m_str = ..Trim(this.m_str)
	end sub

	'' :::::
	sub xstring.LTrim()
		this.m_str = ..LTrim(this.m_str)
	end sub

	'' :::::
	sub xstring.RTrim()
		this.m_str = ..RTrim(this.m_str)
	end sub

	'' :::::
	function xstring.Instr( byval start as integer = 1, byref search as const string ) as integer
		return ..instr( start, this.m_str, search )
	end function

	'' :::::
	sub xstring.UCase ()
		this.m_str = ..UCase(this.m_str)
	end sub

	'' :::::
	sub xstring.LCase ()
		this.m_str = ..LCase(this.m_str)
	end sub

	'' :::::
	function xstring.Left ( byval length as integer ) as string
		return ..left( this.m_str, length )
	end function

	'' :::::
	function xstring.Right ( byval length as integer ) as string
		return ..right( this.m_str, length )
	end function

	sub xstring.Mid( byref text as const string, byval start as integer, byval length as integer )
		..mid(this.m_str, start, length) = text
	end sub

	function xstring.Mid( byval start as integer, byval length as integer ) as string
		if (length = 0) then
			return ..mid( this.m_str, start )

		else
			return ..mid( this.m_str, start, length )

		end if
	end function

end namespace 'ext.strings
