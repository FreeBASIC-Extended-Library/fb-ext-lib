''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
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

# include once "ext/strings.bi"
# include once "detail/strings.bi"
# include once "crt/string.bi"

namespace ext.strings

	'' :::::
	function substrcompare (byref a as const string, byref b as const string, byval offset as integer) as integer
		return substrcompare(a, b, offset, len(a))
	end function
	
	'' :::::
	function substrcompare (byref a as const string, byref b as const string, byval offset as integer, byval length as integer) as integer
	
		FBEXT_DETAIL_STRINGS_FIXOFFSET(a, offset)
		
		' FIXME: should throw an error here..
		if 0 > offset then return -1
		if len(a) <= offset then return -1
		
		FBEXT_DETAIL_STRINGS_FIXLENGTH(a, offset, length)
		
		' FIXME: should throw an error here..
		if 0 > length then return -1
		
		' length can be zero here..
		var result = memcmp(@a[offset], @b[0], length)
		
		return iif(0 = result, _
			iif(length = len(b), 0, iif(length < len(b), -1, 1)), _
			result)
	
	end function

end namespace 'ext.strings
