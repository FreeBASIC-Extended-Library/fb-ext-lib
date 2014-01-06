'' Title: ext/preprocessor/seq/cat.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_CAT_BI__
# define FBEXT_INCLUDED_PP_SEQ_CAT_BI__ -1

# include once "ext/preprocessor/tuple/elem.bi"
# include once "ext/preprocessor/tuple/remparens.bi"
# include once "ext/preprocessor/seq/foldleft.bi"
# include once "ext/preprocessor/seq/head.bi"
# include once "ext/preprocessor/seq/tail.bi"
# include once "ext/preprocessor/control/iif.bi"
# include once "ext/preprocessor/control/if.bi"
# include once "ext/preprocessor/arithmetic/inc.bi"
# include once "ext/preprocessor/comparison/equal.bi"

'' Macro: fbextPP_SeqCat
''  expands to a concatenation of all of the elements in the sequence
''  *seq*.
''
''  For example, if *seq* is `(a)(b)(c)(d)`, then this macro expands to
''  `abcd`.
# define fbextPP_SeqCat(seq) _
    fbextPP_If(fbextPP_Dec(fbextPP_SeqSize(seq)), _
        fbextPP_SeqCat_Multi, _
        fbextPP_SeqCat_Single _
    )(seq)

# define fbextPP_SeqCat_Multi(seq) _
    FBEXT_PP_SEQ_FOLDLEFT(fbextPP_SeqCat_O, FBEXT_PP_SEQ_HEAD(seq), FBEXT_PP_SEQ_TAIL(seq))

# define fbextPP_SeqCat_Single(seq) fbextPP_SeqHead(seq)

# define fbextPP_SeqCat_O(state_, elem_) state_##elem_

'' Macro: FBEXT_PP_SEQ_CAT
''  is deprecated, use fbextPP_SeqCat instead.
# define FBEXT_PP_SEQ_CAT(seq) _
    fbextPP_SeqCat(seq)

'' Macro: fbextPP_SeqCatWithGlue
''  expands to the concatenation of all of the elements of the sequence *seq*,
''  joined together by *glue*.
''
''  For example, if *seq* is `(a)(b)(c)(d)` and *glue* is `:`, then this macro
''  expands to `a:b:c:d`
# define fbextPP_SeqCatWithGlue(seq, glue) _
    FBEXT_PP_TUPLE_ELEM(2, 0, FBEXT_PP_SEQ_FOLDLEFT(fbextPP_SeqCatWithGlue_O, (FBEXT_PP_SEQ_HEAD(seq), glue), FBEXT_PP_SEQ_TAIL(seq)))

# define fbextPP_SeqCatWithGlue_O(state_, elem_) _
    fbextPP_SeqCatWithGlue_O_I(FBEXT_PP_TUPLE_REMPARENS(2, state_), elem_)

# define fbextPP_SeqCatWithGlue_O_I(result_, glue_, elem_) ( result_##glue_##elem_, glue_ )

# define FBEXT_PP_SEQ_CATWITHGLUE(seq, glue) fbextPP_SeqCatWithGlue(seq, glue)

# endif ' include guard
