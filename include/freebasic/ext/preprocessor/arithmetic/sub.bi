'' Title: preprocessor/arithmetic/sub.bi
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
# ifndef FBEXT_INCLUDED_PP_SUB_BI__
# define FBEXT_INCLUDED_PP_SUB_BI__ -1

# include once "ext/preprocessor/repetition/repeat.bi"
# include once "ext/preprocessor/arithmetic/dec.bi"

# define FBEXT_PP_SUB(lhs, rhs) fbextPP_Sub(lhs, rhs)

'' Macro: fbextPP_Sub
'' Subtracts one number from another.
''
'' Parameters:
'' lhs - A number.
'' rhs - A number.
''
'' Returns:
'' The result of the subtraction.
# define fbextPP_Sub(lhs, rhs) _
	FBEXT_PP_REPEAT(rhs, fbextPP_Sub__L, __) lhs FBEXT_PP_REPEAT(rhs, fbextPP_Sub__R, __)

# define fbextPP_Sub__L(n, data) FBEXT_PP_DEC(

# define fbextPP_Sub__R(n, data) )

# endif ' include guard
