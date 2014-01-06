'' Title: ext/preprocessor/comparison/equal.bi
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
# ifndef FBEXT_INCLUDED_PP_EQUAL_BI__
# define FBEXT_INCLUDED_PP_EQUAL_BI__ -1

# include once "ext/preprocessor/logical/and.bi"
# include once "ext/preprocessor/logical/not.bi"
# include once "ext/preprocessor/arithmetic/sub.bi"

'' Macro: fbextPP_Equal
''  expands to `1` if *a* and *b* compare equal, otherwise it expands to `0`.
''  *a* and *b* must be integer literals in the range [0, 255], inclusive.
# define fbextPP_Equal(a, b) _
    fbextPP_And(                                _
        fbextPP_Not(fbextPP_Sub(b, a)),         _
        fbextPP_Not(fbextPP_Sub(a, b))          _
    )                                           _
    ''

'' Macro: FBEXT_PP_EQUAL
''  is deprecated. Use <fbextPP_Equal> instead.
# define FBEXT_PP_EQUAL(a, b) fbextPP_Equal(a, b)

# endif ' include guard
