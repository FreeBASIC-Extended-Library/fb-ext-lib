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

# include once "ext/detail/common.bi"
#include once "ext/math/detail/common.bi"
# include once "ext/hash/joaat.bi"

namespace ext.hashes

	'' :::::
	function joaat ( byref xStr as const string ) as uinteger

		return joaat( cast(zstring ptr,strptr(xStr)), len(xStr) )

	end function

	'' :::::
	function joaat ( byval src__ as const any ptr, byval len_b as uinteger ) as uinteger

		if (src__ = NULL) or (len_b < 1) then return 0
		
		var src = cast(const ubyte ptr, src__)
		dim as uinteger hash
	
		if len_b > 1 then
			for i as uinteger = 0 to (len_b-1)
				hash += src[i]
				hash += (hash shl 10)
				hash xor= (hash shr 6)
			next
	
		else
			hash += src[0]
			hash += (hash shl 10)
			hash xor= (hash shr 6)
	
		end if
	
		hash += (hash shl 3)
		hash xor= (hash shr 11)
		hash += (hash shl 15)
	
		return hash

	end function

	'' :::::
	function joaat64 ( byref xStr as const string ) as ulongint

		return joaat64( cast(zstring ptr,strptr(xStr)), len(xStr) )

	end function

	'' :::::
	function joaat64 ( byval src__ as const any ptr, byval len_b as uinteger ) as ulongint

		if (src__ = NULL) or (len_b < 1) then return 0
	
		var src = cast(const ubyte ptr, src__)
		dim as ulongint hash
	
		if len_b > 1 then
			for i as uinteger = 0 to (len_b-1)
				hash += src[i]
				hash += shl64(hash, 20)
				hash xor= shr64(hash, 12)
			next
	
		else
			hash += src[0]
			hash += shl64(hash, 20)
			hash xor= shr64(hash, 12)	
		end if
	
		hash += shl64(hash, 6)
		hash xor= shr64(hash, 22)
		hash += shl64(hash, 30)
	
		return hash

	end function

end namespace 'ext.hashes
