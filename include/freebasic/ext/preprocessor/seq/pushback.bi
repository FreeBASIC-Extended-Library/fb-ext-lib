'' Title: ext/preprocessor/seq/pushback.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_PUSHBACK_BI__
# define FBEXT_INCLUDED_PP_SEQ_PUSHBACK_BI__ -1

# define FBEXT_PP_SEQ_PUSHBACK(seq, elem) fbextPP_SeqPushBack(seq, elem)

'' Macro: fbextPP_SeqPushBack
'' Adds an element to the end of a sequence.
''
'' Parameters:
'' seq - A sequence.
'' x - An element to add.
''
'' Returns:
'' The new sequence.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro will expand to
'' *(a)(b)(c)(d)(x)*.
# define fbextPP_SeqPushBack(seq, x) seq(x)

# endif ' include guard
