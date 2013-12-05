''FreeBASIC Extended Library Sprite Benchmark
#define fbext_NoBuiltinInstanciations() -1
#define fbext_no_libjpg -1
#define FBEXT_NO_LIBFREETYPE -1
#define s2i(x) cast(fb.image ptr,*(x))

#include once "ext/graphics/sprite.bi"
#include once "ext/graphics/image.bi"
#include once "ext/math/random.bi"
#include once "fbgfx.bi"
using ext.gfx

#define MAX_FRAME 3

var s_w = 0
var s_h = 0
var sp_next_cnt = 100
var sp_cnt = 0
var stable = 5.0
var fps = 0
var cur_frame = 1
var cnt_over = 0


if command() = "" then
    screeninfo(s_w,s_h)
else
    s_w = valint(command(1))
    s_h = valint(command(2))
end if

screenres s_w, s_h, 32

dim sp() as ext.gfx.Sprite
chdir exepath()

print "This benchmark will be flashing the screen at a high rate, please press ESC to cancel."
sleep 5000

var next_update = 0.0
var cur_time = 0.0

while not multikey(fb.sc_escape)

    cur_time = timer

    if sp_next_cnt > sp_cnt then

        redim preserve sp(sp_next_cnt)
        for n as integer = sp_cnt to sp_next_cnt
            var x1 = new image(32,32)
            circle s2i(x1),(16,16),10,rgb(255,0,0)
            var x2 = new image(32,32)
            circle s2i(x2),(16,16),7,rgb(0,255,0)
            var x3 = new image(32,32)
            circle s2i(x3),(16,16),4,rgb(0,0,255)
            sp(n).Init(MAX_FRAME)
            sp(n).SetImage(1,x1)
            sp(n).SetImage(2,x2)
            sp(n).SetImage(3,x3)
            'sp(n).fromSpritesheet(cast(fb.image ptr,orig_i), 0, 0, 32, 36, 0, 8)
            sp(n).Position(ext.math.rndrange(1,s_w), ext.math.rndrange(1,s_h))
        next
        sp_cnt = sp_next_cnt
        next_update = cur_time + stable

    end if

    var frame_in = timer

    screenlock
        cls

    for n as integer = 0 to sp_cnt - 1

        sp(n).DrawImage(cur_frame,,ext.gfx.DrawMethods.trans_)

    next

    'screenunlock

    var frame_out = timer

    'screenlock
        fps += int((frame_out - frame_in)*1000)
        fps /= 2
        draw string (0,0),"MS per frame: " & fps & " Sprites: " & sp_cnt
        screensync
    screenunlock

    cur_frame += 1
    if cur_frame > MAX_FRAME then cur_frame = 1

    if next_update < cur_time then
        if fps < 40 then
            sp_next_cnt *= 1.1
        else
            exit while
        end if
    end if

    if fps > 40 then cnt_over += 1
    if cnt_over > 5 then exit while

    sleep 10,1

wend

while inkey <> ""
wend

cls
print "Results:"
print "Maximum sprites < 40 ms on avg = " & int(sp_cnt/1.1) & " to " & sp_cnt
print "Screen Width: " & s_w & " Screen Height: " & s_h
print "press any key to continue"
sleep

''cleanup
'delete orig_i
