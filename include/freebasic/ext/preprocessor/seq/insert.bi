'' Title: ext/preprocessor/seq/insert.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_INSERT_BI__
# define FBEXT_INCLUDED_PP_SEQ_INSERT_BI__ -1

#include once "ext/preprocessor/seq/firstn.bi"
#include once "ext/preprocessor/seq/restn.bi"
#include once "ext/preprocessor/facilities/empty.bi"
#include once "ext/preprocessor/control/if.bi"
#include once "ext/preprocessor/tuple/eat.bi"
#include once "ext/preprocessor/cat.bi"

# define FBEXT_PP_SEQ_INSERT(seq, i, elem) fbextPP_SeqInsert(seq, i, elem)

'' Macro: fbextPP_SeqInsert
'' Inserts an element before a certain position in a sequence.
''
'' Parameters:
'' seq - A sequence.
'' i - The zero-based position in the sequence to insert the element.
'' elem - The element to insert.
''
'' Returns:
'' The new sequence.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)* and *i* 2, this macro willl expand to
'' *(a)(b)(x)(c)(d)*.
# define fbextPP_SeqInsert(seq, i, elem) _
         FBEXT_PP_CAT(FBEXT_PP_IF(i, FBEXT_PP_SEQ_FIRSTN, fbextPP_TupleEat__2)(i, seq)(elem), FBEXT_PP_SEQ_RESTN(i, seq))

# endif ' include guard
