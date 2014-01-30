#include once "ext/log.bi"
using ext

setLogMethod(0,LOG_FILE_XML)

INFO("This is an example of the logging module")
WARN("This should also work in a multithreaded environment.")

