'' Title: ext/preprocessor/comparison/lessthan.bi
''  This file is part of the <ext/Preprocessor> library API, and can be
''  directly included by user programs.
'' 
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''  Copyright (c) 2001, Housemarque Oy (http://www.housemarque.com)
'' 
''  Distributed under the Boost Software License, Version 1.0. See
''  accompanying file LICENSE_1_0.txt or copy at
''  http://www.boost.org/LICENSE_1_0.txt)
'' 
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_INCLUDED_PP_LESSTHAN_BI__
# define FBEXT_INCLUDED_PP_LESSTHAN_BI__ -1

# include once "ext/preprocessor/logical/and.bi"
# include once "ext/preprocessor/logical/not.bi"
# include once "ext/preprocessor/arithmetic/sub.bi"

# define fbextPP_LessThan(a, b) _
    fbextPP_And(                                _
        fbextPP_Sub(b, a),                      _
        fbextPP_Not(fbextPP_Sub(a, b))          _
    )                                           _
    ''

# define FBEXT_PP_LESSTHAN(a, b) fbextPP_LessThan(a, b)

# endif ' include guard
