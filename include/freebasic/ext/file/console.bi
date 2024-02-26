''Title: file/console.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# ifndef FBEXT_FILE_CONSOLE_BI__
# define FBEXT_FILE_CONSOLE_BI__ -1

# include once "ext/file/detail/common.bi"

'' Namespace: ext
namespace ext
    
    '' Class: Console_
    '' Class emulating the basic functionality of C#'s System.Console object.
    ''
    '' Notes:
    '' This object is threadsafe.
    type Console_
    
        public:
            declare constructor()
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
            declare sub m_oo()
            declare sub m_oi()
            m_filehandlei as integer
            m_filehandleo as integer
            m_lasterror as integer
        #ifdef FBEXT_MULTITHREADED
            m_mutex as any ptr
        #endif
    end type

    ''Namespace: console
    namespace console
        ''Function: ReadLine
        ''Retreives one full line of input from the console.
        ''
        declare function ReadLine() as string

        # macro fbext_realConsoleWrite_Declare(T_)
        :
            ''Sub: Write
            ''Overloaded to print any built-in type to the console without a line break afterwards.
            ''
            declare sub Write overload ( byref x as fbext_TypeName(T_) )
            
            ''Sub: WriteLine
            ''Overloaded to print any built-in type to the console followed by a line break.
            ''
            declare sub WriteLine overload ( byref x as fbext_TypeName(T_) )
        :
        # endmacro
        
        fbext_InstanciateMulti(fbext_realConsoleWrite, fbext_NumericTypes() (((string))) )
        
    end namespace

end namespace

# endif ' include guard
