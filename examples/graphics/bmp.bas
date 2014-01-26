#define FBEXT_NO_EXTERNAL_LIBS -1
#include once "ext/graphics/bmp.bi"

screenres 640, 480, 24

var b1 = ext.gfx.bmp.load(ext.File("marmot1bit.bmp"))
var b2 = ext.gfx.bmp.load(ext.File("marmot2bit.bmp"))
var b4 = ext.gfx.bmp.load(ext.File("marmot4bit.bmp"))
var b8 = ext.gfx.bmp.load(ext.File("marmot8bit.bmp"))
var b8a= ext.gfx.bmp.load(ext.File("marmot8bit-alt.bmp"))
var b6 = ext.gfx.bmp.load(ext.File("marmot16bit.bmp"))
var b6a= ext.gfx.bmp.load(ext.File("marmot16bit-alt.bmp"))
var b24= ext.gfx.bmp.load(ext.File("marmot24bit.bmp"))

var c = 0
while not multikey( fb.SC_ESCAPE )
cls
select case c
case 0
    print "1 bit marmot"
    if b1 = null then
        print "Couldn't load it!"
    else
        b1->Display(0,12,ext.gfx.PSET_)
    end if
case 1
    print "2 bit marmot"
    if b2 = null then
        print "Couldn't load it!"
    else
        b2->Display(0,12,ext.gfx.PSET_)
    end if
case 2
    print "4 bit marmot"
    if b4 = null then
        print "Couldn't load it!"
    else
        b4->Display(0,12,ext.gfx.PSET_)
    end if
case 3
    print "8 bit marmot"
    if b8 = null then
        print "Couldn't load it!"
    else
        b8->Display(0,12,ext.gfx.PSET_)
    end if
case 4
    print "8 bit alt marmot"
    if b8a = null then
        print "Couldn't load it!"
    else
        b8a->Display(0,12,ext.gfx.PSET_)
    end if
case 5
    print "16 bit 565 marmot"
    if b6 = null then
        print "Couldn't load it!"
    else
        b6->Display(0,12,ext.gfx.PSET_)
    end if
case 6
    print "16 bit x555 marmot"
    if b6a = null then
        print "Couldn't load it!"
    else
        b6a->Display(0,12,ext.gfx.PSET_)
    end if
case 7
    print "24 bit marmot"
    if b24 = null then
        print "Couldn't load it!"
    else
        b24->Display(0,12,ext.gfx.PSET_)
    end if
end select
c += 1
if c > 7 then c = 0
sleep 2000
wend
