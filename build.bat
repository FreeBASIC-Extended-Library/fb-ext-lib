@echo off

set FBC=fbc.exe

set FBEXT_LIBNAME=ext
set FBEXT_LIBFILE=lib%FBEXT_LIBNAME%.a

set FBEXT_INCDIR=inc
set FBEXT_SRCDIR=src
set FBEXT_BINDIR=bin
set FBEXT_EXDIR=examples

set FBC_CFLAGS=-c -w pedantic -i %FBEXT_INCDIR%
set FBC_LFLAGS=-lib -x %FBEXT_BINDIR%\%FBEXT_LIBNAME%

if "%1"=="lib" goto lib:
if "%1"=="examples" goto examples:
if "%1"=="clean" goto clean:
if "%1"=="clean-examples" goto clean_examples:
if "%1"=="usage" goto usage:
goto usage:

:lib
	echo on
	
	:: compile source files
	@for /R %%s in (%FBEXT_SRCDIR%\*.bas) do %FBC% %FBC_CFLAGS% "%%s"
	
	:: link object files
	%FBC% %FBC_LFLAGS% "%FBEXT_SRCDIR%\*.o" "%FBEXT_SRCDIR%\fbpng\*.o" "%FBEXT_SRCDIR%\bits\*.o" "%FBEXT_SRCDIR%\container\*.o" "%FBEXT_SRCDIR%\conv\*.o" "%FBEXT_SRCDIR%\gfx\*.o" "%FBEXT_SRCDIR%\hash\*.o" "%FBEXT_SRCDIR%\math\*.o" "%FBEXT_SRCDIR%\sort\*.o" "%FBEXT_SRCDIR%\stringex\*.o" "%FBEXT_SRCDIR%\strings\*.o"
	
	@goto end:

:examples
	echo on
	@if not exist %FBEXT_BINDIR%\%FBEXT_LIBFILE% goto lib:
	@for /R %FBEXT_EXDIR% %%s in (*.bas) do %FBC% -i %FBEXT_INCDIR% -p %FBEXT_BINDIR% -l %FBEXT_LIBNAME% "%%s"
	@goto end:

:clean
	echo on
	del /Q "%FBEXT_BINDIR%\%FBEXT_LIBFILE%"  2> NUL
	del /Q "%FBEXT_SRCDIR%\*.o" 2> NUL
	@goto end:

:clean_examples
	echo on
	del /Q /S "%FBEXT_EXDIR%\*.exe"  2> NUL
	@goto end:

:usage
	@echo off
	echo "usage: BUILD.BAT [lib|examples|clean|clean-examples]"
	echo.
	echo    Running BUILD.BAT with no commandline arguments displays this help
	echo    text. One of the following options can be specified:
	echo.
	echo    lib              - builds the %FBEXT_LIBNAME% static library. the
	echo                       library will be placed in %FBEXT_BINDIR%.
	echo    examples         - builds the example programs, which can be found
	echo                       in %FBEXT_EXDIR%. if the the %FBEXT_LIBNAME%
	echo                       static library has not been built, it will be.
	echo    clean            - removes the %FBEXT_LIBNAME% static library.
	echo    clean-examples   - removes the examples programs.
	echo.

:end
