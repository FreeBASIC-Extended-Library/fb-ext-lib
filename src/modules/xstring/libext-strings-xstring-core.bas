''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
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

# include once "ext/detail/common.bi"
# include once "ext/xstring.bi"
# include once "ext/strings.bi"

namespace ext.strings

	type _FBSTRING
		data_ as zstring ptr
		as integer len, size
	end type

	function t ( byref rhs as string ) as xstring
		return XString( rhs )
	end function
	
	'' :::::
	constructor xstring ( byref xStr as const string )
		m_str = xStr
	end constructor

	destructor xstring ( )
		var temp = ""
		m_str = temp
	end destructor

	'' :::::
	function xstring.empty () as bool
		return 0 = strptr(m_str)
	end function

	'' :::::
	function xstring.len () as ext.SizeType
		return ..len(m_str)
	end function

	'' :::::
	function xstring.explode( byref delimit as const string, res() as string ) as integer
		return ext.strings.explode( this.m_str, delimit, res() )
	end function

	'' :::::
	operator xstring.Cast ( ) as string
		return this.m_str
	end operator

	'' :::::
	operator xstring.Let ( byref rhs as const xstring )
		this.m_str = rhs.m_str
	end operator

	'' :::::
	operator xstring.Let ( byref rhs as const string )
		this.m_str = rhs
	end operator

	'' :::::
	operator xstring.+= ( byref rhs as const xstring )
		this.m_str += rhs.m_str
	end operator

	operator xstring.+= ( byref rhs as const string )
		this.m_str += rhs
	end operator

	'' :::::
	operator xstring.&= ( byref rhs as const xstring )
		this.m_str &= rhs.m_str
	end operator

	operator xstring.&= ( byref rhs as const string )
		this.m_str &= rhs
	end operator

	'' :::::
	operator xstring.-= ( byref rhs as const xstring )
		this.replace(rhs.m_str, "")
	end operator

	'' :::::
	operator xstring.-= ( byref rhs as const string )
		this.replace(rhs, "")
	end operator
	
	'' :::::
	operator xstring.*= ( byval rhs as ext.SizeType )
		this = this.repeat( rhs )
	end operator

	'' :::::
	operator + ( byref lhs as xstring, byref rhs as xstring ) as xstring
		return lhs & rhs
	end operator

	'' :::::
	operator & ( byref lhs as xstring, byref rhs as xstring ) as xstring
		var tmp = lhs
		tmp &= rhs
		return tmp
	end operator

	'' :::::
	operator - ( byref lhs as xstring, byref rhs as xstring ) as xstring
		return lhs.ReplaceCopy(rhs, "")
	end operator

	'' :::::
	operator - ( byref lhs as const XString ) as xstring
		return lhs.ReverseCopy()
	end operator

	'' :::::
	operator * ( byref lhs as xstring, byref rhs as integer ) as xstring
		return lhs.Repeat(rhs)
	end operator

	'' :::::
	operator = ( byref lhs as xstring, byref rhs as xstring ) as integer
		return lhs.m_str = rhs.m_str
	end operator

	'' :::::
	operator <> ( byref lhs as xstring, byref rhs as xstring ) as integer
		return lhs.m_str <> rhs.m_str
	end operator

	'' :::::
	operator > ( byref lhs as xstring, byref rhs as xstring ) as integer
		return lhs.m_str > rhs.m_str
	end operator

	'' :::::
	operator < ( byref lhs as xstring, byref rhs as xstring ) as integer
		return lhs.m_str < rhs.m_str
	end operator

	'' :::::
	operator >= ( byref lhs as xstring, byref rhs as xstring ) as integer
		return lhs.m_str >= rhs.m_str
	end operator

	'' :::::
	operator <= ( byref lhs as xstring, byref rhs as xstring ) as integer
		return lhs.m_str <= rhs.m_str
	end operator

end namespace 'ext.strings
