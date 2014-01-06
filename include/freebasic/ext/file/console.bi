''Title: file/console.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_FILE_CONSOLE_BI__
# define FBEXT_FILE_CONSOLE_BI__ -1

# include once "ext/file/detail/common.bi"

'' Namespace: ext
namespace ext

    ''Enum: ConsoleIO
    ''Used by the Console object to determine whether to read or write from the console.
    ''
    ''con_stdin - opens the console for input
    ''con_stdout - opens the console for output
    ''
    enum ConsoleIO
    	con_stdin
    	con_stdout
    end enum
    
    '' Class: Console
    '' Class emulating the basic functionality of C#'s System.Console object.
    ''
    '' Notes:
    '' This object is threadsafe.
    type Console
    
    	public:
    		''Sub: Constructor
    		''
    		''Parameters:
    		''io - the method to open the console with, defaults to con_stdout
    		''
    		declare constructor ( byval io as ConsoleIO = ConsoleIO.con_stdout )
    
    		''Function: ReadLine
    		''Retreives one full line of input from the console.
    		''
    		declare function ReadLine( ) as string
    
    	# macro fbext_ConsoleWrite_Declare(T_)
    	:
    		''Sub: Write
    		''Overloaded to print any built-in type to the console without a line break afterwards.
    		''
    		declare sub Write ( byref x as fbext_TypeName(T_) )
    		
    		''Sub: WriteLine
    		''Overloaded to print any built-in type to the console followed by a line break.
    		''
    		declare sub WriteLine ( byref x as fbext_TypeName(T_) )
    	:
    	# endmacro
    	
    	fbext_InstanciateMulti(fbext_ConsoleWrite, fbext_NumericTypes() (((string))) )
        
    		''Property: LastError
    		''Returns the integer error code of the last error.
    		''
    		''0 indicates no error, -1 is error in usage, >0 is error code from the runtime library
    		''
    		declare property LastError( ) as integer
    		declare destructor ( )
    
    	private:
    		m_filehandle as integer
    		m_lasterror as integer
    		m_mode as ConsoleIO
    	#ifdef FBEXT_MULTITHREADED
    		m_mutex as any ptr
    	#endif
    end type

end namespace

# endif ' include guard
