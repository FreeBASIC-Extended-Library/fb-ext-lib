# include once "ext/php.bi"
# include once "ext/algorithms/detail/common.bi"

namespace ext.php

    '' :::::
    function StrRChr ( byref text as const string, byref char as const string ) as string
    
        if (strptr(char) <> null) then
            return ext.php.StrRChr(text, char[0])
        end if
        
        return ""
    end function

    '' :::::
    function StrRChr ( byref text as const string, byval char as ubyte ) as string
    
        if (strptr(text) = null) then
            return ""
        end if
        
        var first = cast(ubyte ptr, strptr(text))
        var last = first + len(text)
        var it = last - 1
        
        do while (first <> it)
            if (*it = char) then
                exit do
            end if
            it -= 1
        loop
        
        if (first <> it) then
            var result_size = last - it
            var result = space(result_size)
            memcpy(strptr(result), it, result_size)
            return result
        end if
        
        return ""
    
    end function

end namespace
