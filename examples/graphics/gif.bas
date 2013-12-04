#include once "ext/graphics/gif.bi"

screenres 320,220,32

var i = ext.gfx.gif.load("test.gif",ext.gfx.target_e.TARGET_FBNEW)

if i <> ext.null then
    i->Display(0,0,ext.gfx.PSET_)
    sleep
    delete i
end if
