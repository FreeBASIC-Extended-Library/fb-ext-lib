'' Title: ext/preprocessor/seq/pushfront.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_PUSHFRONT_BI__
# define FBEXT_INCLUDED_PP_SEQ_PUSHFRONT_BI__ -1

# define FBEXT_PP_SEQ_PUSHFRONT(seq, elem) fbextPP_SeqPushFront(seq, elem)

'' Macro: fbextPP_SeqPushFront
'' Adds an element to the beginning of a sequence.
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
'' *(x)(a)(b)(c)(d)*.
# define fbextPP_SeqPushFront(seq, x) (x)##seq

# endif ' include guard
