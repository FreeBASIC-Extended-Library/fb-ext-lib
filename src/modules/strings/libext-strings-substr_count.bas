''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

namespace ext.strings

	'' :::::
	function substrcount (byref haystack as string, byref needle as string, byval offset as integer) as integer
		return substrcount(haystack, needle, offset, len(haystack))
	end function
	
	'' :::::
	function substrcount (byref haystack as string, byref needle as string, byval offset as integer, byval length as integer) as integer
	
		if 0 = len(needle) then return STR_NOT_FOUND
		if 0 = len(haystack) then return STR_NOT_FOUND
		
		FBEXT_DETAIL_STRINGS_FIXOFFSET(haystack, offset)
		
		if len(haystack) <= offset then return STR_NOT_FOUND
		if 0 > offset then return STR_NOT_FOUND
		
		FBEXT_DETAIL_STRINGS_FIXLENGTH(haystack, offset, length)
		
		if 0 > length then return STR_NOT_FOUND
		
		var ncount = 0
		var npos = pos(haystack, needle, offset)
		
		do while npos <> STR_NOT_FOUND and npos < (offset + length - len(needle))
			ncount += 1
			npos = pos(haystack, needle, npos + 1 + len(needle))
		loop
		
		return ncount
	
	end function

end namespace ' ext.strings
