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

#define fbext_NoBuiltinInstanciations() -1
# include once "ext/algorithms/detail/common.bi"
# include once "ext/math/matrix.bi"

namespace ext.math
fbext_Instanciate(fbext_Vector2, ((single)))
fbext_Instanciate(fbext_Vector3, ((single)))
fbext_Instanciate(fbext_Vector4, ((single)))

    '' :::::
    constructor matrix ( byref c as single = 0)

        for i as integer = 0 to 15
            this.m(i) = c
        next

    end constructor

    '' :::::
    constructor matrix ( byref r as vec3f, byref u as vec3f, byref f as vec3f, byref p as vec3f )

        this.m(0)  = r.x
        this.m(1)  = r.y
        this.m(2)  = r.z
        this.m(3)  = 0

        this.m(4)  = u.x
        this.m(5)  = u.y
        this.m(6)  = u.z
        this.m(7)  = 0

        this.m(8)  = f.x
        this.m(9)  = f.y
        this.m(10) = f.z
        this.m(11) = 0

        this.m(12) = p.x
        this.m(13) = p.y
        this.m(14) = p.z
        this.m(15) = 1

    end constructor

    '' :::::
    constructor matrix ( byref x as matrix )
        memcpy(@m(0), @x.m(0), sizeof(single) * 16)
    end constructor

    '' :::::
    function matrix.Identity ( ) as matrix

        var res = matrix()

        res.m(0 )  = 1
        res.m(1 )  = 0
        res.m(2 )  = 0
        res.m(3 )  = 0

        res.m(4 )  = 0
        res.m(5 )  = 1
        res.m(6 )  = 0
        res.m(7 )  = 0

        res.m(8 )  = 0
        res.m(9 )  = 0
        res.m(10)  = 1
        res.m(11)  = 0

        res.m(12)  = 0
        res.m(13)  = 0
        res.m(14)  = 0
        res.m(15)  = 1

        return res

    end function

    '' :::::
    sub matrix.LoadIdentity()
        m(0 )  = 1
        m(1 )  = 0
        m(2 )  = 0
        m(3 )  = 0

        m(4 )  = 0
        m(5 )  = 1
        m(6 )  = 0
        m(7 )  = 0

        m(8 )  = 0
        m(9 )  = 0
        m(10)  = 1
        m(11)  = 0

        m(12)  = 0
        m(13)  = 0
        m(14)  = 0
        m(15)  = 1
    end sub

    '' :::::
    operator matrix.*= ( byref mat as matrix )

        dim as single tmp_m(15) = any

        tmp_m(0)  = (mat.m(0)  * this.m(0))+(mat.m(1)  * this.m(4))+(mat.m(2)  * this.m(8)) +(mat.m(3)  * this.m(12))
        tmp_m(1)  = (mat.m(0)  * this.m(1))+(mat.m(1)  * this.m(5))+(mat.m(2)  * this.m(9)) +(mat.m(3)  * this.m(13))
        tmp_m(2)  = (mat.m(0)  * this.m(2))+(mat.m(1)  * this.m(6))+(mat.m(2)  * this.m(10))+(mat.m(3)  * this.m(14))
        tmp_m(3)  = (mat.m(0)  * this.m(3))+(mat.m(1)  * this.m(7))+(mat.m(2)  * this.m(11))+(mat.m(3)  * this.m(15))
        tmp_m(4)  = (mat.m(4)  * this.m(0))+(mat.m(5)  * this.m(4))+(mat.m(6)  * this.m(8)) +(mat.m(7)  * this.m(12))
        tmp_m(5)  = (mat.m(4)  * this.m(1))+(mat.m(5)  * this.m(5))+(mat.m(6)  * this.m(9)) +(mat.m(7)  * this.m(13))
        tmp_m(6)  = (mat.m(4)  * this.m(2))+(mat.m(5)  * this.m(6))+(mat.m(6)  * this.m(10))+(mat.m(7)  * this.m(14))
        tmp_m(7)  = (mat.m(4)  * this.m(3))+(mat.m(5)  * this.m(7))+(mat.m(6)  * this.m(11))+(mat.m(7)  * this.m(15))
        tmp_m(8)  = (mat.m(8)  * this.m(0))+(mat.m(9)  * this.m(4))+(mat.m(10) * this.m(8)) +(mat.m(11) * this.m(12))
        tmp_m(9)  = (mat.m(8)  * this.m(1))+(mat.m(9)  * this.m(5))+(mat.m(10) * this.m(9)) +(mat.m(11) * this.m(13))
        tmp_m(10) = (mat.m(8)  * this.m(2))+(mat.m(9)  * this.m(6))+(mat.m(10) * this.m(10))+(mat.m(11) * this.m(14))
        tmp_m(11) = (mat.m(8)  * this.m(3))+(mat.m(9)  * this.m(7))+(mat.m(10) * this.m(11))+(mat.m(11) * this.m(15))
        tmp_m(12) = (mat.m(12) * this.m(0))+(mat.m(13) * this.m(4))+(mat.m(14) * this.m(8)) +(mat.m(15) * this.m(12))
        tmp_m(13) = (mat.m(12) * this.m(1))+(mat.m(13) * this.m(5))+(mat.m(14) * this.m(9)) +(mat.m(15) * this.m(13))
        tmp_m(14) = (mat.m(12) * this.m(2))+(mat.m(13) * this.m(6))+(mat.m(14) * this.m(10))+(mat.m(15) * this.m(14))
        tmp_m(15) = (mat.m(12) * this.m(3))+(mat.m(13) * this.m(7))+(mat.m(14) * this.m(11))+(mat.m(15) * this.m(15))

        memcpy(@this.m(0), @tmp_m(0), 16 * sizeof(single))

    end operator

    '' :::::
    operator *( byref lhs as matrix, byref rhs as matrix ) as matrix

        var tmp = lhs
        tmp *= rhs
        return tmp

    end operator

    '' :::::
    operator matrix.cast() as string

        dim as string mstring
        for i as integer = 0 to 15
            if i<10 then
                mstring += trim("(" & i & " ) " & this.m(i)) & chr(13,10)
            else
                mstring += trim("(" & i & ") " & this.m(i)) & chr(13,10)
            end if
        next
        return mstring

    end operator

    operator matrix.cast() as single ptr
        return @this.m(0)
    end operator


    '' :::::
    operator * ( byref lhs as vec2f, byref rhs as matrix ) as vec2f

        return type<vec2f>( lhs.x*rhs.getarraydata[0] + lhs.y*rhs.getarraydata[4] + rhs.getarraydata[12], _
        lhs.x*rhs.getarraydata[1] + lhs.y*rhs.getarraydata[5] + rhs.getarraydata[13] )


    end operator

    '' :::::
    operator * ( byref lhs as vec3f, byref rhs as matrix ) as vec3f

        return type<vec3f>( lhs.x*rhs.getarraydata[0] + lhs.y*rhs.getarraydata[4] + lhs.z*rhs.getarraydata[8]  + rhs.getarraydata[12], _
        lhs.x*rhs.getarraydata[1] + lhs.Y*rhs.getarraydata[5] + lhs.Z*rhs.getarraydata[9]  + rhs.getarraydata[13], _
        lhs.x*rhs.getarraydata[2] + lhs.Y*rhs.getarraydata[6] + lhs.Z*rhs.getarraydata[10] + rhs.getarraydata[14] )

    end operator

    '' :::::
    operator * ( byref lhs as vec4f, byref rhs as matrix ) as vec4f

        return type<vec4f>( lhs.x*rhs.getarraydata[0] + lhs.y*rhs.getarraydata[4] + lhs.z*rhs.getarraydata[8]  + rhs.getarraydata[12], _
        lhs.x*rhs.getarraydata[1] + lhs.Y*rhs.getarraydata[5] + lhs.Z*rhs.getarraydata[9]  + rhs.getarraydata[13], _
        lhs.x*rhs.getarraydata[2] + lhs.Y*rhs.getarraydata[6] + lhs.Z*rhs.getarraydata[10] + rhs.getarraydata[14], lhs.w  )

    end operator



    '' :::::
    sub matrix.LookAt( byref v1 as vec3f, byref v2 as vec3f, byref vup as vec3f )
        dim as vec3f d = v1-v2
        d.normalize
        dim as vec3f r = d.cross(vup)
        dim as vec3f u = r.cross(d)
        r.normalize
        u.normalize

        this.m(0)  = -r.x
        this.m(1)  = u.x
        this.m(2)  = d.x
        this.m(3)  = 0.0

        this.m(4)  = -r.y
        this.m(5)  = u.y
        this.m(6)  = d.y
        this.m(7)  = 0.0

        this.m(8)  = -r.z
        this.m(9)  = u.z
        this.m(10) = d.z
        this.m(11) = 0

        this.m(12)  = 0.0
        this.m(13)  = 0.0
        this.m(14)  = 0.0
        this.m(15)  = 1.0

        dim as matrix matrix2
        matrix2.LoadIdentity
        matrix2.Position =-v1
        this*= matrix2
    end sub


    '' :::::
    sub matrix.PointAt( byref v1 as vec3f, byref v2 as vec3f )

        dim as vec3f d = v1-v2
        d.normalize
        dim as vec3f u = vec3f(0,-1,0)
        dim as vec3f r = d.cross(u)
        r.normalize
        u = -r.cross(d)
        u.normalize

        this.m(0)  = r.x
        this.m(1)  = r.y
        this.m(2)  = r.z
        this.m(3)  = 0.0

        this.m(4)  = u.x
        this.m(5)  = u.y
        this.m(6)  = u.z
        this.m(7)  = 0.0

        this.m(8)  = d.x
        this.m(9)  = d.y
        this.m(10) = d.z
        this.m(11) = 0.0

        this.m(12)  = v1.x
        this.m(13)  = v1.y
        this.m(14)  = v1.z
        this.m(15)  = 1.0

    end sub


    '' :::::
    function matrix.Inverse() as matrix

        dim as matrix inverted
        inverted.m(0)  = this.m(0)
        inverted.m(1)  = this.m(4)
        inverted.m(2)  = this.m(8)
        inverted.m(4)  = this.m(1)
        inverted.m(5)  = this.m(5)
        inverted.m(6)  = this.m(9)
        inverted.m(8)  = this.m(2)
        inverted.m(9)  = this.m(6)
        inverted.m(10) = this.m(10)
        inverted.m(3)  = 0.0f
        inverted.m(7)  = 0.0f
        inverted.m(11) = 0.0f
        inverted.m(15) = 1.0f

        inverted.m(12) = -(this.m(12) * this.m(0)) - (this.m(13) * this.m(1)) - (this.m(14) * this.m(2))
        inverted.m(13) = -(this.m(12) * this.m(4)) - (this.m(13) * this.m(5)) - (this.m(14) * this.m(6))
        inverted.m(14) = -(this.m(12) * this.m(8)) - (this.m(13) * this.m(9)) - (this.m(14) * this.m(10))
        return inverted

    end function

    '' :::::
    sub matrix.Invert()

        dim tmp_m(15) as single = any

        tmp_m(0)  = this.m(0)
        tmp_m(1)  = this.m(4)
        tmp_m(2)  = this.m(8)
        tmp_m(4)  = this.m(1)
        tmp_m(5)  = this.m(5)
        tmp_m(6)  = this.m(9)
        tmp_m(8)  = this.m(2)
        tmp_m(9)  = this.m(6)
        tmp_m(10) = this.m(10)
        tmp_m(3)  = 0.0f
        tmp_m(7)  = 0.0f
        tmp_m(11) = 0.0f
        tmp_m(15) = 1.0f

        tmp_m(12) = -(this.m(12) * this.m(0)) - (this.m(13) * this.m(1)) - (this.m(14) * this.m(2))
        tmp_m(13) = -(this.m(12) * this.m(4)) - (this.m(13) * this.m(5)) - (this.m(14) * this.m(6))
        tmp_m(14) = -(this.m(12) * this.m(8)) - (this.m(13) * this.m(9)) - (this.m(14) * this.m(10))

        memcpy(@this.m(0), @tmp_m(0), sizeof(single) * 16)

    end sub

    '' :::::
    function matrix.Invert_copy() as matrix

        var tmp = this
        tmp.invert()
        return tmp

    end function

    '' :::::
    function matrix.PlanarProjection( byref lightpos as vec4f, byref plane as vec4f ) as matrix

	var projected_matrix = matrix()

        with plane
            var xx = .x * lightpos.x
            var yy = .y * lightpos.y
            var zz = .z * lightpos.z
            var ww = .w * lightpos.w
            var dot = xx + yy + zz + ww

            projected_matrix.m( 0) = dot - xx
            projected_matrix.m( 1) = -lightpos.y * .x
            projected_matrix.m( 2) = -lightpos.z * .x
            projected_matrix.m( 3) = -lightpos.w * .x

            projected_matrix.m( 4) = -lightpos.x * .y
            projected_matrix.m( 5) = dot - yy
            projected_matrix.m( 6) = -lightpos.z * .y
            projected_matrix.m( 7) = -lightpos.w * .y

            projected_matrix.m( 8) = -lightpos.x * .z
            projected_matrix.m( 9) = -lightpos.y * .z
            projected_matrix.m(10) = dot - zz
            projected_matrix.m(11) = -lightpos.w * .z

            projected_matrix.m(12) = -lightpos.x * .w
            projected_matrix.m(13) = -lightpos.y * .w
            projected_matrix.m(14) = -lightpos.z * .w
            projected_matrix.m(15) = dot - ww
        end with
        return projected_matrix

    end function


    sub matrix.InfiniteProjection( byref fov as single, byref aspectratio as single, byref znear as single )

        this.m(4)  = 0
        this.m(8)  = 0
        this.m(12) = 0
        this.m(1)  = 0
        this.m(9)  = 0
        this.m(13) = 0
        this.m(2)  = 0
        this.m(6)  = 0
        this.m(3)  = 0
        this.m(7)  = 0
        this.m(15) = 0

        this.m(0)  = ( 1f/tan(fov) ) / aspectratio
        this.m(5)  = ( 1f/tan(fov) )
        this.m(14) = -2f * znear
        this.m(10) = -1f
        this.m(11) = -1f

    end sub


    '' :::::
    sub matrix.AxisAngle( byref v as vec3f, byref angle as single )
        dim as single tc = cos(angle*pi_180)
        dim as single ts = sin(angle*pi_180)
        dim as single tt = 1 - tc
        v.normalize
        this.m(0)  = tc + v.x*v.x*tt
        this.m(5)  = tc + v.y*v.y*tt
        this.m(10) = tc + v.z*v.z*tt
        dim as single tmp1 = v.x*v.y*tt
        dim as single tmp2 = v.z*ts
        this.m(4) = tmp1 + tmp2
        this.m(1) = tmp1 - tmp2
        tmp1 = v.x*v.z*tt
        tmp2 = v.y*ts
        this.m(8) = tmp1 - tmp2
        this.m(2) = tmp1 + tmp2
        tmp1 = v.y*v.z*tt
        tmp2 = v.x*ts
        this.m(9) = tmp1 + tmp2
        this.m(6) = tmp1 - tmp2
        this.m(15) = 1
    end sub

    '' :::::
    sub matrix.Translate( byref x as single, byref y as single, byref z as single )

        var t = matrix()
        t.LoadIdentity
        t.Position = type<vec3f>(x,y,z)
        this *= t

    end sub

    '' :::::
    sub matrix.Translate( byref x as integer, byref y as integer, byref z as integer )

        var t = matrix()
        t.LoadIdentity
        t.Position = type<vec3f>(x,y,z)
        this *= t

    end sub


    '' :::::
    sub matrix.Rotate( byref anglex as single, byref angley as single, byref anglez as single )

        dim as single tcos = any
        dim as single tsin = any
        var tm = matrix()

        if anglex <> 0 then
            tm.LoadIdentity
            tcos = cos( anglex * pi_180 )
            tsin = sin( anglex * pi_180 )
            tm.m( 5)= tcos
            tm.m( 6)= tsin
            tm.m( 9)=-tsin
            tm.m(10)= tcos
            this *= tm
        end if

        if angley <> 0 then
            tm.LoadIdentity
            tcos = cos( angley * pi_180 )
            tsin = sin( angley * pi_180 )
            tm.m( 0)= tcos
            tm.m( 2)=-tsin
            tm.m( 8)= tsin
            tm.m(10)= tcos
            this *= tm
        end if

        if anglez <> 0 then
            tm.LoadIdentity
            tcos = cos( anglez * pi_180 )
            tsin = sin( anglez * pi_180 )
            tm.m(0) = tcos
            tm.m(1) = tsin
            tm.m(4) =-tsin
            tm.m(5) = tcos
            this *= tm
        end if

    end sub

    sub matrix.Rotate( byref anglex as integer, byref angley as integer, byref anglez as integer )
        dim as single tcos = any
        dim as single tsin = any
        var tm = matrix()

        if anglex <> 0 then
            tm.LoadIdentity
            tcos = cos( anglex * pi_180 )
            tsin = sin( anglex * pi_180 )
            tm.m( 5)= tcos
            tm.m( 6)= tsin
            tm.m( 9)=-tsin
            tm.m(10)= tcos
            this *= tm
        end if

        if angley <> 0 then
            tm.LoadIdentity
            tcos = cos( angley * pi_180 )
            tsin = sin( angley * pi_180 )
            tm.m( 0)= tcos
            tm.m( 2)=-tsin
            tm.m( 8)= tsin
            tm.m(10)= tcos
            this *= tm
        end if

        if anglez <> 0 then
            tm.LoadIdentity
            tcos = cos( anglez * pi_180 )
            tsin = sin( anglez * pi_180 )
            tm.m(0) = tcos
            tm.m(1) = tsin
            tm.m(4) =-tsin
            tm.m(5) = tcos
            this *= tm
        end if
    end sub

    '' :::::
    sub matrix.Scale( byref scalar as single )
        dim as matrix temp
        temp.LoadIdentity
        temp.m(0)  = scalar
        temp.m(5)  = scalar
        temp.m(10) = scalar
        this*=temp
    end sub

    '':::::
    sub matrix.Scale( byref scalarx as single, byref scalary as single, byref scalarz as single )
        dim as matrix temp
        temp.LoadIdentity
        temp.m(0)  = scalarx
        temp.m(5)  = scalary
        temp.m(10) = scalarz
        this*=temp
    end sub

    '':::::
    sub matrix.Gram_Schmidt( byref d as vec3f )
        dim as vec3f r
        dim as vec3f u
        dim as vec3f f = d

        f *= ( 1.0 / sqr(f.dot(f)) )

        if abs(f.z) >.577 then
            r = f * type<vec3f>(-f.y, f.z, 0.0)
        else
            r = f * type<vec3f>(-f.y, f.x, 0.0)
        end if
        r *= ( 1.0 / sqr(r.dot(r)) )
        u = r * f

        this.LoadIdentity
        this.Forward = f
        this.Up = u
        this.Right = r
        this.Position = type<vec3f>(0,0,0)
    end sub



    '' :::::
    property matrix.Right( byref v  as vec3f )
    m(0) = v.x
    m(1) = v.y
    m(2) = v.z
    end property

    '' :::::
    property matrix.Up( byref v  as vec3f )
    m(4) = v.x
    m(5) = v.y
    m(6) = v.z
    end property

    '' :::::
    property matrix.Forward( byref v  as vec3f )
    m(8)  = v.x
    m(9)  = v.y
    m(10) = v.z
    end property

    '' :::::
    property matrix.Position( byref v  as vec3f )
    m(12) = v.x
    m(13) = v.y
    m(14) = v.z
    end property

    '' :::::
    property matrix.Right() as vec3f
    return type<vec3f>(m(0), m(1), m(2))
    end property

    '' :::::
    property matrix.Up() as vec3f
    return type<vec3f>(m(4), m(5), m(6))
    end property

    '' :::::
    property matrix.Forward() as vec3f
    return type<vec3f>(m(8), m(9), m(10))
    end property

    '' :::::
    property matrix.Position() as vec3f
    return type<vec3f>(m(12), m(13), m(14))
    end property


    property matrix.GetArrayData() as single ptr
    return @this.m(0)
    end property

end namespace
