#include once "ext/vregex.bi"

using ext

sub test_url( byref url as string )
    var expr = VRegex()
    with expr
        .searchOneLine()
        .startOfLine()
        ._then("http")
        .maybe("s")
        ._then("://")
        .maybe("www.")
        .anythingBut(" ")
        .endOfLine()
    end with

    if expr.test(url) then
        print url & " is a valid url."
    else
        print url & " is NOT a valid url."
    end if
    if expr.error_string <> 0 then
        ? *(expr.error_string)
    end if
    print expr
end sub

sub test_replace( )
    var expr = VRegex()
    expr.find("red")
    print expr.replace("The house is red.","blue")
    print expr.replace("My name is Fred.","rank")
    print expr
end sub

var turl = "https://www.google.com"
if command(1) <> "" then
    turl = command(1)
end if

print "URL Test:"
test_url(turl)
print

print "Replace Test:"
test_replace