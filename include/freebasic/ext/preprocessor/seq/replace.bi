'' Title: ext/preprocessor/seq/replace.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_REPLACE__BI__
# define FBEXT_INCLUDED_PP_SEQ_REPLACE__BI__ -1

# define fbextPP_SeqReplace(seq, index, value) _
    FBEXT_PP_SEQ_TAIL(FBEXT_PP_TUPLE_ELEM(4, 3,         _
        FBEXT_PP_SEQ_FOLDLEFT(                          _
            _fbextPP_SeqReplace_O,                      _
            (0, index, value, (:)),                     _
            seq                                         _
        )                                               _
    ))                                                  _
    ''

# define _fbextPP_SeqReplace_O(state_, elem_) _fbextPP_SeqReplace_O_I(FBEXT_PP_TUPLE_REMPARENS(4, state_), elem_)
# define _fbextPP_SeqReplace_O_I(current_, target_, value_, result_, elem_) _
    ( _
        FBEXT_PP_INC(current_),                         _
        target_,                                        _
        value_,                                         _
        FBEXT_PP_IIF(fbextPP_Equal(current_, target_),  _
            result_(value_),                            _
            result_(elem_)                              _
        )                                               _
    )                                                   _

# define FBEXT_PP_SEQ_REPLACE(seq, index, value) _
    fbextPP_SeqReplace(seq, index, value)

# endif ' include guard
