#include once "ext/graphics/gif.bi"

screenres 320,220,32
var ic = 0u
var fn = command(1)
var t = command(2)
if fn = "" then fn = "test.gif"
if t <> "" then
    var i = ext.gfx.gif.load(fn,ext.gfx.TARGET_FBNEW)
    windowtitle "Press any key to close"
    i->Display(0,0,ext.gfx.PSET_)
    sleep
    delete i
else
    var i = ext.gfx.gif.loadAll(fn,ic)

    if i <> ext.null then
        if ic > 1 then
            windowtitle "Press ESC to Close"
            while not multikey(fb.SC_ESCAPE)
            for n as uinteger = 0 to ic-1
                i[n]->Display(0,0,ext.gfx.PSET_)
                sleep 200,1
            next
            wend
        else
            windowtitle "Press ANY Key to close"
            i[0]->Display(0,0,ext.gfx.PSET_)
            sleep
        end if
        delete[] i
    end if
end if
