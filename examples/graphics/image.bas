#define fbext_NoBuiltinInstanciations() 1
#include once "ext/memory/sharedptr.bi"
#include once "ext/graphics/image.bi"

''Todo: Expand this example

namespace ext.gfx
fbext_Instanciate(fbext_SharedPtr, ((Image)))
end namespace

using ext.gfx
screenres 320,240,32

var sp1 = ext.gfx.fbext_SharedPtr((Image))(new Image(10,10,RGB(255,0,0)))

sp1.get()->Display(1,1)

sleep
