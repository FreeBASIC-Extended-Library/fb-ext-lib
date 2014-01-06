'' Title: ext/preprocessor/array/elem.bi
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
# ifndef FBEXT_INCLUDED_PP_ARRAY_ELEM_BI__
# define FBEXT_INCLUDED_PP_ARRAY_ELEM_BI__ -1

#include once "ext/preprocessor/array/size.bi"
#include once "ext/preprocessor/array/data.bi"
#include once "ext/preprocessor/tuple/elem.bi"

# define FBEXT_PP_ARRAY_ELEM(array, index) fbextPP_ArrayElem(array, index)

'' Macro: fbextPP_ArrayElem
'' Returns a certain element in an array.
''
'' Parameters:
'' array - An array.
'' index - The zero-based position of the element in the array.
''
'' Returns:
'' Returns the chosen element..
''
'' Description:
'' Given an array *(4, (a, b, c, d))* and index 2, this macro will expand to
'' *c*.
# define fbextPP_ArrayElem(array, index) _
         fbextPP_TupleElem(fbextPP_ArraySize(array), index, fbextPP_ArrayData(array))

# endif ' include guard
