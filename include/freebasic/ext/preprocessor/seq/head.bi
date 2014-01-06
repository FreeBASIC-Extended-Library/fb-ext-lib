'' Title: ext/preprocessor/seq/head.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_HEAD_BI__
# define FBEXT_INCLUDED_PP_SEQ_HEAD_BI__ -1

#include once "ext/preprocessor/seq/split.bi"
#include once "ext/preprocessor/tuple/elem.bi"
#include once "ext/preprocessor/cat.bi"

# define FBEXT_PP_SEQ_HEAD(seq) fbextPP_SeqHead(seq)

'' Macro: fbextPP_SeqHead
'' Returns the first element in a sequence.
''
'' Parameters:
'' seq - A sequence.
''
'' Returns:
'' The first element in the sequence.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro will expand to
'' *a*.
# define fbextPP_SeqHead(seq) _
         FBEXT_PP_CAT(fbextPP_SeqHead__F, FBEXT_PP_CAT(fbextPP_TupleElem__2__0, FBEXT_PP_SEQ_SPLIT(1, seq(__))))

# define fbextPP_SeqHead__F(x) x

# endif ' include guard
