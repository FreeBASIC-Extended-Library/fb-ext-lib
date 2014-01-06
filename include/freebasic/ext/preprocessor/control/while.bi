'' Title: ext/preprocessor/control/while.bi
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
# ifndef FBEXT_INCLUDED_PP_CONTROL_WHILE_BI__
# define FBEXT_INCLUDED_PP_CONTROL_WHILE_BI__ -1

# include once "ext/preprocessor/struct.bi"
# include once "ext/preprocessor/repetition/for.bi"
# include once "ext/preprocessor/seq/elem.bi"
# include once "ext/preprocessor/seq/size.bi"
# include once "ext/preprocessor/arithmetic/dec.bi"

# define fbextPP_While(pred, op, state) _
    _fbextPP_While_aux( (state) fbextPP_For(                            _
        (pred, op, state),                                              _
        _fbextPP_While_P,                                               _
        _fbextPP_While_O,                                               _
        _fbextPP_While_M                                                _
    ))

# define _fbextPP_While_aux(states) fbextPP_SeqElem(fbextPP_Dec(fbextPP_SeqSize(states)), states)

# define _fbextPP_While_P(r, ws) _fbextPP_While_P_aux(r, fbextPP_TupleRemParens(3, ws))
# define _fbextPP_While_O(r, ws) _fbextPP_While_O_aux(r, fbextPP_TupleRemParens(3, ws))
# define _fbextPP_While_M(r, ws) _fbextPP_While_M_aux(r, fbextPP_TupleRemParens(3, ws))

# define _fbextPP_While_P_aux(r, pred, op, state) pred(r, state)
# define _fbextPP_While_O_aux(r, pred, op, state) (pred, op, op(r, state))
# define _fbextPP_While_M_aux(r, pred, op, state) (op(r, state))

# endif ' include guard
