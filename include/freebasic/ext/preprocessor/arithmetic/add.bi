'' Title: preprocessor/arithmetic/add.bi
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
# ifndef FBEXT_INCLUDED_PP_ADD_BI__
# define FBEXT_INCLUDED_PP_ADD_BI__ -1

# include once "ext/preprocessor/repetition/repeat.bi"
# include once "ext/preprocessor/arithmetic/inc.bi"

# define FBEXT_PP_ADD(lhs, rhs) fbextPP_Add(lhs, rhs)

'' Macro: fbextPP_Add
''  Adds two numbers together.
''
'' Parameters:
''  lhs - A number.
''  rhs - A number.
''
'' Returns:
''  The sum of the two numbers.
# define fbextPP_Add(lhs, rhs) _
	FBEXT_PP_REPEAT(rhs, fbextPP_Add_L, __) lhs FBEXT_PP_REPEAT(rhs, fbextPP_Add_R, __)

# define fbextPP_Add_L(n, __) FBEXT_PP_INC(
# define fbextPP_Add_R(n, __) )

# endif ' include guard
