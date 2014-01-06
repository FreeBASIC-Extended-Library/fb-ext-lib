'' Title: ext/preprocessor/seq/enum.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_ENUM_BI__
# define FBEXT_INCLUDED_PP_SEQ_ENUM_BI__ -1

# include once "ext/preprocessor/seq/foreachi.bi"
# include once "ext/preprocessor/punctuation/commaif.bi"
# include once "ext/preprocessor/logical/not.bi"
# include once "ext/preprocessor/arithmetic/sub.bi"

# define FBEXT_PP_SEQ_ENUM(seq) fbextPP_SeqEnum(seq)

'' Macro: fbextPP_SeqEnum
'' Enumerates the elements of a sequence.
''
'' Parameters:
'' seq - A sequence.
''
'' Returns:
'' The enumerated elements.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro will expand to
'' *a, b, c, d*.

# define fbextPP_SeqEnum(seq) _
         FBEXT_PP_SEQ_FOREACHI(fbextPP_SeqEnum__M, FBEXT_PP_DEC(FBEXT_PP_SEQ_SIZE(seq)), seq)

# define fbextPP_SeqEnum__M(lasti, i, elem) fbextPP_SeqEnum__M_I(elem, fbextPP_Not(FBEXT_PP_SUB(lasti, i)))
# define fbextPP_SeqEnum__M_I(elem, islast) fbextPP_SeqEnum__M##islast(elem)
# define fbextPP_SeqEnum__M0(elem) elem,
# define fbextPP_SeqEnum__M1(elem) elem

# endif ' include guard
