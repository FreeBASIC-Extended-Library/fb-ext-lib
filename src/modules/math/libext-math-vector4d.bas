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
# include once "ext/math/matrix.bi"

namespace ext.math

constructor vector4d ( byval x as single, byval y as single, byval z as single, byval w as double )

	this.x = x
	this.y = y
	this.z = z
	this.w = w

end constructor

constructor vector4d ( byref v4d as vector4d )

	this.x = v4d.x
	this.y = v4d.y
	this.z = v4d.z
	this.w = v4d.w

end constructor

constructor vector4d ( )

	this.x = 0.0
	this.y = 0.0
	this.z = 0.0
	this.w = 0.0

end constructor


function vector4d.dot ( byref v As vector4D ) as single
    Return  this.x * v.x + this.y * v.y + this.z * v.z + this.w * v.w
end function

function vector4d.magnitude( ) As single
     Dim Mag As Single = any
     mag = Sqr( this.x ^2 + this.y ^2 + this.z ^2 + this.w ^2 )
     If mag = 0 Then mag = 1
     return mag
end function

sub vector4d.normalize()
	this = this / this.magnitude()
end sub

function vector4d.cross( byref v as vector4d ) as vector4d
	return Type<vector4d>((this.y * v.z) - (v.y * this.z), (this.z * v.x) - (v.z * this.x), (this.x * v.y) - (v.x * this.y), this.w)
end function

function vector4d.distance( byref v as vector4d ) as single
	return Sqr((v.x - this.x)^2 + (v.y - this.y)^2 + (v.z - this.z)^2)
end function

operator vector4d.cast() as string
	return "x: " & this.x & ", y: " & this.y & ", z: " & this.z & ", w: " & this.w
end operator

operator vector4d.cast() as vector3d
	return type<vector3d>(this.x, this.y, this.z)
end operator

operator + ( byref lhs as vector3d, byref rhs as double ) as vector4d
	return Type<vector4d>( lhs.x, lhs.y, lhs.z, rhs )
end operator

operator + ( byref lhs as vector4d, byref rhs as vector4d ) as vector4d
	return type<vector4d>( lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w )
end operator

operator + ( byref lhs as vector4d, byref rhs as single ) as vector4d
	return type<vector4d>( lhs.x + rhs, lhs.y + rhs, lhs.z + rhs, lhs.w + rhs )
end operator

operator - ( byref lhs as vector4d, byref rhs as vector4d ) as vector4d

	return type<vector4d>( lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w )

end operator

operator * ( byref lhs as vector4d, byref rhs as vector4d ) as vector4d

	return type<vector4d>( lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z, lhs.w * rhs.w )

end operator

 
operator * ( Byref lhs As vector4d, Byref rhs As Single ) As vector4d
    Return Type<vector4d>(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs )
End operator

operator vector4d.*= ( byref rhs as matrix )
	this = this * rhs
end operator


operator / ( Byref lhs As vector4d, Byref rhs As integer ) As vector4d
    Return Type<vector4d>(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs )
End operator

operator / ( byref lhs as vector4d, byref rhs as vector4d ) as vector4d
	return type<vector4d>( lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z, lhs.w / rhs.w )
end operator

operator / ( Byref lhs As vector4d, Byref rhs As Single ) As vector4d
    Return Type<vector4d>(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs )
End operator

operator / ( Byref lhs As vector4d, Byref rhs As double ) As vector4d
    Return Type<vector4d>(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs )
End operator

end namespace
