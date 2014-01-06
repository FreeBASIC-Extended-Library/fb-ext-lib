'' Title: ext/preprocessor/comparison/greaterthan.bi
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
# ifndef FBEXT_INCLUDED_PP_GREATERTHAN_BI__
# define FBEXT_INCLUDED_PP_GREATERTHAN_BI__ -1

# include once "ext/preprocessor/comparison/lessthan.bi"

'' Macro: fbextPP_GreaterThan
''  expands to `1` if *a* compares greater than or equal to *b*, otherwise it
''  expands to `0`.  *a* and *b* must be integer literals in the range
''  fbextPP_INTMIN through fbextPP_INTMAX, inclusive.
# define fbextPP_GreaterThan(a, b) _
    fbextPP_LessThan(b, a)

'' Macro: FBEXT_PP_GREATERTHAN
''  is deprecated. Use <fbextPP_GreaterThan> instead.
# define FBEXT_PP_GREATERTHAN(a, b) fbextPP_GreaterThan(a, b)

# endif ' include guard
