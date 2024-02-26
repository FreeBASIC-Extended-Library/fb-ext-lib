''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
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

namespace ext.strings

    '' :::::
    function explode( byref xStr as const string, byref delimit as const string, res() as string ) as integer
    
        return Split(xStr, res(), delimit, 0)
        
    /'
        var delim = delimit[0]
        var dcount = 0
        
        for n as integer = 0 to len(xStr)-1
            if (xStr[n] = delim) then dcount += 1
        next
        
        redim res(dcount)
        
        var instr_ret = 1, last_instr = 1
        var ctr = 0
        
        
        do
        
            instr_ret = instr( last_instr, xStr, delimit )
            
            if (instr_ret) then
                var t_in = instr_ret - last_instr
                
                if t_in = 0 OR t_in = 1 then
                res(ctr) = ""
                
                else
                    res(ctr) = mid(xStr, last_instr, instr_ret - last_instr )
                
                end if
            
                ctr += 1
                last_instr = instr_ret + 1
                
            else
                res(ctr) = mid(xStr, last_instr )
                exit do
            
            end if
        
        loop
        
        return dcount + 1
    '/
    end function

end namespace ' ext.strings
