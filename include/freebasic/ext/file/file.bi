''Title: file/file.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_FILE_FILE_BI__
# define FBEXT_FILE_FILE_BI__ -1

# include once "ext/file/detail/common.bi"

'' Namespace: ext
namespace ext

    ''Class: File
    ''Manages a connection to a disk file.
    ''
    ''Notes:
    ''This class is Threadsafe.
    ''
    ''See Also:
    ''<Simple File class example>
    type File
    public:

        ''Sub: Standard "file" constructor
        ''Sets the file to open and its access level.
        ''
        ''Parameters:
        ''filename - the file to open.
        ''acc - one of <ACCESS_TYPE>
        ''
        declare constructor ( byref filename as const string, byval acc as ACCESS_TYPE = R )

        ''Sub: FileSystemDriver constructor
        ''Creates a file-like object from any source.
        ''
        ''Parameters:
        ''fsd - pointer to the <FileSystemDriver> to use (created with new or helper function.)
        ''
        declare constructor ( byval fsd as FileSystemDriver ptr )

        ''Sub: default constructor
        ''Constructs an invalid File object. Use the <open> function to
        ''make this a valid File object.
        ''
        declare constructor ( )

        ''Function: open
        ''Used with the default constructor to open a file.
        ''
        ''Parameters:
        ''filename - the file to open.
        ''acc - one of <ACCESS_TYPE>
        ''
        ''Returns:
        ''ext.false on success, ext.true on failure.
        ''
        declare function open( byref filename as const string, byval acc as ACCESS_TYPE = R ) as ext.bool

        ''Function: open
        ''Opens the file specified to the constructor.
        ''
        ''Returns:
        ''ext.false on success, ext.true on failure.
        ''
        declare function open() as ext.bool

        ''Sub: close
        ''Closes access to a disk file.
        ''
        declare sub close()

        ''Property: handle
        ''Used to retrieve the handle of the open file for use in input and write statements.
        ''
        ''Returns:
        ''integer containing the file handle.
        ''
        declare property handle() as integer

        ''Function: lof
        ''Retrieves the length of the currently open file in bytes.
        ''
        ''Returns:
        ''longint containing the number of bytes in the file.
        ''
        declare function lof() as longint

        ''Function: loc
        ''Retrieves the current position in the file.
        ''
        ''Returns:
        ''longint containing the current position in the file.
        ''
        declare function loc() as longint

        ''Function: eof
        ''Tells whether or not the end of the file has been reached.
        ''
        ''Returns:
        ''ext.true at the end of the file, ext.false otherwise.
        declare function eof() as ext.bool

        ''Property: seek
        ''Seeks to a position in the file.
        ''
        ''Parameters:
        ''poz - the position in the file to seek to, 1 based.
        ''
        declare property seek( byval poz as longint )

        ''Property: seek
        ''Returns the position in the file the next read or write will happen.
        ''
        ''Returns:
        ''longint containing the next read or write position.
        ''
        declare property seek() as longint

    # macro fbext_FilePrint_Declare(T_)
    :
        ''Sub: print
        ''Overloaded print routine that will print one of any built-in datatype.
        ''
        ''Parameters:
        ''data_ - the data to print to the file.
        ''
        declare sub print ( byref data_ as fbext_TypeName(T_) )

        ''Sub: print
        ''Overloaded print routine that will print an array of any built-in datatype.
        ''
        ''Parameters:
        ''_data() - the array to print to the file.
        ''amount - optional amount of data to print to the file, defaults to ubound(_data)
        ''
        declare sub print ( _data() as fbext_TypeName(T_) , byval amount as integer = 0 )
    :
    # endmacro

    # macro fbext_FileGet_Declare(T_)
    :
        ''Sub: get
        ''Gets any number of a datatype from the open file, overloaded for all built-in types.
        ''
        ''Parameters:
        ''filepos - optional file position to retrieve the data from, defaults to the current file postition.
        ''data_ - the variable to retrieve the data into.
        ''amount - optional amount of data to retrieve, defaults to 1.
        ''
        declare sub get( byval filepos as longint = -1, byref data_ as fbext_TypeName(T_), byval amount as integer = 1 )
    :
    # endmacro

    # macro fbext_FilePut_Declare(T_)
    :
        ''Sub: put
        ''Puts any number of a datatype to the open file, overloaded for all built-in types.
        ''
        ''Parameters:
        ''filepos - optional file position to place the data at, defaults to the current file postition.
        ''data_ - the data to place in the file.
        ''amount - optional amount of data to place, defaults to 1.
        ''
        declare sub put( byval filepos as longint = -1, byref data_ as fbext_TypeName(T_), byval amount as integer = 1 )
    :
    # endmacro

    fbext_InstanciateMulti(fbext_FilePrint, fbext_BuiltinTypes())
    fbext_InstanciateMulti(fbext_FileGet, fbext_BuiltinTypes())
    fbext_InstanciateMulti(fbext_FilePut, fbext_BuiltinTypes())

        ''Function: readLine
        ''Line Input function. Retrieves one line of text from the file.
        ''
        ''Returns:
        ''string containing one line of text from the file.
        ''
        declare function readLine () as string

        ''Property: LastError
        ''Retrieves the error number of the last error, only set by <open>
        ''
        ''Returns:
        ''integer value of the error code.
        ''
        declare property LastError () as integer

        ''Function: toBuffer
        ''Loads the file into a memory buffer.
        ''
        ''Parameter:
        ''dest - byref ubyte pointer that will point to the memory buffer. This memory is allocated by the function and should be destroyed using delete[].
        ''
        ''Returns:
        ''The size of the allocated buffer (in bytes)
        ''
        declare function toBuffer( byref dest as ubyte ptr ) as SizeType

        declare destructor ()

        declare function getBytesRW() as ulongint

    private:

        m_filename as string
        m_access as integer
        m_filehandle as integer
        m_lasterror as integer
        m_fsd as FileSystemDriver ptr
        m_bytes as ulongint

    #ifdef FBEXT_MULTITHREADED

        m_mutex as any ptr

    #endif

    end type

    ''Example: Simple File class example
    ''(begin code)
    ''#include "ext/file.bi"
    ''using ext
    ''
    ''var myfile = ext.File("test.txt",R)
    ''
    ''if myfile.open = false then
    ''
    ''  do while not myfile.eof
    ''
    ''      print myfile.readLine
    ''
    ''  loop
    ''
    ''else
    ''
    ''  print GetErrorText(myfile.LastError)
    ''
    ''end if
    ''(end code)
    ''
end namespace

# endif ' include guard
