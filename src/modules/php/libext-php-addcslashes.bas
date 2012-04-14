# include once "ext/php.bi"

namespace ext.php

    '' :::::
    function AddCSlashes ( byref text as const string, byref chars as const string ) as string
    
        if (strptr(text) = null) then return ""
        if (strptr(chars) = null) then return text
        
        var result = space(2 * len(text))
        var src = cast(ubyte ptr, strptr(text))
        var dst = cast(ubyte ptr, strptr(result))
        
        for x as integer = 0 to len(text) - 1
            for y as integer = 0 to len(chars) - 1
                if (*src = chars[y]) then
                    *dst = asc("\")
                    dst += 1
                    exit for
                end if
            next
            *dst = *src
            dst += 1
            src += 1
        next
        
        return left(result, dst - cast(ubyte ptr, strptr(result)))
    
    end function

end namespace
