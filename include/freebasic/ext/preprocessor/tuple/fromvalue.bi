'' Title: ext/preprocessor/tuple/fromvalue.bi
''  This file is part of the <ext/Preprocessor> library API, and can be
''  directly included by user programs.
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
# ifndef FBEXT_INCLUDED_PP_TUPLE_FROMVALUE_BI__
# define FBEXT_INCLUDED_PP_TUPLE_FROMVALUE_BI__ -1

# define FBEXT_PP_TUPLE_FROMVALUE(size, value) fbextPP_TupleFromValue(size, value)

'' Macro: fbextPP_TupleFromValue
''  expands to a tuple with *size* number of elements all having the value of
''  *value*.
# define fbextPP_TupleFromValue(size, value) _
    _fbextPP_TupleFromValue_##size(value)

'' :
# define _fbextPP_TupleFromValue_1(x) (x)
# define _fbextPP_TupleFromValue_2(x) (x,x)
# define _fbextPP_TupleFromValue_3(x) (x,x,x)
# define _fbextPP_TupleFromValue_4(x) (x,x,x,x)
# define _fbextPP_TupleFromValue_5(x) (x,x,x,x,x)
# define _fbextPP_TupleFromValue_6(x) (x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_7(x) (x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_8(x) (x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_9(x) (x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_10(x) (x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_11(x) (x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_12(x) (x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_13(x) (x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_14(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_15(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_16(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_17(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_18(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_19(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_20(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_21(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_22(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_23(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_24(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_25(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_26(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_27(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_28(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_29(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)
# define _fbextPP_TupleFromValue_30(x) (x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x)

# endif ' include guard
