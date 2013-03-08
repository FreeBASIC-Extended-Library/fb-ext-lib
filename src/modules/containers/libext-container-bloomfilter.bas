''Copyright (c) 2013, FreeBASIC Extended Library Development Group
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

#include once "ext/containers/bloomfilter.bi"

namespace ext

function BloomFilter.load( byref fname as const string ) as ext.bool
    var f = freefile
    dim x as uinteger ptr
    dim size_f as uinteger
    if open( fname, for binary, access read, as #f) = 0 then
        size_f = lof(f)
        x = new uinteger[size_f/4]
        if x = 0 then return ext.bool.true
        get #f, ,*x,size_f/4
        close #f
    else
        return ext.bool.true
    end if
    setExpected(x[0])
    m_ba->binload(cast(ubyte ptr,x+1),size_f-4)
    delete[] x
    return ext.bool.false
end function

function BloomFilter.save( byref fname as const string ) as ext.bool
    dim vals() as uinteger
    m_ba->dumpbin(vals())
    var fw = freefile
    if open(fname, for binary, access write, as #fw) = 0 then
        put #fw, , m_expected
        put #fw, ,vals()
        close #fw
    else
        return ext.bool.true
    end if
    return ext.bool.false
end function

function BloomFilter.calc_sizeof_bf( byval n as uinteger, byval p as double ) as uinteger
    return cuint( abs((n*log(p))/((log(2)^2) ) ) )
end function

function BloomFilter.calc_numberof_hashes( byval m as uinteger, byval n as uinteger ) as uinteger
    return cuint( abs( (m/n)*log(2) ) )
end function

constructor BloomFilter()
    m_ba = new ext.BitArray
end constructor

sub BloomFilter.add( byref x as const string )

    for n as uinteger = 0 to m_hashruns
        var res = ext.hashes.joaat( strptr(x), len(x), n ) mod m_basize
        m_ba->set(res)
    next

end sub

function BloomFilter.lookup( byref x as const string ) as ext.bool

    for n as uinteger = 0 to m_hashruns
        var res = ext.hashes.joaat( strptr(x), len(x), n ) mod m_basize
        if m_ba->isset(res) = ext.bool.false then return ext.bool.false
    next

    return ext.bool.true
end function

constructor BloomFilter( byval expected as uinteger )
    setExpected( expected )
    m_ba = new ext.BitArray(m_basize)
end constructor

constructor BloomFilter( byref rhs as BloomFilter )
    m_ba = rhs.m_ba
    m_basize = rhs.m_basize
    m_hashruns = rhs.m_hashruns
end constructor

destructor BloomFilter()
    if m_ba <> ext.null then delete m_ba
end destructor

sub BloomFilter.setExpected( byval expected as uinteger )
    m_expected = expected
    m_basize = calc_sizeof_bf(expected,0.01)
    m_hashruns = calc_numberof_hashes(m_basize,expected)
end sub

end namespace
