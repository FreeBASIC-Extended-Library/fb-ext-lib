'' Title: ext/preprocessor/control/if.bi
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
# ifndef FBEXT_INCLUDED_PP_CONTROL_IF_BI__
# define FBEXT_INCLUDED_PP_CONTROL_IF_BI__ -1

# include once "ext/preprocessor/control/iif.bi"
# include once "ext/preprocessor/logical/bool.bi"

# define FBEXT_PP_IF(c, t, f) fbextPP_If(c, t, f)

'' Macro: fbextPP_If
'' Expands one of two texts depending on a numeric condition.
''
'' Parameters:
'' c - A number. This number is converted to a boolean value. If this
'' conversion is not necessary, use <fbextPP_Iif> instead.
'' t - the text to expand if *c* is non-zero.
'' f - the text to expand if *c* is zero.
''
'' Returns:
'' One of the two texts.
# define fbextPP_If(c, t, f) _
	fbextPP_Iif(fbextPP_Bool(c), t, f)

# endif ' include guard
