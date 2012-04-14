# include once "ext/php.bi"

namespace ext.php

    '' :::::
    function Count_Chars ( byref text as const string, byval what as Count_CharsEnum ) as string
    
        select case as const what
        case used_chars, unused_chars
        case else
            return ""
        end select
        
        dim charcount(255) as ext.SizeType
        
        for i as integer = 0 to len(text) - 1
            charcount(text[i]) += 1
        next
        
        var result = ""
        
        for c as integer = 0 to 255
            select case as const what
            case used_chars
                if (charcount(c) > 0) then
                    result += chr(c)
                end if
            
            case unused_chars
                if (charcount(c) = 0) then
                    result += chr(c)
                end if
            
            end select
        next
        
        return result
    
    end function
    
    '' :::::
    function Count_Chars ( byref text as const string, result() as Count_CharsInfo, byval what as Count_CharsEnum ) as ext.SizeType
    
        select case as const what
        case used_chars, unused_chars, all_chars
        case else
            return 0
        end select
        
        dim charcount(255) as ext.SizeType
        var usedchars = 0
        
        for i as integer = 0 to len(text) - 1
            if (charcount(text[i]) = 0) then
                usedchars += 1
            end if
            charcount(text[i]) += 1
        next
        
        select case as const what
        case used_chars
            redim result(0 to usedchars - 1)
            var i = 0
            for c as integer = 0 to 255
                if (charcount(c) > 0) then
                    result(i).code = c
                    result(i).count = charcount(c)
                    i += 1
                end if
            next
            return usedchars
        
        case unused_chars
            redim result(0 to 255 - usedchars)
            var i = 0
            for c as integer = 0 to 255
                if (charcount(c) = 0) then
                    result(i).code = c
                    i += 1
                end if
            next
            return 256 - usedchars
        
        case all_chars
            redim result(0 to 255)
            for c as integer = 0 to 255
                result(c).code = c
                result(c).count = charcount(c) 
            next
            return 256
        
        end select
        
    
    end function

end namespace
