'' Title: ext/preprocessor/repetition/repeat.bi
''  This file is part of the <ext/Preprocessor> library API, and can be
''  directly included by user programs.
''
'' About: License
''  Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
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
# ifndef FBEXT_INCLUDED_PP_REPEAT_BI__
# define FBEXT_INCLUDED_PP_REPEAT_BI__ -1

# include once "ext/preprocessor/arithmetic/inc.bi"
# include once "ext/preprocessor/cat.bi"

# define FBEXT_PP_REPEAT(c, m, data) fbextPP_Repeat(c, m, data)

'' Macro: fbextPP_Repeat
'' Expands a macro a number of times.
''
'' Parameters:
'' c - The number of times to repeat.
'' m - A user-defined macro called for each repeat. It has the form
'' *m(n, data)*, where *n* is the current repetition number, and *data* is
'' auxilliary data passed to fbextPP_Repeat.
'' data - Auxilliary data that is passed to the user-defined macro for every
'' repeat.
''
'' Returns:
'' Varies.
''
'' Description:
'' This macro expands to *m(0, data) m(1, data)* ... *m(n-1, data)*
# define fbextPP_Repeat(c, m, data) _
         FBEXT_PP_CAT(fbextPP_Repeat__, c)(m, data, 0)

# define fbextPP_Repeat__0(m, d, n)

# define fbextPP_Repeat__1(m, d, n) m(n, d)
# define fbextPP_Repeat__2(m, d, n) m(n, d) fbextPP_Repeat__1(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__3(m, d, n) m(n, d) fbextPP_Repeat__2(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__4(m, d, n) m(n, d) fbextPP_Repeat__3(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__5(m, d, n) m(n, d) fbextPP_Repeat__4(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__6(m, d, n) m(n, d) fbextPP_Repeat__5(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__7(m, d, n) m(n, d) fbextPP_Repeat__6(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__8(m, d, n) m(n, d) fbextPP_Repeat__7(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__9(m, d, n) m(n, d) fbextPP_Repeat__8(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__10(m, d, n) m(n, d) fbextPP_Repeat__9(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__11(m, d, n) m(n, d) fbextPP_Repeat__10(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__12(m, d, n) m(n, d) fbextPP_Repeat__11(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__13(m, d, n) m(n, d) fbextPP_Repeat__12(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__14(m, d, n) m(n, d) fbextPP_Repeat__13(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__15(m, d, n) m(n, d) fbextPP_Repeat__14(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__16(m, d, n) m(n, d) fbextPP_Repeat__15(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__17(m, d, n) m(n, d) fbextPP_Repeat__16(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__18(m, d, n) m(n, d) fbextPP_Repeat__17(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__19(m, d, n) m(n, d) fbextPP_Repeat__18(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__20(m, d, n) m(n, d) fbextPP_Repeat__19(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__21(m, d, n) m(n, d) fbextPP_Repeat__20(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__22(m, d, n) m(n, d) fbextPP_Repeat__21(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__23(m, d, n) m(n, d) fbextPP_Repeat__22(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__24(m, d, n) m(n, d) fbextPP_Repeat__23(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__25(m, d, n) m(n, d) fbextPP_Repeat__24(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__26(m, d, n) m(n, d) fbextPP_Repeat__25(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__27(m, d, n) m(n, d) fbextPP_Repeat__26(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__28(m, d, n) m(n, d) fbextPP_Repeat__27(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__29(m, d, n) m(n, d) fbextPP_Repeat__28(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__30(m, d, n) m(n, d) fbextPP_Repeat__29(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__31(m, d, n) m(n, d) fbextPP_Repeat__30(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__32(m, d, n) m(n, d) fbextPP_Repeat__31(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__33(m, d, n) m(n, d) fbextPP_Repeat__32(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__34(m, d, n) m(n, d) fbextPP_Repeat__33(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__35(m, d, n) m(n, d) fbextPP_Repeat__34(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__36(m, d, n) m(n, d) fbextPP_Repeat__35(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__37(m, d, n) m(n, d) fbextPP_Repeat__36(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__38(m, d, n) m(n, d) fbextPP_Repeat__37(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__39(m, d, n) m(n, d) fbextPP_Repeat__38(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__40(m, d, n) m(n, d) fbextPP_Repeat__39(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__41(m, d, n) m(n, d) fbextPP_Repeat__40(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__42(m, d, n) m(n, d) fbextPP_Repeat__41(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__43(m, d, n) m(n, d) fbextPP_Repeat__42(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__44(m, d, n) m(n, d) fbextPP_Repeat__43(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__45(m, d, n) m(n, d) fbextPP_Repeat__44(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__46(m, d, n) m(n, d) fbextPP_Repeat__45(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__47(m, d, n) m(n, d) fbextPP_Repeat__46(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__48(m, d, n) m(n, d) fbextPP_Repeat__47(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__49(m, d, n) m(n, d) fbextPP_Repeat__48(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__50(m, d, n) m(n, d) fbextPP_Repeat__49(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__51(m, d, n) m(n, d) fbextPP_Repeat__50(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__52(m, d, n) m(n, d) fbextPP_Repeat__51(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__53(m, d, n) m(n, d) fbextPP_Repeat__52(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__54(m, d, n) m(n, d) fbextPP_Repeat__53(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__55(m, d, n) m(n, d) fbextPP_Repeat__54(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__56(m, d, n) m(n, d) fbextPP_Repeat__55(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__57(m, d, n) m(n, d) fbextPP_Repeat__56(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__58(m, d, n) m(n, d) fbextPP_Repeat__57(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__59(m, d, n) m(n, d) fbextPP_Repeat__58(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__60(m, d, n) m(n, d) fbextPP_Repeat__59(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__61(m, d, n) m(n, d) fbextPP_Repeat__60(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__62(m, d, n) m(n, d) fbextPP_Repeat__61(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__63(m, d, n) m(n, d) fbextPP_Repeat__62(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__64(m, d, n) m(n, d) fbextPP_Repeat__63(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__65(m, d, n) m(n, d) fbextPP_Repeat__64(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__66(m, d, n) m(n, d) fbextPP_Repeat__65(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__67(m, d, n) m(n, d) fbextPP_Repeat__66(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__68(m, d, n) m(n, d) fbextPP_Repeat__67(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__69(m, d, n) m(n, d) fbextPP_Repeat__68(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__70(m, d, n) m(n, d) fbextPP_Repeat__69(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__71(m, d, n) m(n, d) fbextPP_Repeat__70(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__72(m, d, n) m(n, d) fbextPP_Repeat__71(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__73(m, d, n) m(n, d) fbextPP_Repeat__72(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__74(m, d, n) m(n, d) fbextPP_Repeat__73(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__75(m, d, n) m(n, d) fbextPP_Repeat__74(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__76(m, d, n) m(n, d) fbextPP_Repeat__75(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__77(m, d, n) m(n, d) fbextPP_Repeat__76(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__78(m, d, n) m(n, d) fbextPP_Repeat__77(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__79(m, d, n) m(n, d) fbextPP_Repeat__78(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__80(m, d, n) m(n, d) fbextPP_Repeat__79(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__81(m, d, n) m(n, d) fbextPP_Repeat__80(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__82(m, d, n) m(n, d) fbextPP_Repeat__81(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__83(m, d, n) m(n, d) fbextPP_Repeat__82(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__84(m, d, n) m(n, d) fbextPP_Repeat__83(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__85(m, d, n) m(n, d) fbextPP_Repeat__84(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__86(m, d, n) m(n, d) fbextPP_Repeat__85(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__87(m, d, n) m(n, d) fbextPP_Repeat__86(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__88(m, d, n) m(n, d) fbextPP_Repeat__87(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__89(m, d, n) m(n, d) fbextPP_Repeat__88(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__90(m, d, n) m(n, d) fbextPP_Repeat__89(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__91(m, d, n) m(n, d) fbextPP_Repeat__90(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__92(m, d, n) m(n, d) fbextPP_Repeat__91(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__93(m, d, n) m(n, d) fbextPP_Repeat__92(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__94(m, d, n) m(n, d) fbextPP_Repeat__93(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__95(m, d, n) m(n, d) fbextPP_Repeat__94(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__96(m, d, n) m(n, d) fbextPP_Repeat__95(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__97(m, d, n) m(n, d) fbextPP_Repeat__96(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__98(m, d, n) m(n, d) fbextPP_Repeat__97(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__99(m, d, n) m(n, d) fbextPP_Repeat__98(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__100(m, d, n) m(n, d) fbextPP_Repeat__99(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__101(m, d, n) m(n, d) fbextPP_Repeat__100(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__102(m, d, n) m(n, d) fbextPP_Repeat__101(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__103(m, d, n) m(n, d) fbextPP_Repeat__102(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__104(m, d, n) m(n, d) fbextPP_Repeat__103(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__105(m, d, n) m(n, d) fbextPP_Repeat__104(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__106(m, d, n) m(n, d) fbextPP_Repeat__105(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__107(m, d, n) m(n, d) fbextPP_Repeat__106(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__108(m, d, n) m(n, d) fbextPP_Repeat__107(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__109(m, d, n) m(n, d) fbextPP_Repeat__108(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__110(m, d, n) m(n, d) fbextPP_Repeat__109(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__111(m, d, n) m(n, d) fbextPP_Repeat__110(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__112(m, d, n) m(n, d) fbextPP_Repeat__111(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__113(m, d, n) m(n, d) fbextPP_Repeat__112(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__114(m, d, n) m(n, d) fbextPP_Repeat__113(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__115(m, d, n) m(n, d) fbextPP_Repeat__114(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__116(m, d, n) m(n, d) fbextPP_Repeat__115(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__117(m, d, n) m(n, d) fbextPP_Repeat__116(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__118(m, d, n) m(n, d) fbextPP_Repeat__117(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__119(m, d, n) m(n, d) fbextPP_Repeat__118(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__120(m, d, n) m(n, d) fbextPP_Repeat__119(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__121(m, d, n) m(n, d) fbextPP_Repeat__120(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__122(m, d, n) m(n, d) fbextPP_Repeat__121(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__123(m, d, n) m(n, d) fbextPP_Repeat__122(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__124(m, d, n) m(n, d) fbextPP_Repeat__123(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__125(m, d, n) m(n, d) fbextPP_Repeat__124(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__126(m, d, n) m(n, d) fbextPP_Repeat__125(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__127(m, d, n) m(n, d) fbextPP_Repeat__126(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__128(m, d, n) m(n, d) fbextPP_Repeat__127(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__129(m, d, n) m(n, d) fbextPP_Repeat__128(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__130(m, d, n) m(n, d) fbextPP_Repeat__129(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__131(m, d, n) m(n, d) fbextPP_Repeat__130(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__132(m, d, n) m(n, d) fbextPP_Repeat__131(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__133(m, d, n) m(n, d) fbextPP_Repeat__132(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__134(m, d, n) m(n, d) fbextPP_Repeat__133(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__135(m, d, n) m(n, d) fbextPP_Repeat__134(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__136(m, d, n) m(n, d) fbextPP_Repeat__135(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__137(m, d, n) m(n, d) fbextPP_Repeat__136(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__138(m, d, n) m(n, d) fbextPP_Repeat__137(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__139(m, d, n) m(n, d) fbextPP_Repeat__138(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__140(m, d, n) m(n, d) fbextPP_Repeat__139(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__141(m, d, n) m(n, d) fbextPP_Repeat__140(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__142(m, d, n) m(n, d) fbextPP_Repeat__141(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__143(m, d, n) m(n, d) fbextPP_Repeat__142(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__144(m, d, n) m(n, d) fbextPP_Repeat__143(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__145(m, d, n) m(n, d) fbextPP_Repeat__144(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__146(m, d, n) m(n, d) fbextPP_Repeat__145(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__147(m, d, n) m(n, d) fbextPP_Repeat__146(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__148(m, d, n) m(n, d) fbextPP_Repeat__147(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__149(m, d, n) m(n, d) fbextPP_Repeat__148(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__150(m, d, n) m(n, d) fbextPP_Repeat__149(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__151(m, d, n) m(n, d) fbextPP_Repeat__150(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__152(m, d, n) m(n, d) fbextPP_Repeat__151(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__153(m, d, n) m(n, d) fbextPP_Repeat__152(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__154(m, d, n) m(n, d) fbextPP_Repeat__153(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__155(m, d, n) m(n, d) fbextPP_Repeat__154(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__156(m, d, n) m(n, d) fbextPP_Repeat__155(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__157(m, d, n) m(n, d) fbextPP_Repeat__156(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__158(m, d, n) m(n, d) fbextPP_Repeat__157(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__159(m, d, n) m(n, d) fbextPP_Repeat__158(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__160(m, d, n) m(n, d) fbextPP_Repeat__159(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__161(m, d, n) m(n, d) fbextPP_Repeat__160(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__162(m, d, n) m(n, d) fbextPP_Repeat__161(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__163(m, d, n) m(n, d) fbextPP_Repeat__162(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__164(m, d, n) m(n, d) fbextPP_Repeat__163(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__165(m, d, n) m(n, d) fbextPP_Repeat__164(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__166(m, d, n) m(n, d) fbextPP_Repeat__165(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__167(m, d, n) m(n, d) fbextPP_Repeat__166(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__168(m, d, n) m(n, d) fbextPP_Repeat__167(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__169(m, d, n) m(n, d) fbextPP_Repeat__168(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__170(m, d, n) m(n, d) fbextPP_Repeat__169(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__171(m, d, n) m(n, d) fbextPP_Repeat__170(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__172(m, d, n) m(n, d) fbextPP_Repeat__171(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__173(m, d, n) m(n, d) fbextPP_Repeat__172(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__174(m, d, n) m(n, d) fbextPP_Repeat__173(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__175(m, d, n) m(n, d) fbextPP_Repeat__174(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__176(m, d, n) m(n, d) fbextPP_Repeat__175(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__177(m, d, n) m(n, d) fbextPP_Repeat__176(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__178(m, d, n) m(n, d) fbextPP_Repeat__177(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__179(m, d, n) m(n, d) fbextPP_Repeat__178(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__180(m, d, n) m(n, d) fbextPP_Repeat__179(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__181(m, d, n) m(n, d) fbextPP_Repeat__180(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__182(m, d, n) m(n, d) fbextPP_Repeat__181(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__183(m, d, n) m(n, d) fbextPP_Repeat__182(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__184(m, d, n) m(n, d) fbextPP_Repeat__183(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__185(m, d, n) m(n, d) fbextPP_Repeat__184(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__186(m, d, n) m(n, d) fbextPP_Repeat__185(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__187(m, d, n) m(n, d) fbextPP_Repeat__186(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__188(m, d, n) m(n, d) fbextPP_Repeat__187(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__189(m, d, n) m(n, d) fbextPP_Repeat__188(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__190(m, d, n) m(n, d) fbextPP_Repeat__189(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__191(m, d, n) m(n, d) fbextPP_Repeat__190(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__192(m, d, n) m(n, d) fbextPP_Repeat__191(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__193(m, d, n) m(n, d) fbextPP_Repeat__192(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__194(m, d, n) m(n, d) fbextPP_Repeat__193(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__195(m, d, n) m(n, d) fbextPP_Repeat__194(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__196(m, d, n) m(n, d) fbextPP_Repeat__195(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__197(m, d, n) m(n, d) fbextPP_Repeat__196(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__198(m, d, n) m(n, d) fbextPP_Repeat__197(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__199(m, d, n) m(n, d) fbextPP_Repeat__198(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__200(m, d, n) m(n, d) fbextPP_Repeat__199(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__201(m, d, n) m(n, d) fbextPP_Repeat__200(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__202(m, d, n) m(n, d) fbextPP_Repeat__201(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__203(m, d, n) m(n, d) fbextPP_Repeat__202(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__204(m, d, n) m(n, d) fbextPP_Repeat__203(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__205(m, d, n) m(n, d) fbextPP_Repeat__204(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__206(m, d, n) m(n, d) fbextPP_Repeat__205(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__207(m, d, n) m(n, d) fbextPP_Repeat__206(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__208(m, d, n) m(n, d) fbextPP_Repeat__207(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__209(m, d, n) m(n, d) fbextPP_Repeat__208(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__210(m, d, n) m(n, d) fbextPP_Repeat__209(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__211(m, d, n) m(n, d) fbextPP_Repeat__210(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__212(m, d, n) m(n, d) fbextPP_Repeat__211(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__213(m, d, n) m(n, d) fbextPP_Repeat__212(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__214(m, d, n) m(n, d) fbextPP_Repeat__213(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__215(m, d, n) m(n, d) fbextPP_Repeat__214(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__216(m, d, n) m(n, d) fbextPP_Repeat__215(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__217(m, d, n) m(n, d) fbextPP_Repeat__216(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__218(m, d, n) m(n, d) fbextPP_Repeat__217(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__219(m, d, n) m(n, d) fbextPP_Repeat__218(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__220(m, d, n) m(n, d) fbextPP_Repeat__219(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__221(m, d, n) m(n, d) fbextPP_Repeat__220(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__222(m, d, n) m(n, d) fbextPP_Repeat__221(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__223(m, d, n) m(n, d) fbextPP_Repeat__222(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__224(m, d, n) m(n, d) fbextPP_Repeat__223(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__225(m, d, n) m(n, d) fbextPP_Repeat__224(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__226(m, d, n) m(n, d) fbextPP_Repeat__225(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__227(m, d, n) m(n, d) fbextPP_Repeat__226(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__228(m, d, n) m(n, d) fbextPP_Repeat__227(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__229(m, d, n) m(n, d) fbextPP_Repeat__228(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__230(m, d, n) m(n, d) fbextPP_Repeat__229(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__231(m, d, n) m(n, d) fbextPP_Repeat__230(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__232(m, d, n) m(n, d) fbextPP_Repeat__231(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__233(m, d, n) m(n, d) fbextPP_Repeat__232(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__234(m, d, n) m(n, d) fbextPP_Repeat__233(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__235(m, d, n) m(n, d) fbextPP_Repeat__234(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__236(m, d, n) m(n, d) fbextPP_Repeat__235(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__237(m, d, n) m(n, d) fbextPP_Repeat__236(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__238(m, d, n) m(n, d) fbextPP_Repeat__237(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__239(m, d, n) m(n, d) fbextPP_Repeat__238(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__240(m, d, n) m(n, d) fbextPP_Repeat__239(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__241(m, d, n) m(n, d) fbextPP_Repeat__240(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__242(m, d, n) m(n, d) fbextPP_Repeat__241(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__243(m, d, n) m(n, d) fbextPP_Repeat__242(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__244(m, d, n) m(n, d) fbextPP_Repeat__243(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__245(m, d, n) m(n, d) fbextPP_Repeat__244(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__246(m, d, n) m(n, d) fbextPP_Repeat__245(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__247(m, d, n) m(n, d) fbextPP_Repeat__246(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__248(m, d, n) m(n, d) fbextPP_Repeat__247(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__249(m, d, n) m(n, d) fbextPP_Repeat__248(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__250(m, d, n) m(n, d) fbextPP_Repeat__249(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__251(m, d, n) m(n, d) fbextPP_Repeat__250(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__252(m, d, n) m(n, d) fbextPP_Repeat__251(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__253(m, d, n) m(n, d) fbextPP_Repeat__252(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__254(m, d, n) m(n, d) fbextPP_Repeat__253(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__255(m, d, n) m(n, d) fbextPP_Repeat__254(m, d, fbextPP_Inc(n))
# define fbextPP_Repeat__256(m, d, n) m(n, d) fbextPP_Repeat__255(m, d, fbextPP_Inc(n))

# endif