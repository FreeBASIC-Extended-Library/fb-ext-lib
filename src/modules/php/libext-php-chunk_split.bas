# include once "ext/php.bi"
# include once "ext/algorithms/detail/common.bi"


namespace ext.php

    '' :::::
    function Chunk_Split ( byref text as const string, byval length as integer, byref ending as const string ) as string
    
        if (strptr(text) = null) then return ""
        
        ' FIXME: throw a runtime error here ?
        if (length = 0) then return ""
        
        if (length >= len(text)) then return text & ending
        
        var splitcount = len(text) \ length
        var firstn = (splitcount) * (length + len(ending))
        var remaining = len(text) mod length
        var lastn = iif(remaining, remaining + len(ending), 0)
        
        var result = space(firstn + lastn)
        
        dim src as ubyte ptr = strptr(text)
        dim dst as ubyte ptr = strptr(result)
        
        for s as integer = 1 to splitcount
            memcpy(dst, src, length)
            src += length
            dst += length
            memcpy(dst, strptr(ending), len(ending))
            dst += len(ending)
        next
        
        if (remaining) then
            memcpy(dst, src, remaining)
            dst += remaining
            memcpy(dst, strptr(ending), len(ending))
        end if
        
        return result
    
    end function

end namespace
