''File: image.bas
''Description: Demonstration of ext.gfx.image class with SharedPtr.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

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
