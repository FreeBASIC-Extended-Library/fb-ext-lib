'' Title: ext/preprocessor/seq/restn.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_RESTN_BI__
# define FBEXT_INCLUDED_PP_SEQ_RESTN_BI__ -1

#include once "ext/preprocessor/tuple/elem.bi"
#include once "ext/preprocessor/arithmetic/inc.bi"
#include once "ext/preprocessor/facilities/empty.bi"
#include once "ext/preprocessor/seq/foldleft.bi"
#include once "ext/preprocessor/seq/split.bi"
#include once "ext/preprocessor/cat.bi"

# define FBEXT_PP_SEQ_RESTN(n, seq) fbextPP_SeqRestN(n, seq)

'' Macro: fbextPP_SeqRestN
'' Removes a number of leading elements from a sequence.
''
'' Parameters:
'' n - The number of leading elements to remove.
'' seq - A sequence.
''
'' Returns:
'' The cropped sequence.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)* and *n* 2, this macro will expand to
'' *(c)(d)*.
# define fbextPP_SeqRestN(n, seq) _
         FBEXT_PP_SEQ_FOLDLEFT( _
         	fbextPP_SeqRestN__M, _
         	FBEXT_PP_EMPTY(), _
         	FBEXT_PP_CAT(fbextPP_TupleElem__2__1, FBEXT_PP_SEQ_SPLIT(FBEXT_PP_INC(n), (__)seq)) _
         )

# define fbextPP_SeqRestN__M(state, elem) state##(elem)

# endif ' include guard
