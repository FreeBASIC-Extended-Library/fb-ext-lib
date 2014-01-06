'' Title: preprocessor/arithmetic/mul.bi
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
# ifndef FBEXT_INCLUDED_PP_MUL_BI__
# define FBEXT_INCLUDED_PP_MUL_BI__ -1

# include once "ext/preprocessor/repetition/repeat.bi"
# include once "ext/preprocessor/arithmetic/dec.bi"
# include once "ext/preprocessor/arithmetic/add.bi"

# define FBEXT_PP_MUL(lhs, rhs) fbextPP_Mul(lhs, rhs)

'' Macro: fbextPP_Mul
'' Multiplies two numbers together.
''
'' Parameters:
'' lhs - A number.
'' rhs - A number.
''
'' Returns:
'' The product of the two numbers.
# define fbextPP_Mul(lhs, rhs) _
	FBEXT_PP_REPEAT(FBEXT_PP_DEC(rhs), fbextPP_Mul__L, __) lhs FBEXT_PP_REPEAT(FBEXT_PP_DEC(rhs), fbextPP_Mul__R, lhs)

# define fbextPP_Mul__L(n, data) FBEXT_PP_ADD(

# define fbextPP_Mul__R(n, data) , data)

# endif ' include guard
