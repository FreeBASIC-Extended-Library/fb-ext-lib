''Copyright (c) 2007-2011, FreeBASIC Extended Library Development Group
''Contains code contributed by and Copyright (c) 2007, Pritchard.
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
''"AS IS" AND ANY ExPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''ExEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# include once "ext/math/vectors.bi"

namespace ext.math

constructor vector2d ( byval x as single, byval y as single )

	this.x = x
	this.y = y

end constructor

constructor vector2d ( byref v2d as vector2d )

	this.x = v2d.x
	this.y = v2d.y

end constructor

constructor vector2d ( )

	this.x = 0.0
	this.y = 0.0

end constructor

function vector2d.dot ( byref v As vector2D ) as single
    Return  this.x * v.x + this.y * v.y
end function

function vector2d.magnitude( ) As single
     Dim Mag As Single = any
     mag = Sqr( this.x ^2 + this.y ^2 )
     If mag = 0 Then mag = 1
     return mag
end function

sub vector2d.normalize()
	this = this / this.magnitude()
end sub

function vector2d.cross( byref v as vector2d ) as vector2d
    dim as vector2d crvec, rvec
    crvec = v - this
    dim as single vLen = crvec.magnitude
    rvec.x = ( crvec.y)  / vLen
    rvec.y = (-crvec.x)  / vLen
    return rvec
end function

function vector2d.distance( byref v as vector2d ) as single
	return Sqr((v.x - this.x)^2 + (v.y - this.y)^2)
end function

function vector2d.AngleBetween( byref v as vector2d ) as single
	return acos( this.dot(v) / (this.magnitude * v.magnitude) )
end function

operator vector2d.let( byref rhs as vector2d )
	this.x = rhs.x
	this.y = rhs.y
end operator

operator vector2d.cast() as string
	return "x: " & this.x & ", y: " & this.y
end operator

operator + ( Byref lhs As vector2d, Byref rhs As Single ) As vector2d
    Return Type<vector2d>( lhs.x + rhs, lhs.y + rhs )
End operator

operator + ( byref lhs as vector2d, byref rhs as vector2d ) as vector2d
	return type<vector2d>( lhs.x + rhs.x, lhs.y + rhs.y )
end operator

operator - ( byref lhs as vector2d, byref rhs as vector2d ) as vector2d

	return type<vector2d>( lhs.x - rhs.x, lhs.y - rhs.y )

end operator

operator * ( byref lhs as vector2d, byref rhs as vector2d ) as vector2d

	return type<vector2d>( lhs.x * rhs.x, lhs.y * rhs.y )

end operator


operator * ( byref lhs as vector2d, byref rhs as single ) as vector2d

	return type<vector2d>( lhs.x * rhs, lhs.y * rhs )

end operator 
 
operator * ( byref lhs as vector2d, byref rhs as double ) as vector2d

	return type<vector2d>( lhs.x * rhs, lhs.y * rhs )

end operator

operator / ( byref lhs as vector2d, byref rhs as integer ) as vector2d
	return type<vector2d>( lhs.x / rhs, lhs.y / rhs )
end operator

operator / ( byref lhs as vector2d, byref rhs as vector2d ) as vector2d
	return type<vector2d>( lhs.x / rhs.x, lhs.y / rhs.y )
end operator

operator / ( Byref lhs As vector2d, Byref rhs As Single ) As vector2d
    Return Type<vector2d>(lhs.x / rhs, lhs.y / rhs)
End operator

operator / ( Byref lhs As vector2d, Byref rhs As Double ) As vector2d
    Return Type<vector2d>(lhs.x / rhs, lhs.y / rhs)
End operator

end namespace
