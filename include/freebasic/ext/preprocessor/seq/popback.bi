'' Title: ext/preprocessor/seq/popback.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_POPBACK_BI__
# define FBEXT_INCLUDED_PP_SEQ_POPBACK_BI__ -1

#include once "ext/preprocessor/seq/firstn.bi"
#include once "ext/preprocessor/seq/size.bi"
#include once "ext/preprocessor/arithmetic/dec.bi"

# define FBEXT_PP_SEQ_POPBACK(seq) fbextPP_SeqPopBack(seq)

'' Macro: fbextPP_SeqPopBack
'' Removes the last element of a sequence.
''
'' Parameters:
'' seq - A sequence.
''
'' Returns:
'' The new sequence.
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro will expand to
'' *(a)(b)(c)*.

# define fbextPP_SeqPopBack(seq) FBEXT_PP_SEQ_FIRSTN(FBEXT_PP_DEC(FBEXT_PP_SEQ_SIZE(seq)), seq)

# endif ' include guard
