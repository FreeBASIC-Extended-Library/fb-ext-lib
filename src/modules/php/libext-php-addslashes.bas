# include once "ext/php.bi"

namespace ext.php

    '' :::::
    function AddSlashes ( byref text as const string ) as string
    
        ' quote ('), double-quote (") and backslash (\).
        return AddCSlashes(text, !"'\"\\")
    
    end function

end namespace
