''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
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
# include once "ext/containers/hashtable.bi"
# include once "ext/hash.bi"

# include once "crt.bi"

namespace ext

	'' :::::
	function m_IndexFor ( byval hashvalue as uinteger, byval tablelength as SizeType ) as uinteger
	
		return (hashvalue mod tablelength) 
	
	end function
    
	'' :::::
	function m_HTprimes( byval index as SizeType ) as uinteger
	
		static as uinteger _primes(0 to 25) = { _
						53, 97, 193, 389, _
						769, 1543, 3079, 6151, _
						12289, 24593, 49157, 98317, _
						196613, 393241, 786433, 1572869, _
						3145739, 6291469, 12582917, 25165843, _
						50331653, 100663319, 201326611, 402653189, _
						805306457, 1610612741 }
		
		return _primes(index)
	
	end function
    
	'' :::::
	function m_HThash( byref key_ as const string ) as uinteger

		return ext.hashes.joaat("FBEXTSALT" & key_)

	end function

end namespace ' ext

