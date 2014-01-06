'' Title: ext/preprocessor/control/expriif.bi
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
# ifndef FBEXT_INCLUDED_PP_CONTROL_EXPRIIF_BI__
# define FBEXT_INCLUDED_PP_CONTROL_EXPRIIF_BI__ -1

# include once "ext/preprocessor/control/iif.bi"

# define FBEXT_PP_EXPRIIF(bit, expr) fbextPP_ExprIif(bit, expr)

'' Macro: fbextPP_ExprIif
# define fbextPP_ExprIif(bit, expr) _fbextPP_ExprIif_I(bit, expr)

# define _fbextPP_ExprIif_I(bit, expr) _fbextPP_ExprIif_##bit(expr)
# define _fbextPP_ExprIif_0(expr)
# define _fbextPP_ExprIif_1(expr) expr

# endif ' include guard
