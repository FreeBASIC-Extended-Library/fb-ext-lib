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
# ifndef FBEXT_INCLUDED_PP_ARRAY_REPLACE_BI__
# define FBEXT_INCLUDED_PP_ARRAY_REPLACE_BI__ -1

# include once "ext/preprocessor/tuple/replace.bi"

# include once "ext/preprocessor/array/size.bi"
# include once "ext/preprocessor/array/data.bi"

'' Macro: fbextPP_ArrayReplace
''  for every `n` in the range [0, array.size), do
''      `array[n] = iif(n <> index, array[n], value)`
# define fbextPP_ArrayReplace(array, index, value) _
    (   fbextPP_ArraySize(array), _
        fbextPP_TupleReplace(fbextPP_ArraySize(array), index, fbextPP_ArrayData(array), value) _
    )

' deprecated.
# define FBEXT_PP_ARRAY_REPLACE(array, index, value) fbextPP_ArrayReplace(array, index, value)

# endif ' include guard
