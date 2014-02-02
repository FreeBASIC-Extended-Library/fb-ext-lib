''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

# include once "ext/strings.bi"
# include once "ext/algorithms/detail/common.bi"
# include once "detail/strings.bi"

namespace ext.strings

	'' :::::
	function tokenize( byval x as zstring ptr = 0, byref tkns as const string, byval lastfound as ubyte ptr = 0, byval eattkns as bool = true ) as string

		static zr as string
		static sp as integer
		static lasttkn as integer

		if x <> 0 then
			zr = *x
			sp = 0
			lasttkn = -1
		end if

		var ret = ""
		var tklen = len(tkns)
		var zrlen = len(zr)

		while sp < zrlen
			for n as integer = 0 to tklen-1
				if zr[sp] = tkns[n] then
					if lasttkn = sp - 1 then
						if eattkns = true then
							lasttkn = sp
							continue for
						else
							lasttkn = sp
							if lastfound <> 0 then *lastfound = tkns[n]
							sp += 1
							return ret
						end if
					else
						if lastfound <> 0 then *lastfound = tkns[n]
						lasttkn = sp
						sp += 1
						return ret
					end if
				end if
				if lasttkn = n then exit for
			next

			if lasttkn <> sp then
				ret = ret & chr(zr[sp])
			end if

			sp += 1

		wend

		if lastfound <> 0 then *lastfound = 0
		return ret

	end function

	'' :::::
	function substr (byref subject as const string, byval offset as integer) as string
		return substr(subject, offset, len(subject))
	end function

	'' :::::
	function substr (byref subject as const string, byval offset as integer, byval length as integer) as string

		FBEXT_DETAIL_STRINGS_FIXOFFSET(subject, offset)

		' FIXME: should throw an error here..
		if len(subject) <= offset then return ""
		if 0 > offset then return ""

		FBEXT_DETAIL_STRINGS_FIXLENGTH(subject, offset, length)

		' FIXME: should throw an error here..
		if 0 > length then return ""

		var result = space(length)
		memcpy(strptr(result), @subject[offset], length)
		return result

	end function

end namespace 'ext.strings
