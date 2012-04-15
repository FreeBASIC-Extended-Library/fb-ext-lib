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

# include once "ext/hash/crc32.bi"

namespace ext.hashes

function crc32 ( byval buf as const any ptr, byval buf_len as uinteger, byval crc as uinteger ) as uinteger

	static crc_table(256) as uinteger => { _
	&h00000000, &h77073096, &hee0e612c, &h990951ba, &h076dc419, &h706af48f, _
	&he963a535, &h9e6495a3, &h0edb8832, &h79dcb8a4, &he0d5e91e, &h97d2d988, _
	&h09b64c2b, &h7eb17cbd, &he7b82d07, &h90bf1d91, &h1db71064, &h6ab020f2, _
	&hf3b97148, &h84be41de, &h1adad47d, &h6ddde4eb, &hf4d4b551, &h83d385c7, _
	&h136c9856, &h646ba8c0, &hfd62f97a, &h8a65c9ec, &h14015c4f, &h63066cd9, _
	&hfa0f3d63, &h8d080df5, &h3b6e20c8, &h4c69105e, &hd56041e4, &ha2677172, _
	&h3c03e4d1, &h4b04d447, &hd20d85fd, &ha50ab56b, &h35b5a8fa, &h42b2986c, _
	&hdbbbc9d6, &hacbcf940, &h32d86ce3, &h45df5c75, &hdcd60dcf, &habd13d59, _
	&h26d930ac, &h51de003a, &hc8d75180, &hbfd06116, &h21b4f4b5, &h56b3c423, _
	&hcfba9599, &hb8bda50f, &h2802b89e, &h5f058808, &hc60cd9b2, &hb10be924, _
	&h2f6f7c87, &h58684c11, &hc1611dab, &hb6662d3d, &h76dc4190, &h01db7106, _
	&h98d220bc, &hefd5102a, &h71b18589, &h06b6b51f, &h9fbfe4a5, &he8b8d433, _
	&h7807c9a2, &h0f00f934, &h9609a88e, &he10e9818, &h7f6a0dbb, &h086d3d2d, _
	&h91646c97, &he6635c01, &h6b6b51f4, &h1c6c6162, &h856530d8, &hf262004e, _
	&h6c0695ed, &h1b01a57b, &h8208f4c1, &hf50fc457, &h65b0d9c6, &h12b7e950, _
	&h8bbeb8ea, &hfcb9887c, &h62dd1ddf, &h15da2d49, &h8cd37cf3, &hfbd44c65, _
	&h4db26158, &h3ab551ce, &ha3bc0074, &hd4bb30e2, &h4adfa541, &h3dd895d7, _
	&ha4d1c46d, &hd3d6f4fb, &h4369e96a, &h346ed9fc, &had678846, &hda60b8d0, _
	&h44042d73, &h33031de5, &haa0a4c5f, &hdd0d7cc9, &h5005713c, &h270241aa, _
	&hbe0b1010, &hc90c2086, &h5768b525, &h206f85b3, &hb966d409, &hce61e49f, _
	&h5edef90e, &h29d9c998, &hb0d09822, &hc7d7a8b4, &h59b33d17, &h2eb40d81, _
	&hb7bd5c3b, &hc0ba6cad, &hedb88320, &h9abfb3b6, &h03b6e20c, &h74b1d29a, _
	&head54739, &h9dd277af, &h04db2615, &h73dc1683, &he3630b12, &h94643b84, _
	&h0d6d6a3e, &h7a6a5aa8, &he40ecf0b, &h9309ff9d, &h0a00ae27, &h7d079eb1, _
	&hf00f9344, &h8708a3d2, &h1e01f268, &h6906c2fe, &hf762575d, &h806567cb, _
	&h196c3671, &h6e6b06e7, &hfed41b76, &h89d32be0, &h10da7a5a, &h67dd4acc, _
	&hf9b9df6f, &h8ebeeff9, &h17b7be43, &h60b08ed5, &hd6d6a3e8, &ha1d1937e, _
	&h38d8c2c4, &h4fdff252, &hd1bb67f1, &ha6bc5767, &h3fb506dd, &h48b2364b, _
	&hd80d2bda, &haf0a1b4c, &h36034af6, &h41047a60, &hdf60efc3, &ha867df55, _
	&h316e8eef, &h4669be79, &hcb61b38c, &hbc66831a, &h256fd2a0, &h5268e236, _
	&hcc0c7795, &hbb0b4703, &h220216b9, &h5505262f, &hc5ba3bbe, &hb2bd0b28, _
	&h2bb45a92, &h5cb36a04, &hc2d7ffa7, &hb5d0cf31, &h2cd99e8b, &h5bdeae1d, _
	&h9b64c2b0, &hec63f226, &h756aa39c, &h026d930a, &h9c0906a9, &heb0e363f, _
	&h72076785, &h05005713, &h95bf4a82, &he2b87a14, &h7bb12bae, &h0cb61b38, _
	&h92d28e9b, &he5d5be0d, &h7cdcefb7, &h0bdbdf21, &h86d3d2d4, &hf1d4e242, _
	&h68ddb3f8, &h1fda836e, &h81be16cd, &hf6b9265b, &h6fb077e1, &h18b74777, _
	&h88085ae6, &hff0f6a70, &h66063bca, &h11010b5c, &h8f659eff, &hf862ae69, _
	&h616bffd3, &h166ccf45, &ha00ae278, &hd70dd2ee, &h4e048354, &h3903b3c2, _
	&ha7672661, &hd06016f7, &h4969474d, &h3e6e77db, &haed16a4a, &hd9d65adc, _
	&h40df0b66, &h37d83bf0, &ha9bcae53, &hdebb9ec5, &h47b2cf7f, &h30b5ffe9, _
	&hbdbdf21c, &hcabac28a, &h53b39330, &h24b4a3a6, &hbad03605, &hcdd70693, _
	&h54de5729, &h23d967bf, &hb3667a2e, &hc4614ab8, &h5d681b02, &h2a6f2b94, _
	&hb40bbe37, &hc30c8ea1, &h5a05df1b, &h2d02ef8d }

	dim c as uinteger
	dim n as uinteger
	var buf_ = cast(ubyte ptr, buf)

	c = crc xor &hffffffff

	if buf <> null then
	for n = 0 to buf_len - 1
		c = crc_table((c xor buf_[n]) and &hff) xor (c shr 8)
	next n
	else
	return c
	endif
	
	return c xor &hffffffff
   
end function 

function crc32 ( byref buf as const string ) as uinteger

	return crc32( strptr(buf), len(buf), 0 )

end function	

end namespace
