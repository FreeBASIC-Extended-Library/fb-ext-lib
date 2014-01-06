'' Title: ext/preprocessor/punctuation/commaif.bi
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
# ifndef FBEXT_INCLUDED_PP_PUNCUATION_COMMAIF_BI__
# define FBEXT_INCLUDED_PP_PUNCUATION_COMMAIF_BI__ -1

# include once "ext/preprocessor/punctuation/comma.bi"
# include once "ext/preprocessor/facilities/empty.bi"
# include once "ext/preprocessor/control/if.bi"

# define FBEXT_PP_COMMAIF(c) fbextPP_CommaIf(c)

'' Macro: FBEXT_PP_COMMA
'' Expands to a comma (,) if a condition is met.
''
'' Parameters:
'' c - A numeric value that is converted to a boolean value.
''
'' Returns:
'' If *c* is true, this macro expands to a comma (,), otherwise it expands to
'' nothing.
# define fbextPP_CommaIf(c) _
         fbextPP_If(c, fbextPP_Comma, fbextPP_Empty)()

# endif ' include guard
