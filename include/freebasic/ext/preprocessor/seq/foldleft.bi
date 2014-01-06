'' Title: ext/preprocessor/seq/foldleft.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_FOLDLEFT_BI__
# define FBEXT_INCLUDED_PP_SEQ_FOLDLEFT_BI__ -1

# include once "ext/preprocessor/repetition/repeat.bi"
# include once "ext/preprocessor/seq/foreach.bi"
# include once "ext/preprocessor/seq/head.bi"
# include once "ext/preprocessor/seq/size.bi"
# include once "ext/preprocessor/seq/elem.bi"
# include once "ext/preprocessor/cat.bi"

# define FBEXT_PP_SEQ_FOLDLEFT(op, state, seq) fbextPP_SeqFoldLeft(op, state, seq)

'' Macro: fbextPP_SeqFoldLeft
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
'' *op(op(op(op(state, a), b), c), d)*.
''
'' Example:
'' (start code)
'' # include "ext/preprocessor/seq/foldleft.bi"
'' # include "ext/preprocessor/stringize.bi"
''
'' # define SEQ (a)(b)(c)(d)
'' # define OP(state, elem) state##elem
''
'' ' Expands to "xabcd"
'' # print FBEXT_PP_STRINGIZE(fbextPP_SeqFoldLeft(OP, x, SEQ))
'' (end code)
# define fbextPP_SeqFoldLeft(op, state, seq) _
	fbextPP_Repeat(fbextPP_SeqSize(seq), fbextPP_SeqFoldLeft__L, op) state fbextPP_Repeat(fbextPP_SeqSize(seq), fbextPP_SeqFoldLeft__R, seq)

# define fbextPP_SeqFoldLeft__L(__, op) op(

# define fbextPP_SeqFoldLeft__R(i , seq) , fbextPP_SeqElem(i, seq))

# endif
