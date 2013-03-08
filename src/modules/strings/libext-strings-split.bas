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
# include once "crt/string.bi"

namespace ext.strings

	'' :::::
	function split (byref s as const string, result() as string, byref delimiter as const string, byval limit as integer) as integer
	
		type substr__
		        as integer start, length
		end type
		
		const max_substrings__ = 100000
	
		static dt(0 to max_substrings__ - 1) as substr__
		
		if 0 = len(delimiter) then return false
		function = true
		
		var ss_count = 0
		
		var it = strptr(s)
		do while it <> strptr(s) + len(s)
		
			var found_delim = true
			
			' try to match first delimiter char..
			if *it <> delimiter[0] then
				found_delim = false
			
			' try to match rest of delimiter..
			elseif len(delimiter) > 1 then
				var it2 = it + 1
				for j as integer = 1 to len(delimiter) - 1
					if *it2 <> delimiter[j] then
						found_delim = false : exit for
					end if
					it2 += 1
				next
			
			end if
			
			if not found_delim then
				it += 1
			
			else
				' returning a maximum number of substrings ?
				if 0 < limit then
					if ss_count = limit - 1 then exit do
				end if
			
				var index = it - strptr(s)
				
				dt(ss_count).length = index - dt(ss_count).start
				ss_count += 1
				dt(ss_count).start = index + len(delimiter)
				
				it += len(delimiter)
			
			end if
		
		loop
		
		' last substring is the remaining string..
		dt(ss_count).length = len(s) - dt(ss_count).start + 1
		ss_count += 1
		
		' returning all but a number of remaining substrings ?
		if 0 > limit then ss_count -= -limit
		
		' fill result array..
		redim result(0 to ss_count - 1) as string
		for ss as integer = 0 to ss_count - 1
			result(ss) = mid(s, dt(ss).start + 1, dt(ss).length)
		next
	
		function = ss_count

	end function

end namespace ' ext.strings
