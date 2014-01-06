'ext.zipfile example
#define fbext_nobuiltininstanciations() 1
#include once "ext/file/zipfile.bi"

var zf = command()
if zf = "" then
    ? "List the files in the passed zip file."
    ? "Usage: " & command(0) & " file.zip"
    end 42
end if

var zfile = ext.ZipFile(zf)

dim files() as string
zfile.fileNames(files())

? zf & " contains:"
for n as integer = 0 to ubound(files)
    ? files(n)
next

