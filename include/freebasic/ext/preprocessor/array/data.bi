'' Title: ext/preprocessor/array/data.bi
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
# ifndef FBEXT_INCLUDED_PP_ARRAY_DATA_BI__
# define FBEXT_INCLUDED_PP_ARRAY_DATA_BI__ -1

# include once "ext/preprocessor/tuple/elem.bi"

# define FBEXT_PP_ARRAY_Data(array) fbextPP_ArrayData(array)

'' Macro: fbextPP_ArrayData
'' Returns the data (a tuple) portion of an array.
''
'' Parameters:
'' array - An array.
''
'' Returns:
'' Returns the data (a tuple) portion of an array.
''
'' Description:
'' Given an array *(4, (a, b, c, d))*, this macro will expand to
'' *(a, b, c, d)*.
# define fbextPP_ArrayData(array) FBEXT_PP_TUPLE_ELEM(2, 1, array)

# endif ' include guard
