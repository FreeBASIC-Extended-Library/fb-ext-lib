#include once "ext/log.bi"
using ext

sub my_custom_log( byval l as loglevel, byref m as const string, byref f as const string, byval l_ as integer, byval fd as any ptr )
    print m
end sub

enum MyChannels
    MAIN_C = 0
    FILE_C
    CUST_C
end enum

if not setNumberOfLogChannels(3) then 'gives us channel 0, 1 and 2

    setLogMethod(FILE_C,LOG_FILE) 'direct log channel 2 output to a file, should be writable by the process or will silently fail
    setLogLevel(FILE_C,_WARN) 'The default level is INFO, only print this level and above
    setLogMethod(CUST_C,LOG_CUSTOM,@my_custom_log) 'change it up a bit

    INFO("This is a test log message.") 'print this one
    DEBUG("This is a test debug message.") 'debug not printed by default
    INFOto(FILE_C,"This is also a test log message.") 'not printed
    WARNto(FILE_C,"Only one entry should be written to the log.") 'printed
    WARNto(CUST_C,"Whoa dude, we can do anything with this!") 'whoa!

end if
