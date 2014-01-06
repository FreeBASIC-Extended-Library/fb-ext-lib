'' Title: ext/preprocessor/seq/foreach.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_FOREACH_BI__
# define FBEXT_INCLUDED_PP_SEQ_FOREACH_BI__ -1

# include once "ext/preprocessor/repetition/repeat.bi"
# include once "ext/preprocessor/seq/size.bi"
# include once "ext/preprocessor/seq/head.bi"
# include once "ext/preprocessor/seq/elem.bi"
# include once "ext/preprocessor/tuple/remparens.bi"

'' Macro: fbextPP_SeqForEach
''  expands to repeated expansions of the user-defined macro *m_*, passing them
''  each element of the sequence *seq_*, in order, along with user data *data_*.
''
''  *m_* must have the form `foo(data_, elem_)`, where `data_` is the
''  user-defined *data_*, and `elem_` is one of the elements in *seq_*.
''
''  For example, if *data_* is `x` and *seq_* is `(a)(b)(c)(d)`, then this
''  macro expands to `m_(x, a) m_(x, b) m_(x, c) m_(x, d)`.
# define fbextPP_SeqForEach(m_, data_, seq_) _
	fbextPP_Repeat(fbextPP_SeqSize(seq_), fbextPP_SeqForEach_M, (m_, data_, seq_))

# define fbextPP_SeqForEach_M(elemidx_, m_data_seq_) _
    fbextPP_SeqForEach_M_I(elemidx_, fbextPP_TupleRemParens(3, m_data_seq_))

# define fbextPP_SeqForEach_M_I(elemidx_, m_, data_, seq_) _
    m_(data_, fbextPP_SeqForEach_M_II(elemidx_, seq_))

# define fbextPP_SeqForEach_M_II(elemidx_, seq_) _
    fbextPP_SeqElem(elemidx_, seq_)

'' Macro: FBEXT_PP_SEQ_FOREACH
''  is deprecated, use <fbextPP_SeqForEach> instead.
# define FBEXT_PP_SEQ_FOREACH(m_, data_, seq_) _
    fbextPP_SeqForEach(m_, data_, seq_)

# endif ' include guard
