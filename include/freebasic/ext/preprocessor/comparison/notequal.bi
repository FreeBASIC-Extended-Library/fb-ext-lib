'' Title: ext/preprocessor/comparison/notequal.bi
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
# ifndef FBEXT_INCLUDED_PP_NOTEQUAL_BI__
# define FBEXT_INCLUDED_PP_NOTEQUAL_BI__ -1

# include once "ext/preprocessor/comparison/equal.bi"

'' Macro: fbextPP_NotEqual
''  expands to `1` if *a* and *b* do not compare equal, otherwise it expands to
''  `0`. *a* and *b* must be integer literals in the range [0, 255], inclusive.
# define fbextPP_NotEqual(a, b) _
    fbextPP_Not(fbextPP_Equal(a, b))

'' Macro: FBEXT_PP_NOTEQUAL
''  is deprecated, use <fbextPP_NotEqual> instead.
# define FBEXT_PP_NOTEQUAL(a, b) fbextPP_NotEqual(a, b)

# endif ' include guard
