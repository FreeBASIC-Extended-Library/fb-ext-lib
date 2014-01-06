'' Title: ext/preprocessor/control/exprif.bi
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
# ifndef FBEXT_INCLUDED_PP_CONTROL_EXPRIF_BI__
# define FBEXT_INCLUDED_PP_CONTROL_EXPRIF_BI__ -1

# include once "ext/preprocessor/control/expriif.bi"
# include once "ext/preprocessor/logical/bool.bi"

# define FBEXT_PP_EXPRIF(cond, expr) fbextPP_ExprIf(cond, expr)

'' Macro: fbextPP_ExprIf
# define fbextPP_ExprIf(cond, expr) fbextPP_ExprIif(FBEXT_PP_BOOL(cond), expr)

# endif ' include guard
