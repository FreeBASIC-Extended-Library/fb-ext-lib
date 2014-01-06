'' Title: ext/preprocessor/control/iif.bi
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
# ifndef FBEXT_INCLUDED_PP_CONTROL_IIF_BI__
# define FBEXT_INCLUDED_PP_CONTROL_IIF_BI__ -1

# define FBEXT_PP_IIF(c, t, f) fbextPP_Iif(c, t, f)

'' Macro: fbextPP_Iif
'' Expands one of two texts depending on a boolean condition.
''
'' Parameters:
'' c - A boolean condition, having a value of false (0) or true (1).
'' t - the text to expand if *c* is true.
'' f - the text to expand if *c* is false.
''
'' Returns:
'' One of the two texts.
# define fbextPP_Iif(c, t, f) _
	fbextPP_Iif__##c(t, f)

# define fbextPP_Iif__0(t, f) f
# define fbextPP_Iif__1(t, f) t

# endif ' include guard
