# include once "ext/php.bi"

namespace ext.php

    '' :::::
    function Bin2Hex ( byref text as const string ) as string
    
        if (strptr(text) = null) then return ""
        
        var result = string(len(text) * 2, asc("0"))
        
        for c as integer = 0 to len(text) - 1
            var ch = text[c]
            
            if (ch >= &h10) then
                mid(result, (2 * c) + 1, 2) = hex(ch)
            
            else
                mid(result, (2 * c) + 2, 1) = hex(ch)
            
            end if
        next
        
        return result
    
    end function

end namespace
