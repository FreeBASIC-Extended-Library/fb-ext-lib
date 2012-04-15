# include once "ext/php.bi"
# include once "crt/string.bi" ' for memcpy


namespace ext.php

    '' :::::
    function Implode ( byref glue as const string, strings() as const string ) as string
    
        ' assumes a non-empty array !!!
        var lb = lbound(strings), ub = ubound(strings)
        var numstrings = ub - lb + 1
        
        if (numstrings = 1) then
            return strings(lb)
        end if
        
        var result_size = len(strings(lb))
        
        if (strptr(glue) <> null) then
            for i as integer = (lb + 1) to ub
                result_size += len(glue) + len(strings(i))
            next
        
        else
            for i as integer = (lb + 1) to ub
                result_size += len(strings(i))
            next
        
        end if
        
        var result = space(result_size)
        var dst = cast(ubyte ptr, strptr(result))
        ..memcpy(dst, strptr(strings(lb)), len(strings(lb)))
        dst += len(strings(lb))
        
        if (strptr(glue) <> null) then
            for i as integer = (lb + 1) to ub
                ..memcpy(dst, strptr(glue), len(glue))
                dst += len(glue)
                
                var l = len(strings(i))
                ..memcpy(dst, strptr(strings(i)), l)
                dst += l
            next
        
        else
            for i as integer = (lb + 1) to ub
                var l = len(strings(i))
                ..memcpy(dst, strptr(strings(i)), l)
                dst += l
            next
        
        end if
        
        return result
    
    end function

end namespace
