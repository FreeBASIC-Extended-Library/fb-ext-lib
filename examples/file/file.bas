# include once "ext/file/file.bi"
# include once "ext/error.bi"

var myfile = ext.File("test.txt", ext.file.R)

if myfile.open = ext.false then

	do while not myfile.eof

		print myfile.linput

	loop

else

	print ext.GetErrorText(myfile.LastError)

end if