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

# include once "ext/strings/misc.bi"

namespace ext.strings

declare function lev_minimum( byval a as integer, byval b as integer, byval c as integer ) as integer

function LevenshteinDistance( byref s as const string, byref t as const string ) as integer

dim as integer k, i, j, n, m, cost, distance
dim as integer ptr d

n = len(s)
m = len(t)

if (n <> 0) AND (m <> 0) then
   d = allocate( sizeof(integer) * (m+1) * (n+1) )
   m += 1
   n += 1
   k = 0

   while k < n
      d[k]=k
      k += 1
   wend

   k = 0
   while k < m
      d[k*n]=k
      k += 1
   wend

   i = 1
   while i < n
      j = 1

      while j<m
         if (s[i-1] = t[j-1]) then
            cost = 0

         else
            cost = 1

         end if

         d[j*n+i] = lev_minimum(d[(j-1)*n+i]+1, d[j*n+i-1]+1, d[(j-1)*n+i-1]+cost)

         j += 1
      wend

      i += 1
   wend

   distance = d[n*m-1]
   deallocate d

   return distance

else
   return -1

end if

end function

private function lev_minimum( byval a as integer, byval b as integer, byval c as integer ) as integer

var min = a

if (b<min) then min = b
if (c<min) then min = c

return min

end function


end namespace 'ext.strings
