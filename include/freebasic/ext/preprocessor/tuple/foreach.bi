'' Title: ext/preprocessor/tuple/foreach.bi
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
# ifndef FBEXT_INCLUDED_PP_TUPLE_FOREACH_BI__
# define FBEXT_INCLUDED_PP_TUPLE_FOREACH_BI__ -1

# include once "ext/preprocessor/tuple/remparens.bi"

# define FBEXT_PP_TUPLE_FOREACH(size, tuple, m) fbextPP_TupleForEach(size, tuple, m)

'' Macro: fbextPP_TupleForEach
''  repeatedly expands the user-defined macro *m*, passing it, in order, each
''  element stored in the tuple *tuple* of size *size*.
''
''  For example, if *size* is `3`, *tuple* is `(a,b,c)` and *m* is the name of
''  the macro,
''      : # define M(elem) [elem]
''  then this macro expands to `[a] [b] [c]`.
''
'' Parameters:
''  size - is the count of elements in the tuple.
''  tuple - is the tuple which stores the element to retrieve.
''  m - is the name of the user-defined macro to expand.
# define fbextPP_TupleForEach(size, tuple, m) _
    _fbextPP_TupleForEach__##size (m, fbextPP_TupleRemParens(size, tuple))

# define _fbextPP_TupleForEach__1(m, __0) m(__0)
# define _fbextPP_TupleForEach__2(m, __0, __1) m(__0) m(__1)
# define _fbextPP_TupleForEach__3(m, __0, __1, __2) m(__0) m(__1) m(__2)
# define _fbextPP_TupleForEach__4(m, __0, __1, __2, __3) m(__0) m(__1) m(__2) m(__3)
# define _fbextPP_TupleForEach__5(m, __0, __1, __2, __3, __4) m(__0) m(__1) m(__2) m(__3) m(__4)
# define _fbextPP_TupleForEach__6(m, __0, __1, __2, __3, __4, __5) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5)
# define _fbextPP_TupleForEach__7(m, __0, __1, __2, __3, __4, __5, __6) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6)
# define _fbextPP_TupleForEach__8(m, __0, __1, __2, __3, __4, __5, __6, __7) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7)
# define _fbextPP_TupleForEach__9(m, __0, __1, __2, __3, __4, __5, __6, __7, __8) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8)
# define _fbextPP_TupleForEach__10(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9)
# define _fbextPP_TupleForEach__11(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10)
# define _fbextPP_TupleForEach__12(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11)
# define _fbextPP_TupleForEach__13(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12)
# define _fbextPP_TupleForEach__14(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13)
# define _fbextPP_TupleForEach__15(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14)
# define _fbextPP_TupleForEach__16(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15)
# define _fbextPP_TupleForEach__17(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16)
# define _fbextPP_TupleForEach__18(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17)
# define _fbextPP_TupleForEach__19(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18)
# define _fbextPP_TupleForEach__20(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19)
# define _fbextPP_TupleForEach__21(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20)
# define _fbextPP_TupleForEach__22(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21)
# define _fbextPP_TupleForEach__23(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22)
# define _fbextPP_TupleForEach__24(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22, __23) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22) m(__23)
# define _fbextPP_TupleForEach__25(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22, __23, __24) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22) m(__23) m(__24)
# define _fbextPP_TupleForEach__26(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22, __23, __24, __25) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22) m(__23) m(__24) m(__25)
# define _fbextPP_TupleForEach__27(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22, __23, __24, __25, __26) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22) m(__23) m(__24) m(__25) m(__26)
# define _fbextPP_TupleForEach__28(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22, __23, __24, __25, __26, __27) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22) m(__23) m(__24) m(__25) m(__26) m(__27)
# define _fbextPP_TupleForEach__29(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22, __23, __24, __25, __26, __27, __28) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22) m(__23) m(__24) m(__25) m(__26) m(__27) m(__28)
# define _fbextPP_TupleForEach__30(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22, __23, __24, __25, __26, __27, __28, __29) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22) m(__23) m(__24) m(__25) m(__26) m(__27) m(__28) m(__29)
'# define _fbextPP_TupleForEach__31(m, __0, __1, __2, __3, __4, __5, __6, __7, __8, __9, __10, __11, __12, __13, __14, __15, __16, __17, __18, __19, __20, __21, __22, __23, __24, __25, __26, __27, __28, __29, __30) m(__0) m(__1) m(__2) m(__3) m(__4) m(__5) m(__6) m(__7) m(__8) m(__9) m(__10) m(__11) m(__12) m(__13) m(__14) m(__15) m(__16) m(__17) m(__18) m(__19) m(__20) m(__21) m(__22) m(__23) m(__24) m(__25) m(__26) m(__27) m(__28) m(__29) m(__30)

# endif ' include guard
