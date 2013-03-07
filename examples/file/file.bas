# include once "ext/file/file.bi"
# include once "ext/error.bi"

var myfile = ext.File("test.txt", ext.ACCESS_TYPE.R)

if myfile.open = ext.false then

    do while not myfile.eof

        print myfile.readLine

    loop

else

    print ext.GetErrorText(myfile.LastError)

end if
