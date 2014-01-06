'' Title: ext/preprocessor/seq/foldright.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_FOLDRIGHT_BI__
# define FBEXT_INCLUDED_PP_SEQ_FOLDRIGHT_BI__ -1

# include once "ext/preprocessor/seq/foreachi.bi"
# include once "ext/preprocessor/repetition/repeat.bi"
# include once "ext/preprocessor/seq/size.bi"
# include once "ext/preprocessor/seq/elem.bi"
# include once "ext/preprocessor/arithmetic/sub.bi"
# include once "ext/preprocessor/arithmetic/inc.bi"

# define FBEXT_PP_SEQ_FOLDRIGHT(op, state, seq) fbextPP_SeqFoldRight(op, state, seq)

'' Macro: fbextPP_SeqFoldRight
'' Expands a macro returning a new state for each element in a sequence.
''
'' Parameters:
'' op - A procedure macro of the form *op(state, elem)*, where *state* is the
'' current state, and *elem* is the current sequence element. This macro should
'' return a new state.
'' state - The initial state of the fold.
'' seq - A sequence.
''
'' Returns:
'' The final state.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro will expand to
'' *op(op(op(op(state, d), c), b), a)*.
# define fbextPP_SeqFoldRight(op, state, seq) _
	FBEXT_PP_REPEAT(FBEXT_PP_SEQ_SIZE(SEQ), fbextPP_SeqFoldRight__L, op) state FBEXT_PP_SEQ_FOREACHI(fbextPP_SeqFoldRight__R, seq, seq)

# define fbextPP_SeqFoldRight__L(__, op) op(

# define fbextPP_SeqFoldRight__R(seq, i, elem) , FBEXT_PP_SEQ_ELEM(FBEXT_PP_SUB(FBEXT_PP_SEQ_SIZE(seq), FBEXT_PP_INC(i)), seq))

# endif
