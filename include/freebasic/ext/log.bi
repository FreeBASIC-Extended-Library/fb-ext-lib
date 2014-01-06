''Title: log.bi
''
''About: About this Module
''The logging module is meant to be a very simple log that is also
''very capable. For basic usage absolutely no configuration is needed,
''just start using the DEBUG, INFO, WARN or FATAL logging macros.
''
''For an example showing how to use this module see https://code.google.com/p/fb-extended-lib/source/browse/examples/logging/log.bas
''or check your examples/logging directory.
''
''When using this module in a multithreaded environment all logging
''happens asynchronously in the background.
''
''About: Code License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
#ifndef __EXT_LOG_BI__
#define __EXT_LOG_BI__ -1

#include once "ext/detail/common.bi"

#if not __FB_MT__
    #inclib "ext-logging"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-logging.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

''Namespace: ext
namespace ext

''Enum: LOGLEVEL
''The different severities recognized by the logger.
''
''Values:
'' _DEBUG - This level is typically only important to developers debugging the program
'' _INFO - This level does not represent an error just important information.
'' _WARN - This level represents an error that the program was able to handle.
'' _FATAL - This level represents an unrecoverable error.
''
enum LOGLEVEL
    _DEBUG
    _INFO
    _WARN
    _FATAL
end enum

''Enum: LOG_METHODS
''The different actions the logger can take.
''
''Values:
''LOG_NULL - Do absolutely nothing.
''LOG_PRINT - Print the log message to the console.
''LOG_FILE - Write the log messages to a file, set with <setLogMethod>
''LOG_CUSTOM - Write your own logger function
enum LOG_METHODS
    LOG_NULL
    LOG_PRINT
    LOG_FILE
    LOG_CUSTOM
end enum

''Typedef: log_custom_sub
''The sub signature used by the LOG_CUSTOM logger.
''
''Parameters:
''l - the <LOGLEVEL> of the message
''_msg_ - the actual message
''_filen_ - the name of the file that the message is from
''_linen_ - the line number in _filen_ the message is from
''_data_ - arbitrary data
type log_custom_sub as sub( byval as LOGLEVEL, byref _msg_ as const string, byref _filen_ as const string, byval _linen_ as integer, byval _data_ as any ptr )

''Typedef: custom_data_free
''The sub signature used as the memory releaser for any passed data.
type custom_data_free as sub ( byval as any ptr )

''Function: setNumberOfLogChannels
''By default there is only one logging channel, however you can
''reserve more channels so that you may log different things to
''different places easily. Channels are numbered starting at 0 and
''you can request as many as 256 channels (which would be numbered 0 to 255)
''
''Parameters:
''c - the number of channels to reserve.
''
''Returns:
'' TRUE on error, invalid arg or memory allocation failure, existing channel(s) not changed on error
declare function setNumberOfLogChannels( byval c as uinteger ) as bool

''Sub: setLogMethod
''Set the log channel's method to use, must be one of <LOG_METHODS>.
''The default setting is LOG_PRINT.
''
''Parameters:
''c - *Optional* The log channel to change, can be completely omitted (comma and all) for default channel
''lm - the <LOG_METHODS> to use
''s - for LOG_FILE this is the filename (is optional, default is command(0).log, recommended to set to a writable file.), for LOG_CUSTOM this is the method to call *Not Used for other <LOG_METHODS>*
''fd - pointer for arbitrary data to be passed to the LOG_CUSTOM method.
''ff - function to be used to free custom data when logger is finalized.
declare sub setLogMethod overload ( byval as LOG_METHODS, byval as any ptr = 0, byval as any ptr = 0, byval as any ptr = 0 )
declare sub setLogMethod( byval channel as uinteger, _
                            byval as LOG_METHODS, _
                            byval func_or_filen as any ptr = 0, _
                            byval func_data as any ptr = 0, _
                            byval fdata_free as any ptr = 0 _
                            )

''Sub: setLogLevel
''Set the level that actions are taken at, any log messages lower than that level are ignored.
''The default level is _INFO.
''
''Parameters:
''c - *Optional* The logger channel to change, can be completely omitted (comma and all) for default channel
''l - <LOGLEVEL> that you wish to set as minimum.
declare sub setLogLevel overload ( byval as LOGLEVEL )
declare sub setLogLevel( byval channel as uinteger, byval as LOGLEVEL )

declare sub __log( byval as LOGLEVEL, _
            byref _msg_ as const string, _
            byref _file_ as const string, _
            byval _line_number_ as integer, _
            byval channel as uinteger = 0 _
            )

''Macro: DEBUG
''Send a DEBUG message to the default channel.
''
''Parameters:
''m - the message to send.
''
''Note:
''All messages must be a value that is either already a string or is able to be converted to a string, i.e. it has a cast() as string operator.
#define DEBUG(m) _LOG(_DEBUG,m,0)

''Macro: DEBUGto
''Send a DEBUG message to the specified channel.
''
''Parameters:
''c - the channel number to send to
''m - the message to send.
''
''Note:
''All messages must be a value that is either already a string or is able to be converted to a string, i.e. it has a cast() as string operator.
#define DEBUGto(c,m) _LOG(_DEBUG,m,(c))

''Macro: INFO
''Send a INFO message to the default channel.
''
''Parameters:
''m - the message to send.
''
''Note:
''All messages must be a value that is either already a string or is able to be converted to a string, i.e. it has a cast() as string operator.
#define INFO(m) _LOG(_INFO,m,0)

''Macro: INFOto
''Send a INFO message to the specified channel.
''
''Parameters:
''c - the channel number to send to
''m - the message to send.
''
''Note:
''All messages must be a value that is either already a string or is able to be converted to a string, i.e. it has a cast() as string operator.
#define INFOto(c,m) _LOG(_INFO,m,(c))

''Macro: WARN
''Send a WARN message to the default channel.
''
''Parameters:
''m - the message to send.
''
''Note:
''All messages must be a value that is either already a string or is able to be converted to a string, i.e. it has a cast() as string operator.
#define WARN(m) _LOG(_WARN,m,0)

''Macro: WARNto
''Send a WARN message to the specified channel.
''
''Parameters:
''c - the channel number to send to
''m - the message to send.
''
''Note:
''All messages must be a value that is either already a string or is able to be converted to a string, i.e. it has a cast() as string operator.
#define WARNto(c,m) _LOG(_WARN,m,(c))

''Macro: FATAL
''Send a FATAL message to the default channel.
''
''Parameters:
''m - the message to send.
''
''Note:
''All messages must be a value that is either already a string or is able to be converted to a string, i.e. it has a cast() as string operator.
#define FATAL(m) _LOG(_FATAL,m,0)

''Macro: FATALto
''Send a FATAL message to the specified channel.
''
''Parameters:
''c - the channel number to send to
''m - the message to send.
''
''Note:
''All messages must be a value that is either already a string or is able to be converted to a string, i.e. it has a cast() as string operator.
#define FATALto(c,m) _LOG(_FATAL,m,(c))

#define _LOG(l,m,c) ext.__log( ext.##l, (m), __FILE__, __LINE__, (c) )

end namespace

#endif
