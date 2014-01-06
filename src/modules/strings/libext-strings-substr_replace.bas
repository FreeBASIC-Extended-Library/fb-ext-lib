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
# include once "crt/string.bi"

namespace ext.strings

	'' :::::
	sub substrreplace (byref subject as string, byref replacement as string, byval offset as integer)
		substrreplace(subject, replacement, offset, len(subject))
	end sub
	
	'' :::::
	sub substrreplace (byref subject as string, byref replacement as string, byval offset as integer, byval length as integer)
	
		FBEXT_DETAIL_STRINGS_FIXOFFSET(subject, offset)
		
		if len(subject) <= offset then return
		if 0 > offset then return
		
		FBEXT_DETAIL_STRINGS_FIXLENGTH(subject, offset, length)
		
		' FIXME: throw an error here..
		if 0 > length then return
		
		var finalsize = len(subject) - length + len(replacement)
		var result = space(finalsize)
		
		var src = strptr(subject)
		var dst = strptr(result)
		
		' copy before the replacement point..
		if 0 < offset then
			memcpy(dst, src, offset)
			dst += offset
		end if
		
		' copy the replacement..
		memcpy(dst, strptr(replacement), len(replacement))
		
		src += offset + length
		
		' copy after the replacement text ?
		if src <> strptr(subject) + len(subject) then
			dst += len(replacement)
			memcpy(dst, src, @subject[len(subject)] - src)
		end if
		
		subject = result
	
	end sub

end namespace ' ext.strings
