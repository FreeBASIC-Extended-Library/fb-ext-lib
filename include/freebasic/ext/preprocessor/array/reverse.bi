'' Title: ext/preprocessor/array/reverse.bi
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
# ifndef FBEXT_INCLUDED_PP_ARRAY_REVERSE_BI__
# define FBEXT_INCLUDED_PP_ARRAY_REVERSE_BI__ -1

#include once "ext/preprocessor/array/size.bi"
#include once "ext/preprocessor/array/data.bi"
#include once "ext/preprocessor/tuple/reverse.bi"

# define FBEXT_PP_ARRAY_REVERSE(array, index) fbextPP_ArrayReverse(array, index)

'' Macro: fbextPP_ArrayReverse
'' Reverses the elements in an array.
''
'' Parameters:
'' array - An array.
''
'' Returns:
'' The new array.
''
'' Description:
'' Given an array *(4, (a, b, c, d))*, this macro will expand to
'' *(4, (d, c, b, a))*.
# define fbextPP_ArrayReverse(array) _
         ( _
         FBEXT_PP_ARRAY_SIZE(array), _
         FBEXT_PP_TUPLE_REVERSE(FBEXT_PP_ARRAY_SIZE(array), FBEXT_PP_ARRAY_DATA(array)) _
         )

# endif ' include guard
