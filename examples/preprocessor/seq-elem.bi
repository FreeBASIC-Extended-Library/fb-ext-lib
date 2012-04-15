''File: seq-elem.bi
''Description: Demonstration of sequence element preprocessor macros.
''
''Copyright (c) 2007 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/preprocessor/seq/elem.bi"

# define SEQ (byte)(short)(integer)(longint)

# print FBEXT_PP_SEQ_ELEM(0, SEQ) ' byte
# print FBEXT_PP_SEQ_ELEM(1, SEQ) ' short
# print FBEXT_PP_SEQ_ELEM(2, SEQ) ' integer
# print FBEXT_PP_SEQ_ELEM(3, SEQ) ' longint
