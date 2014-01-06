'' Title: ext/preprocessor/seq/firstn.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_FIRSTN_BI__
# define FBEXT_INCLUDED_PP_SEQ_FIRSTN_BI__ -1

# include once "ext/preprocessor/tuple/elem.bi"
# include once "ext/preprocessor/seq/head.bi"
# include once "ext/preprocessor/seq/split.bi"
# include once "ext/preprocessor/seq/restn.bi"
# include once "ext/preprocessor/facilities/empty.bi"
# include once "ext/preprocessor/seq/foldleft.bi"
# include once "ext/preprocessor/cat.bi"

# define FBEXT_PP_SEQ_FIRSTN(n, seq) fbextPP_SeqFirstN(n, seq)

'' Macro: fbextPP_SeqFirstN
''  expands to a sequence of the first *n* number of elements of the sequence
''  *seq*.
''
'' Example:
'' (start code)
'' # include "ext/preprocessor/seq/firstn.bi"
'' # include "ext/preprocessor/stringize.bi"
''
'' # define SEQ (a)(b)(c)(d)
''
'' ' Expands to "(a)(b)(c)"
'' # print FBEXT_PP_STRINGIZE(fbextPP_SeqFirstN(3, SEQ))
'' (end code)
# define fbextPP_SeqFirstN(n, seq) _
         FBEXT_PP_SEQ_FOLDLEFT( _
         	fbextPP_SeqFirstN__M, _
         	FBEXT_PP_EMPTY(), _
         	FBEXT_PP_CAT(fbextPP_TupleElem__2__0, FBEXT_PP_SEQ_SPLIT(n, seq(__))) _
         )

# define fbextPP_SeqFirstN__M(state, elem) state##(elem)

# endif ' include guard
