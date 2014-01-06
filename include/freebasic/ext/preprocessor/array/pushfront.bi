'' Title: ext/preprocessor/array/pushfront.bi
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
# ifndef FBEXT_INCLUDED_PP_ARRAY_PUSHFRONT_BI__
# define FBEXT_INCLUDED_PP_ARRAY_PUSHFRONT_BI__ -1

#include once "ext/preprocessor/array/size.bi"
#include once "ext/preprocessor/array/data.bi"
#include once "ext/preprocessor/tuple/remparens.bi"
#include once "ext/preprocessor/arithmetic/inc.bi"

# define FBEXT_PP_ARRAY_PUSHFRONT(array, index) fbextPP_ArrayPushFront(array, index)

'' Macro: fbextPP_ArrayPushFront
'' Adds an element to the beginning of an array.
''
'' Parameters:
'' array - An array.
'' elem - The element to add.
''
'' Returns:
'' The new array.
''
'' Description:
'' Given an array *(4, (a, b, c, d))*, this macro will expand to
'' *(5, (elem, a, b, c, d))*.
# define fbextPP_ArrayPushFront(array, elem) _
         fbextPP_ArrayPushFront__S(array, elem, FBEXT_PP_ARRAY_SIZE(array))

# define fbextPP_ArrayPushFront__S(array, elem, sz) _
         (FBEXT_PP_INC(sz), (elem, FBEXT_PP_TUPLE_REMPARENS(sz, FBEXT_PP_ARRAY_DATA(array))))

# endif ' include guard
