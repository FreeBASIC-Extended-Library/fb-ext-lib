'' Title: ext/preprocessor/seq/transform.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_TRANSFORM_BI__
# define FBEXT_INCLUDED_PP_SEQ_TRANSFORM_BI__ -1

# include once "ext/preprocessor/seq/foldleft.bi"
# include once "ext/preprocessor/tuple/remparens.bi"
# include once "ext/preprocessor/tuple/elem.bi"
# include once "ext/preprocessor/seq/tail.bi"

# define FBEXT_PP_SEQ_TRANSFORM(m, data, seq) fbextPP_SeqTransform(m, data, seq)

'' Macro: fbextPP_SeqTransform
'' Transforms the elements of a sequence.
''
'' Parameters:
'' m - A user-defined macro that is called for every element in the sequence.
'' It has the form *m(data, elem)*, where *data* is auxilliary data passed to
'' fbextPP_SeqTransform, and *elem* is the current element. This macro
'' should return a new element.
'' data - Auxilliary data that is passed to the user-defined tranformation
'' macro.
'' seq - The sequence to transform.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro will expand to
'' *(m(data, a)) (m(data, b)) (m(data, c)) (m(data, d))*.
''
'' Example:
'' (start code)
'' # include once "ext/preprocessor/seq/transform.bi"
''
'' # define SEQ (5)(3)(1)(4)
'' # define M(data, elem) FBEXT_PP_INC(elem)
''
'' # define RESULT FBEXT_PP_SEQ_TRANFORM(M, __, SEQ)
'' ' RESULT is defined as (6)(4)(2)(5)
'' (end code)
# define fbextPP_SeqTransform(m, data, seq) _
    FBEXT_PP_SEQ_TAIL(FBEXT_PP_TUPLE_ELEM(3, 2, FBEXT_PP_SEQ_FOLDLEFT(fbextPP_SeqTransform_O, (m, data, (__)), seq)))

# define fbextPP_SeqTransform_I(primer_elem)

# define fbextPP_SeqTransform_O(state, oldelem) _
    fbextPP_SeqTransform_O_I(FBEXT_PP_TUPLE_REMPARENS(3, state), oldelem)

# define fbextPP_SeqTransform_O_I(m, data, result, oldelem) _
    (m, data, result(m(data, oldelem)))

# define fbextPP_SeqTransform_O_II(result, newelem) result##newelem

# endif ' include guard
