''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

#define FBEXT_USE_DEPRECATED 1
# include once "ext/math/vectors.bi"
# include once "ext/math/matrix.bi"

namespace ext.math

constructor vector3d ( byval x as single, byval y as single, byval z as single )

    this.x = x
    this.y = y
    this.z = z

end constructor

constructor vector3d ( byref v3d as vector3d )

    this.x = v3d.x
    this.y = v3d.y
    this.z = v3d.z

end constructor

constructor vector3d ( )

    this.x = 0.0
    this.y = 0.0
    this.z = 0.0

end constructor

function vector3d.dot ( byref v As vector3D ) as single
    Return  this.x * v.x + this.y * v.y + this.z * v.z
end function

function vector3d.magnitude( ) As single
     Dim Mag As Single = any
     mag = Sqr( this.x ^2 + this.y ^2 + this.z ^2 )
     If mag = 0 Then mag = 1
     return mag
end function

sub vector3d.normalize()
    this = this / this.magnitude()
end sub

function vector3d.cross( byref v as vector3d ) as vector3d
    return Type<vector3d>((this.y * v.z) - (v.y * this.z), (this.z * v.x) - (v.z * this.x), (this.x * v.y) - (v.x * this.y))
end function

function vector3d.distance( byref v as vector3d ) as single
    return Sqr((v.x - this.x)^2 + (v.y - this.y)^2 + (v.z - this.z)^2)
end function

function vector3d.AngleBetween( byref v As vector3d ) As Single
    return acos( this.dot(v) / (this.magnitude * v.magnitude) )
end function

operator vector3d.cast() as string
    return "x: " & this.x & ", y: " & this.y & ", z: " & this.z
end operator

operator vector3d.cast() as vector2d
    return type<vector2d>(this.x, this.y)
end operator

operator + ( Byref lhs As vector3d, Byref rhs As Single ) As vector3d
    Return Type<vector3d>( lhs.x + rhs, lhs.y + rhs,  lhs.z + rhs )
End operator

operator + ( Byref lhs As vector3d, Byref rhs As vector3d ) As vector3d
    Return Type<vector3d>( lhs.x + rhs.x, lhs.y + rhs.y,  lhs.z + rhs.z )
End operator

operator - ( Byref lhs As vector3d ) As vector3d

    Return Type<vector3d>(-lhs.x, -lhs.y, -lhs.z )

End operator


operator - ( Byref lhs As vector3d, Byref rhs As vector3d ) As vector3d

    Return Type<vector3d>(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z )

End operator

operator - ( Byref lhs As vector3d, Byref rhs As vector4d ) As vector3d

    Return Type<vector3d>(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z )

End operator


operator - ( Byref lhs As vector3d, Byref rhs As Single ) As vector3d

    Return Type<vector3d>(lhs.x - rhs, lhs.y - rhs, lhs.z - rhs )

End operator


operator * ( Byref lhs As vector3d, Byref rhs As vector3d ) As vector3d

    Return Type<vector3d>(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z )

End operator

operator * ( Byref lhs As vector3d, Byref rhs As vector4d ) As vector3d

    Return Type<vector3d>(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z )

End operator

operator * ( Byref lhs As vector3d, Byref rhs As Double ) As vector3d
    Return Type<vector3d>(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs )
End operator


operator * ( Byref lhs As vector3d, Byref rhs As Single ) As vector3d
    Return Type<vector3d>(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs )
End operator

'operator vector3d.*= ( byref rhs as matrix )
'   this = this * rhs
'end operator

operator vector3d.*= ( Byref s As single )
    this.x *= s
    this.y *= s
    this.z *= s
End operator


operator vector3d.+=( byref rhs As vector3d )
    this.x += rhs.x
    this.y += rhs.y
    this.z += rhs.z
end operator


operator / ( Byref lhs As vector3d, Byref rhs As vector3d ) As vector3d
    Return Type<vector3d>(lhs.x / rhs.x, lhs.y / rhs.y, lhs.z / rhs.z )
End operator

operator / ( Byref lhs As vector3d, Byref rhs As Single ) As vector3d
    Return Type<vector3d>(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs )
End operator

operator / ( Byref lhs As vector3d, Byref rhs As Double ) As vector3d
    Return Type<vector3d>(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs )
End operator

end namespace
