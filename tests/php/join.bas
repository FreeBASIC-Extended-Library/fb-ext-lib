# include once "ext/testly.bi"
# include once "ext/php.bi"

namespace ext.tests.php_

    ' ext.php.Join is an alias to ext.php.Implode, so only the API needs
    ' testing..
    
    '' :::::
    private sub API
        dim strings(0) as string
        dim result as string = ext.php.Join("", strings())
    end sub
    
    '' :::::
    private sub register constructor
        ext.testly.addSuite("ext-php-join")
        ext.testly.addTest("API", @API)
    end sub

end namespace
