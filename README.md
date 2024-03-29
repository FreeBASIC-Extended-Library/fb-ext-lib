# Community
[Join us on Discord](https://discord.gg/fbq4amWest) in the #freebasic-ext channel.

# About
The FreeBASIC Extended Library is a set of general purpose and game oriented
libraries aimed to supply the community with high quailty functions and data
structures not provided by the stock FreeBASIC compiler and under a permissive 
license so anyone can use them. We (sir_mud, stylin and Dr_D)
started on this project back in 2007 and in that time the compiler and community
have changed and grown quite a bit. To enable generic code reuse we provide
a set of preprocessor macros which allow us to provide a template that is filled
in with the appropriate type at compile time which reduces the code size by not including 
"generic" containers for unused types.

We've separated the library into several modules for better code layout and library
size reduction. See all the modules here:
https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/tree/master/src/modules

## Project Status

* The FreeBASIC Compiler changed the preprocessor around the 1.0 release which
  caused some issues. The majority of issues in "everyday" code should be resolved.

* Currently the library only fully supports the 32bit FreeBASIC compiler. Some
  work on fully supporting the 64bit FreeBASIC compiler has been done and 
  large portions of the code will work in 64bit mode. 

* The documentation generator we used is not supported any longer and we are 
  evaluating replacements, in the mean time all documentation is built directly
  from the header files.

* Some of our APIs would benefit from some of the improvements that the newer
  compiler supports so we will be evaluating this and will update the TODO as needed.

## Note on Anti Virus Detections
Some anti virus programs like Microsoft Defender will flag some FreeBASIC compiled
programs as malware but it is a false detection. Samples have been uploaded to VirusTotal
and shared with AV vendors. Until a solution is found I would recommend all users
with security concerns to build from source.

## Building from Source
See [the HACKING file](HACKING)

## Dependencies

Some portions of the FreeBASIC Extended Library may depend on external
libraries in order to link properly. At this time, these libraries are:

	The FreeType Project (https://www.freetype.org/)
	zlib (https://www.zlib.net/)
	jpeg-turbo (https://www.libjpeg-turbo.org/)
	sqlite3 (https://www.sqlite.org/)
	giflib (https://sourceforge.net/projects/giflib/)
	pcre (https://sourceforge.net/projects/pcre/)
	libzip (https://libzip.org/)

Windows static libraries are included in the package and can be found
under <root>/bin/*.a. These static libraries must be placed either in the 
FreeBASIC lib/<platform> folder or inside your project and that directory 
passed to the FreeBASIC compiler with the `-p` flag.

Linux users will need to acquire the following packages (and their development
packages, when building the FreeBASIC Extended Library):

	libfreetype6
	libz1
	jpeg6
	sqlite3
	giflib v4 (may have to compile from source)
	libzip
	libpcre2
