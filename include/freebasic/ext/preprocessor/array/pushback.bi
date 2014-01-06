'' Title: ext/preprocessor/array/pushback.bi
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
# ifndef FBEXT_INCLUDED_PP_ARRAY_PUSHBACK_BI__
# define FBEXT_INCLUDED_PP_ARRAY_PUSHBACK_BI__ -1

#include once "ext/preprocessor/array/size.bi"
#include once "ext/preprocessor/array/data.bi"
#include once "ext/preprocessor/tuple/remparens.bi"
#include once "ext/preprocessor/arithmetic/inc.bi"
#include once "ext/preprocessor/punctuation/commaif.bi"

'' Macro: fbextPP_ArrayPushBack
'' Adds an element to the end of an array.
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
'' *(5, (a, b, c, d, elem))*.
# define fbextPP_ArrayPushBack(array, value) _
         _fbextPP_ArrayPushBack_aux(array, value, fbextPP_ArraySize(array))

# define _fbextPP_ArrayPushBack_aux(array, value, size) _
( _
    fbextPP_Inc(size), _
    (fbextPP_TupleRemParens(size, fbextPP_ArrayData(array)) fbextPP_CommaIf(size) value) _
)

' deprecated.
# define FBEXT_PP_ARRAY_PUSHBACK(array, value) fbextPP_ArrayPushBack(array, value)

# endif ' include guard
