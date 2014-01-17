#define fbext_NoBuiltinInstanciations() 1
# include once "ext/containers/hashtable.bi"
# include once "ext/graphics/detail/common.bi"

#define FBEXT_BUILD_NO_GFX_LOADERS 1
#include once "ext/graphics/image.bi"
using ext.gfx
fbext_Instanciate(fbext_HashTable, ((GraphicsLoader)))

namespace ext.gfx

constructor GraphicsLoader

end constructor

operator GraphicsLoader.let( byref rhs as const GraphicsLoader )
    this.f = rhs.f
    this.fmem = rhs.fmem
end operator

operator = ( byref lhs as const GraphicsLoader, byref rhs as const GraphicsLoader ) as integer
    if lhs.f = rhs.f andalso lhs.fmem = rhs.fmem then
        return true
    else
        return false
    end if
end operator

extern __driver_ht as fbext_HashTable((GraphicsLoader)) ptr

dim shared as fbext_HashTable((GraphicsLoader)) ptr __driver_ht


function getDriver(byref ftype as string, byval set_ as GraphicsLoader ptr = 0 ) as GraphicsLoader ptr

    if __driver_ht = null then __driver_ht = new fbext_HashTable((GraphicsLoader))

    if __driver_ht = null then return null

    if set_ <> null then
    'add a new one
        var s = __driver_ht->Find(ftype)
        if s = null then
            __driver_ht->Insert(ftype,*set_)
        else
            __driver_ht->Remove(ftype)
            __driver_ht->Insert(ftype,*set_)
        end if
    else
        return __driver_ht->Find(ftype)
    end if

    return null

end function

sub destroy__driver_ht_() destructor

    if __driver_ht <> null then delete __driver_ht

end sub

end namespace



