'' Title: ext/preprocessor/seq/foreachi.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_FOREACHI_BI__
# define FBEXT_INCLUDED_PP_SEQ_FOREACHI_BI__ -1

# include once "ext/preprocessor/repetition/repeat.bi"
# include once "ext/preprocessor/seq/size.bi"
# include once "ext/preprocessor/seq/head.bi"
# include once "ext/preprocessor/seq/elem.bi"

# define FBEXT_PP_SEQ_FOREACHI(m, data, seq) fbextPP_SeqForEachI(m, data, seq)

'' Macro: fbextPP_SeqForEachI
'' Expands a macro for every element in a sequence.
''
'' Parameters:
'' m - A user-defined macro that is called for every element in the sequence.
'' It has the form *m(data, i, elem)*, where *data* is auxilliary data passed
'' to fbextPP_SeqForEachI, *i* is the zero-based position of the current
'' element, and *elem* is the current element.
'' data - Auxilliary data that is passed to the user-defined macro.
'' seq - A sequence.
''
'' Returns:
'' User-defined.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro expands to
'' *m(data, 0, a) m(data, 1, b) m(data, 2, c) m(data, 3, d)*.
# define fbextPP_SeqForEachI(m, data, seq) _
	FBEXT_PP_REPEAT(FBEXT_PP_SEQ_SIZE(seq), fbextPP_SeqForEachI__M, (m)(data)(seq))

# define fbextPP_SeqForEachI__M(n, d) _
	FBEXT_PP_SEQ_HEAD(d)(FBEXT_PP_SEQ_ELEM(1, d), n, FBEXT_PP_SEQ_ELEM(n, FBEXT_PP_SEQ_ELEM(2, d)))

# endif ' include guard
