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

#define FBEXT_BUILD_NO_GFX_LOADERS 1
#include once "ext/graphics/image.bi"
#include once "ext/graphics/xpm.bi"
#include once "ext/file/file.bi"
#include once "ext/strings/split.bi"
#include once "ext/strings/manip.bi"

namespace ext.gfx.xpm

type xpm_color
    as string ch
    as uinteger co
end type

public function load( byref fn as File ) as Image ptr

    var xf = fn

    if xf.open() = true then return NULL

    'verify xpm
    var l = xf.readLine()
    if trim(l) <> "/* XPM */" then return NULL

    do until l[0] = asc(!"\"")
        l = xf.readLine()
    loop
    l = trim(l)
    l = trim(l,!"\"")
    l = strings.compact(l)
    l = trim(l)
    dim specs() as string
    strings.explode(l," ",specs())
    if specs(0)[0] = asc(!"\"") then
        specs(0)[0] = 32
        specs(0) = trim(specs(0))
    end if

    var xwidth = cuint(specs(0))
    var xheight = cuint(specs(1))
    var xcolors = cuint(specs(2))
    var xcpp = cuint(specs(3))

    dim xcm(xcolors) as xpm_color

    l = xf.readLine()
    l = trim(l)
    var readit = ext.true
    if left(l,2) <> "/*" then readit = ext.false

    for n as ulong = 0 to xcolors -1
        if readit = ext.true then l = xf.readLine()
        l = trim(l)
        l = trim(l,",")
        l = trim(l,!"\"")
        dim v() as string
        strings.explode(l,!"\t",v())
        var ind = 1
        if ubound(v) = 0 then
            strings.explode(l," ",v())
            ind = 2
        end if
        if ubound(v) > 0 then
            if xcpp > 1 then
                for z as ulong = 0 to xcpp -1
                    if z > len(v(0)) then
                        xcm(n).ch &= " "
                    else
                        xcm(n).ch &= chr(v(0)[z])
                    end if
                next
            else
                xcm(n).ch = left(v(0),1)
            end if
            var vx = ""
            if v(ind)[0] = asc("c") then
                vx = mid(v(1),3)
            else
                vx = v(ind)
            end if
            if lcase(vx) = "none" then vx = hex(rgb(255,0,255))
            if len(vx) = 7 then
                vx = trim(vx,"#")
                vx = "FF" & vx
            end if
            xcm(n).co = cuint("&h" & trim(trim(vx,"#")))
        end if
        readit = ext.true
    next

    var ret = new Image(xwidth,xheight)
    if ret = NULL then return NULL

    for n as ulong = 0 to xheight -1
        l = xf.readLine()
        l = trim(l)
        l = trim(l,",")
        l = trim(l,!"\"")
        for m as ulong = 0 to xwidth * xcpp step xcpp
            var colorch = ""
            if xcpp > 1 then
                for r as ulong = 0 to xcpp -1
                    colorch &= chr(l[m+r])
                next
            else
                colorch = chr(l[m])
            end if
            var i = 0
            for s as ulong = lbound(xcm) to ubound(xcm)
                if colorch = xcm(s).ch then
                    i = s
                    exit for
                end if
            next
            var t = ret->m_img
            pset t, ((m/xcpp)-1,n), xcm(i).co
        next
    next

    xf.close()

    return ret

end function

end namespace

