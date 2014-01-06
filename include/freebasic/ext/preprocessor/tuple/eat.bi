'' Title: ext/preprocessor/tuple/eat.bi
''  This file is part of the <ext/Preprocessor> library API, and can be
''  directly included by user programs.
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
# ifndef FBEXT_INCLUDED_PP_TUPLE_EAT_BI__
# define FBEXT_INCLUDED_PP_TUPLE_EAT_BI__ -1

# define FBEXT_PP_TUPLE_EAT(size) fbextPP_TupleEat(size)

'' Macro: fbextPP_TupleEat
''  consumes a tuple of size *size*, which must be specified immediately
''  following the call to this macro. It has the effect of expanding into the
''  name of a macro which uses the tuple as an argument list  -- but always 
''  expands to nothing (``).
''
''  For example, to eat the 3-element tuple `(a,b,c)`, place a call to this
''  macro immediately before it:
''      : fbextPP_TupleEat(3)(a,b,c)
''
'' Parameters:
''  size - is the count of elements in the tuple.
''  tuple - is the tuple to eat.
# define fbextPP_TupleEat(size) _
         fbextPP_TupleEat__##size

# define fbextPP_TupleEat__1(__0)
# define fbextPP_TupleEat__2(__0,__1)
# define fbextPP_TupleEat__3(__0,__1,__2)
# define fbextPP_TupleEat__4(__0,__1,__2,__3)
# define fbextPP_TupleEat__5(__0,__1,__2,__3,__4)
# define fbextPP_TupleEat__6(__0,__1,__2,__3,__4,__5)
# define fbextPP_TupleEat__7(__0,__1,__2,__3,__4,__5,__6)
# define fbextPP_TupleEat__8(__0,__1,__2,__3,__4,__5,__6,__7)
# define fbextPP_TupleEat__9(__0,__1,__2,__3,__4,__5,__6,__7,__8)
# define fbextPP_TupleEat__10(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9)
# define fbextPP_TupleEat__11(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10)
# define fbextPP_TupleEat__12(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11)
# define fbextPP_TupleEat__13(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12)
# define fbextPP_TupleEat__14(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13)
# define fbextPP_TupleEat__15(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14)
# define fbextPP_TupleEat__16(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15)
# define fbextPP_TupleEat__17(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16)
# define fbextPP_TupleEat__18(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17)
# define fbextPP_TupleEat__19(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18)
# define fbextPP_TupleEat__20(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19)
# define fbextPP_TupleEat__21(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20)
# define fbextPP_TupleEat__22(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21)
# define fbextPP_TupleEat__23(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22)
# define fbextPP_TupleEat__24(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22,__23)
# define fbextPP_TupleEat__25(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22,__23,__24)
# define fbextPP_TupleEat__26(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22,__23,__24,__25)
# define fbextPP_TupleEat__27(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22,__23,__24,__25,__26)
# define fbextPP_TupleEat__28(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22,__23,__24,__25,__26,__27)
# define fbextPP_TupleEat__29(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22,__23,__24,__25,__26,__27,__28)
# define fbextPP_TupleEat__30(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22,__23,__24,__25,__26,__27,__28,__29)
# define fbextPP_TupleEat__31(__0,__1,__2,__3,__4,__5,__6,__7,__8,__9,__10,__11,__12,__13,__14,__15,__16,__17,__18,__19,__20,__21,__22,__23,__24,__25,__26,__27,__28,__29,__30)

# endif ' include guard
