''Title: Home
''
''About: Getting Live Help
'' E-Mail - freebasic-extended-library-discussion@googlegroups.com
'' IRC - #freebasic-ext on FreeNode or http://webchat.freenode.net/?randomnick=1&channels=freebasic-ext
''
''
''About: ext.bi
''  All code should include only the headers it actually uses. Including
''  this file will output an error message at compile time.
''
''(start code)
''#include "ext/specific_header.bi"
''using ext
''(end code)
''
''About: Compile Times
''To reduce compile times when using Containers and other *header only* librarys use this code:
''
''(start code)
''#define fbext_NoBuiltinInstanciations() 1
''#include "SOME EXT HEADER"
''(end code)
''
''This will not produce the code for the Containers for the FB built-in types. If you
''wish to use one of the built-in types with the Container you must *Instanciate* it before usage.
''
''(start code)
''#define fbext_NoBuiltinInstanciations() 1
''#include once "ext/containers/stack.bi"
''
''fbext_Instanciate( fbExt_Stack, ((integer)) )
''(end code)
''More about <fbext_Stack>...
''
''About: EXE size
''To prevent linking to all external libraries you may define FBEXT_NO_EXTERNAL_LIBS as such:
''
''(start code)
''#define FBEXT_NO_EXTERNAL_LIBS -1
''#include "SOME EXT HEADER"
''using ext
''
''(end code)
''
'' Finer grained control of dependant libraries is also available. The relevant defines are:
'' FBEXT_NO_LIBZ - prevents dependancy on zlib, used by the internal PNG loader included as static library on Windows.
'' FBEXT_USE_ZLIB_DLL - set this if you want to use zlib1.dll instead of the included static zlib. (only affects Windows)
'' FBEXT_NO_LIBZIP - prevents dependancy on libzip, used to open Zip files.
'' FBEXT_NO_LIBGIF - prevents dependancy on libgif, used to load GIF images.
'' FBEXT_NO_LIBJPG - prevents dependancy on libjpeg, used to load JPG images.
'' FBEXT_NO_LIBFREETYPE - prevents dependancy on libfreetype, used to load TTF fonts.
''
''About: Threads
'' Classes marked Threadsafe will operate correctly when your code is compiled with the option -mt.
''
''About: Reporting Bugs
''Please report all bugs to the Issue tracker at http://code.google.com/p/fb-extended-lib/issues/list
''only after you have followed these steps:
'' * You can reproduce the bug.
'' * You are following the documentation.
'' * Please search for your issue to see if it has already been reported.
'' * Please check the latest Dev release to see if your bug has already been fixed.
''
''You will need the following information to fill out the bug report:
'' * Ext version (Mercurial revision number, Dev release date or Stable version number).
'' * FreeBASIC Compiler version (fbc -version)
'' * Your Operating System Name and Version
'' * A Google Account (available for free)
''
''Please read http://freecode.com/articles/how-to-report-bugs-effectively before reporting issues.
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''http://code.google.com/p/fb-extended-lib
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
#error "Warning: ext/ext.bi is deprecated. You should include the specific headers you want instead."
