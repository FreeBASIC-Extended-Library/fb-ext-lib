'' Title: ext/preprocessor/array/size.bi
''
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''  Copyright (c) 2002, Paul Mensonides
''
''  Distributed under the Boost Software License, Version 1.0. See
''  accompanying file LICENSE_1_0.txt or copy at
''  http://www.boost.org/LICENSE_1_0.txt)
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_INCLUDED_PP_ARRAY_SIZE_BI__
# define FBEXT_INCLUDED_PP_ARRAY_SIZE_BI__ -1

#include once "ext/preprocessor/tuple/elem.bi"

# define FBEXT_PP_ARRAY_SIZE(array) fbextPP_ArraySize(array)

'' Macro: fbextPP_ArraySize
'' Returns the size, in elements, of an array.
''
'' Parameters:
'' array - An array.
''
'' Returns:
'' Returns the size, in elements, of an array.
''
'' Description:
'' Given an array *(4, (a, b, c, d))*, this macro will expand to
'' *4*.
# define fbextPP_ArraySize(array) fbextPP_TupleElem(2, 0, array)

# endif ' include guard
