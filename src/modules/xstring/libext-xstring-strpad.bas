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

# include once "ext/xstring.bi"
# include once "ext/strings.bi"

namespace ext.strings

	'' :::::
	function xstring.PadCopy ( byval length as integer, byref pad_str as const string, byval opt as PAD_OPTION ) as xstring

		if (length <= 0) or (length < this.len) or (..len(pad_str) < 1) then return ""

		var tog = iif(opt = STR_PAD_BOTH, STR_PAD_RIGHT, opt)
		dim xstr as string = this.m_str
		
		do while ..len(xstr) < length

			if (..len(xstr) + ..len(pad_str)) > length then
				if(tog = STR_PAD_RIGHT) then 
					xstr = ..left(xstr & pad_str, length)

				else
					xstr = ..right(pad_str & xstr, length)

				end if

			else
				if(tog = STR_PAD_RIGHT) then
					xstr &= pad_str

				else
					xstr = pad_str & xstr

				end if

			end if

			if opt = STR_PAD_BOTH then
				tog = iif(tog = STR_PAD_RIGHT, STR_PAD_LEFT, STR_PAD_RIGHT)
			end if
		loop

		return xstr

	end function

	'' :::::
	sub xstring.Pad ( byval length as integer, byref pad_str as const string, byval opt as PAD_OPTION )
		var x = this.PadCopy(length, pad_str, opt)
		if x <> "" then this = x

	end sub
end namespace
