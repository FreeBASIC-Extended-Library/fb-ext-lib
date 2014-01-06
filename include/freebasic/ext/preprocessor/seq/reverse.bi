'' Title: ext/preprocessor/seq/reverse.bi
''  This file is part of the <ext/Preprocessor> library API, and can be
''  directly included by user programs.
''
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''  Copyright (c) 2002, Paul Mensonides
''
''  Distributed under the Boost Software License, Version 1.0. See
''  accompanying file LICENSE_1_0.txt or copy at
''  http://www.boost.org/LICENSE_1_0.txt)
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_INCLUDED_PP_SEQ_REVERSE_BI__
# define FBEXT_INCLUDED_PP_SEQ_REVERSE_BI__ -1

#include once "ext/preprocessor/seq/foldright.bi"
#include once "ext/preprocessor/facilities/empty.bi"

# define FBEXT_PP_SEQ_REVERSE(seq) fbextPP_SeqReverse(seq)

'' Macro: fbextPP_SeqReverse
'' Reverses the elements of a sequence.
''
'' Parameters:
'' seq - A sequence.
''
'' Returns:
'' Returns the reversed sequence.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro expands to
'' *(d)(c)(b)(a)*.
# define fbextPP_SeqReverse(seq) _
         FBEXT_PP_SEQ_FOLDRIGHT( _
         	fbextPP_SeqReverse__M, _
         	FBEXT_PP_EMPTY(), _
         	seq)

# define fbextPP_SeqReverse__M(state, elem) state(elem)

# endif ' include guard
