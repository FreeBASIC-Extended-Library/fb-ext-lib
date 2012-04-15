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

# include once "ext/containers/bitarray.bi"

namespace ext
	
	const bitsPerStorage = sizeof(SizeType) * 8
	
    '' :::::
    constructor BitArray ( byval sz as SizeType )
        size(sz)
    end constructor
 
    '' :::::
    destructor BitArray ( )
        if m_bits then delete[] m_bits
    end destructor
 
    '' :::::
    function BitArray.isset( byval bitnum as SizeType ) as ext.bool
 
        if m_size <= bitnum then return invalid
 
        var i = int(bitnum / bitsPerStorage)
        var j = bitnum mod bitsPerStorage 
 
        return 0 <> (m_bits[i] and 2^j)
 
    end function
 
    '' :::::
    sub BitArray.set( byval bitnum as SizeType )
 
        if m_size <= bitnum then return
 
        if not isset(bitnum) then toggle(bitnum)
 
    end sub
 
    '' :::::
    sub BitArray.reset( byval bitnum as SizeType )
 
        if m_size <= bitnum then return
 
        if isset(bitnum) then toggle(bitnum)
 
    end sub
 
    '' :::::
    sub BitArray.toggle( byval bitnum as SizeType )
 
        if m_size <= bitnum then return
 
        var i = int(bitnum / bitsPerStorage)
        var j = bitnum mod bitsPerStorage 
 
        m_bits[i] xor= 2^j
 
    end sub
 
    '' :::::
    sub BitArray.load ( byref bitstring as string )
 
        if m_size < len(bitstring) then return
 
        for i as SizeType = 0 to len(bitstring) - 1
            if asc("1") = bitstring[i] then
                this.set(len(bitstring) - i - 1)
            else
                this.reset(len(bitstring) - i - 1)
            end if
 
        next
 
    end sub
 
    '' :::::
    function BitArray.dump ( ) as string
 
        if m_size = 0 then return ""
 
        var tempstr = space(m_size)
        for i as SizeType = 0 to m_size - 1
            tempstr[m_size - i - 1] = iif( this.IsSet( i ), asc( "1" ), asc( "0" ) )
        next
 
        return tempstr
 
    end function
 
    sub BitArray.size ( byval num as SizeType )
 
        if 0 = num then
            m_bits = null
            m_size = 0
 
        else
            var min_units = int((num + (bitsPerStorage - 1)) / bitsPerStorage)
 
            m_bits = new SizeType[min_units]
            m_size = num
 
        end if
 
    end sub

'TODO: Make this more efficient.
'    sub BitArray.resize( byval num as uinteger )
' 
'        if 0 <> m_size then
' 
'            if m_size > num then
'                m_size = num
' 
'            else
'                var min_units = int((num + (bitsPerStorage - 1)) / bitsPerStorage)
' 
'                var newbits = new StorageType[min_units]
'                if newbits then
'                    m_bits = newbits
'                end if
'                m_size = num
' 
'            end if
'        end if
' 
'    end sub

end namespace ' ext

