'' Title: ext/preprocessor/seq/elem.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_ELEM_BI__
# define FBEXT_INCLUDED_PP_SEQ_ELEM_BI__ -1

'' Macro: fbextPP_SeqElem
'' Expands to the value of a certain element in a sequence.
''
'' Parameters:
'' i - The zero-based index of the element to retrieve, must be in the range 0 to FBEXT_PP_SEQ_SIZE(seq)-1.
'' seq - A sequence.
''
'' Returns:
'' The *i* th element in *seq*.
''
'' Example:
'' (start code)
'' # include "ext/preprocessor/seq/elem.bi"
'' # include "ext/preprocessor/stringize.bi"
''
'' # define SEQ (a)(b)(c)(d)
''
'' ' Expands to "c"
'' # print FBEXT_PP_STRINGIZE(fbextPP_SeqElem(2, SEQ))
'' (end code)
# define fbextPP_SeqElem(i, seq) _
         fbextPP_SeqElem__I(fbextPP_SeqElem__##i seq(__))

'
# define FBEXT_PP_SEQ_ELEM(i, seq) fbextPP_SeqElem(i, seq)

# define fbextPP_SeqElem__I(x, __) x

# define fbextPP_SeqElem__0(x) x,
# define fbextPP_SeqElem__1(___) fbextPP_SeqElem__0
# define fbextPP_SeqElem__2(___) fbextPP_SeqElem__1
# define fbextPP_SeqElem__3(___) fbextPP_SeqElem__2
# define fbextPP_SeqElem__4(___) fbextPP_SeqElem__3
# define fbextPP_SeqElem__5(___) fbextPP_SeqElem__4
# define fbextPP_SeqElem__6(___) fbextPP_SeqElem__5
# define fbextPP_SeqElem__7(___) fbextPP_SeqElem__6
# define fbextPP_SeqElem__8(___) fbextPP_SeqElem__7
# define fbextPP_SeqElem__9(___) fbextPP_SeqElem__8
# define fbextPP_SeqElem__10(___) fbextPP_SeqElem__9
# define fbextPP_SeqElem__11(___) fbextPP_SeqElem__10
# define fbextPP_SeqElem__12(___) fbextPP_SeqElem__11
# define fbextPP_SeqElem__13(___) fbextPP_SeqElem__12
# define fbextPP_SeqElem__14(___) fbextPP_SeqElem__13
# define fbextPP_SeqElem__15(___) fbextPP_SeqElem__14
# define fbextPP_SeqElem__16(___) fbextPP_SeqElem__15
# define fbextPP_SeqElem__17(___) fbextPP_SeqElem__16
# define fbextPP_SeqElem__18(___) fbextPP_SeqElem__17
# define fbextPP_SeqElem__19(___) fbextPP_SeqElem__18
# define fbextPP_SeqElem__20(___) fbextPP_SeqElem__19
# define fbextPP_SeqElem__21(___) fbextPP_SeqElem__20
# define fbextPP_SeqElem__22(___) fbextPP_SeqElem__21
# define fbextPP_SeqElem__23(___) fbextPP_SeqElem__22
# define fbextPP_SeqElem__24(___) fbextPP_SeqElem__23
# define fbextPP_SeqElem__25(___) fbextPP_SeqElem__24
# define fbextPP_SeqElem__26(___) fbextPP_SeqElem__25
# define fbextPP_SeqElem__27(___) fbextPP_SeqElem__26
# define fbextPP_SeqElem__28(___) fbextPP_SeqElem__27
# define fbextPP_SeqElem__29(___) fbextPP_SeqElem__28
# define fbextPP_SeqElem__30(___) fbextPP_SeqElem__29
# define fbextPP_SeqElem__31(___) fbextPP_SeqElem__30
# define fbextPP_SeqElem__32(___) fbextPP_SeqElem__31
# define fbextPP_SeqElem__33(___) fbextPP_SeqElem__32
# define fbextPP_SeqElem__34(___) fbextPP_SeqElem__33
# define fbextPP_SeqElem__35(___) fbextPP_SeqElem__34
# define fbextPP_SeqElem__36(___) fbextPP_SeqElem__35
# define fbextPP_SeqElem__37(___) fbextPP_SeqElem__36
# define fbextPP_SeqElem__38(___) fbextPP_SeqElem__37
# define fbextPP_SeqElem__39(___) fbextPP_SeqElem__38
# define fbextPP_SeqElem__40(___) fbextPP_SeqElem__39
# define fbextPP_SeqElem__41(___) fbextPP_SeqElem__40
# define fbextPP_SeqElem__42(___) fbextPP_SeqElem__41
# define fbextPP_SeqElem__43(___) fbextPP_SeqElem__42
# define fbextPP_SeqElem__44(___) fbextPP_SeqElem__43
# define fbextPP_SeqElem__45(___) fbextPP_SeqElem__44
# define fbextPP_SeqElem__46(___) fbextPP_SeqElem__45
# define fbextPP_SeqElem__47(___) fbextPP_SeqElem__46
# define fbextPP_SeqElem__48(___) fbextPP_SeqElem__47
# define fbextPP_SeqElem__49(___) fbextPP_SeqElem__48
# define fbextPP_SeqElem__50(___) fbextPP_SeqElem__49
# define fbextPP_SeqElem__51(___) fbextPP_SeqElem__50
# define fbextPP_SeqElem__52(___) fbextPP_SeqElem__51
# define fbextPP_SeqElem__53(___) fbextPP_SeqElem__52
# define fbextPP_SeqElem__54(___) fbextPP_SeqElem__53
# define fbextPP_SeqElem__55(___) fbextPP_SeqElem__54
# define fbextPP_SeqElem__56(___) fbextPP_SeqElem__55
# define fbextPP_SeqElem__57(___) fbextPP_SeqElem__56
# define fbextPP_SeqElem__58(___) fbextPP_SeqElem__57
# define fbextPP_SeqElem__59(___) fbextPP_SeqElem__58
# define fbextPP_SeqElem__60(___) fbextPP_SeqElem__59
# define fbextPP_SeqElem__61(___) fbextPP_SeqElem__60
# define fbextPP_SeqElem__62(___) fbextPP_SeqElem__61
# define fbextPP_SeqElem__63(___) fbextPP_SeqElem__62
# define fbextPP_SeqElem__64(___) fbextPP_SeqElem__63
# define fbextPP_SeqElem__65(___) fbextPP_SeqElem__64
# define fbextPP_SeqElem__66(___) fbextPP_SeqElem__65
# define fbextPP_SeqElem__67(___) fbextPP_SeqElem__66
# define fbextPP_SeqElem__68(___) fbextPP_SeqElem__67
# define fbextPP_SeqElem__69(___) fbextPP_SeqElem__68
# define fbextPP_SeqElem__70(___) fbextPP_SeqElem__69
# define fbextPP_SeqElem__71(___) fbextPP_SeqElem__70
# define fbextPP_SeqElem__72(___) fbextPP_SeqElem__71
# define fbextPP_SeqElem__73(___) fbextPP_SeqElem__72
# define fbextPP_SeqElem__74(___) fbextPP_SeqElem__73
# define fbextPP_SeqElem__75(___) fbextPP_SeqElem__74
# define fbextPP_SeqElem__76(___) fbextPP_SeqElem__75
# define fbextPP_SeqElem__77(___) fbextPP_SeqElem__76
# define fbextPP_SeqElem__78(___) fbextPP_SeqElem__77
# define fbextPP_SeqElem__79(___) fbextPP_SeqElem__78
# define fbextPP_SeqElem__80(___) fbextPP_SeqElem__79
# define fbextPP_SeqElem__81(___) fbextPP_SeqElem__80
# define fbextPP_SeqElem__82(___) fbextPP_SeqElem__81
# define fbextPP_SeqElem__83(___) fbextPP_SeqElem__82
# define fbextPP_SeqElem__84(___) fbextPP_SeqElem__83
# define fbextPP_SeqElem__85(___) fbextPP_SeqElem__84
# define fbextPP_SeqElem__86(___) fbextPP_SeqElem__85
# define fbextPP_SeqElem__87(___) fbextPP_SeqElem__86
# define fbextPP_SeqElem__88(___) fbextPP_SeqElem__87
# define fbextPP_SeqElem__89(___) fbextPP_SeqElem__88
# define fbextPP_SeqElem__90(___) fbextPP_SeqElem__89
# define fbextPP_SeqElem__91(___) fbextPP_SeqElem__90
# define fbextPP_SeqElem__92(___) fbextPP_SeqElem__91
# define fbextPP_SeqElem__93(___) fbextPP_SeqElem__92
# define fbextPP_SeqElem__94(___) fbextPP_SeqElem__93
# define fbextPP_SeqElem__95(___) fbextPP_SeqElem__94
# define fbextPP_SeqElem__96(___) fbextPP_SeqElem__95
# define fbextPP_SeqElem__97(___) fbextPP_SeqElem__96
# define fbextPP_SeqElem__98(___) fbextPP_SeqElem__97
# define fbextPP_SeqElem__99(___) fbextPP_SeqElem__98
# define fbextPP_SeqElem__100(___) fbextPP_SeqElem__99
# define fbextPP_SeqElem__101(___) fbextPP_SeqElem__100
# define fbextPP_SeqElem__102(___) fbextPP_SeqElem__101
# define fbextPP_SeqElem__103(___) fbextPP_SeqElem__102
# define fbextPP_SeqElem__104(___) fbextPP_SeqElem__103
# define fbextPP_SeqElem__105(___) fbextPP_SeqElem__104
# define fbextPP_SeqElem__106(___) fbextPP_SeqElem__105
# define fbextPP_SeqElem__107(___) fbextPP_SeqElem__106
# define fbextPP_SeqElem__108(___) fbextPP_SeqElem__107
# define fbextPP_SeqElem__109(___) fbextPP_SeqElem__108
# define fbextPP_SeqElem__110(___) fbextPP_SeqElem__109
# define fbextPP_SeqElem__111(___) fbextPP_SeqElem__110
# define fbextPP_SeqElem__112(___) fbextPP_SeqElem__111
# define fbextPP_SeqElem__113(___) fbextPP_SeqElem__112
# define fbextPP_SeqElem__114(___) fbextPP_SeqElem__113
# define fbextPP_SeqElem__115(___) fbextPP_SeqElem__114
# define fbextPP_SeqElem__116(___) fbextPP_SeqElem__115
# define fbextPP_SeqElem__117(___) fbextPP_SeqElem__116
# define fbextPP_SeqElem__118(___) fbextPP_SeqElem__117
# define fbextPP_SeqElem__119(___) fbextPP_SeqElem__118
# define fbextPP_SeqElem__120(___) fbextPP_SeqElem__119
# define fbextPP_SeqElem__121(___) fbextPP_SeqElem__120
# define fbextPP_SeqElem__122(___) fbextPP_SeqElem__121
# define fbextPP_SeqElem__123(___) fbextPP_SeqElem__122
# define fbextPP_SeqElem__124(___) fbextPP_SeqElem__123
# define fbextPP_SeqElem__125(___) fbextPP_SeqElem__124
# define fbextPP_SeqElem__126(___) fbextPP_SeqElem__125
# define fbextPP_SeqElem__127(___) fbextPP_SeqElem__126
# define fbextPP_SeqElem__128(___) fbextPP_SeqElem__127
# define fbextPP_SeqElem__129(___) fbextPP_SeqElem__128
# define fbextPP_SeqElem__130(___) fbextPP_SeqElem__129
# define fbextPP_SeqElem__131(___) fbextPP_SeqElem__130
# define fbextPP_SeqElem__132(___) fbextPP_SeqElem__131
# define fbextPP_SeqElem__133(___) fbextPP_SeqElem__132
# define fbextPP_SeqElem__134(___) fbextPP_SeqElem__133
# define fbextPP_SeqElem__135(___) fbextPP_SeqElem__134
# define fbextPP_SeqElem__136(___) fbextPP_SeqElem__135
# define fbextPP_SeqElem__137(___) fbextPP_SeqElem__136
# define fbextPP_SeqElem__138(___) fbextPP_SeqElem__137
# define fbextPP_SeqElem__139(___) fbextPP_SeqElem__138
# define fbextPP_SeqElem__140(___) fbextPP_SeqElem__139
# define fbextPP_SeqElem__141(___) fbextPP_SeqElem__140
# define fbextPP_SeqElem__142(___) fbextPP_SeqElem__141
# define fbextPP_SeqElem__143(___) fbextPP_SeqElem__142
# define fbextPP_SeqElem__144(___) fbextPP_SeqElem__143
# define fbextPP_SeqElem__145(___) fbextPP_SeqElem__144
# define fbextPP_SeqElem__146(___) fbextPP_SeqElem__145
# define fbextPP_SeqElem__147(___) fbextPP_SeqElem__146
# define fbextPP_SeqElem__148(___) fbextPP_SeqElem__147
# define fbextPP_SeqElem__149(___) fbextPP_SeqElem__148
# define fbextPP_SeqElem__150(___) fbextPP_SeqElem__149
# define fbextPP_SeqElem__151(___) fbextPP_SeqElem__150
# define fbextPP_SeqElem__152(___) fbextPP_SeqElem__151
# define fbextPP_SeqElem__153(___) fbextPP_SeqElem__152
# define fbextPP_SeqElem__154(___) fbextPP_SeqElem__153
# define fbextPP_SeqElem__155(___) fbextPP_SeqElem__154
# define fbextPP_SeqElem__156(___) fbextPP_SeqElem__155
# define fbextPP_SeqElem__157(___) fbextPP_SeqElem__156
# define fbextPP_SeqElem__158(___) fbextPP_SeqElem__157
# define fbextPP_SeqElem__159(___) fbextPP_SeqElem__158
# define fbextPP_SeqElem__160(___) fbextPP_SeqElem__159
# define fbextPP_SeqElem__161(___) fbextPP_SeqElem__160
# define fbextPP_SeqElem__162(___) fbextPP_SeqElem__161
# define fbextPP_SeqElem__163(___) fbextPP_SeqElem__162
# define fbextPP_SeqElem__164(___) fbextPP_SeqElem__163
# define fbextPP_SeqElem__165(___) fbextPP_SeqElem__164
# define fbextPP_SeqElem__166(___) fbextPP_SeqElem__165
# define fbextPP_SeqElem__167(___) fbextPP_SeqElem__166
# define fbextPP_SeqElem__168(___) fbextPP_SeqElem__167
# define fbextPP_SeqElem__169(___) fbextPP_SeqElem__168
# define fbextPP_SeqElem__170(___) fbextPP_SeqElem__169
# define fbextPP_SeqElem__171(___) fbextPP_SeqElem__170
# define fbextPP_SeqElem__172(___) fbextPP_SeqElem__171
# define fbextPP_SeqElem__173(___) fbextPP_SeqElem__172
# define fbextPP_SeqElem__174(___) fbextPP_SeqElem__173
# define fbextPP_SeqElem__175(___) fbextPP_SeqElem__174
# define fbextPP_SeqElem__176(___) fbextPP_SeqElem__175
# define fbextPP_SeqElem__177(___) fbextPP_SeqElem__176
# define fbextPP_SeqElem__178(___) fbextPP_SeqElem__177
# define fbextPP_SeqElem__179(___) fbextPP_SeqElem__178
# define fbextPP_SeqElem__180(___) fbextPP_SeqElem__179
# define fbextPP_SeqElem__181(___) fbextPP_SeqElem__180
# define fbextPP_SeqElem__182(___) fbextPP_SeqElem__181
# define fbextPP_SeqElem__183(___) fbextPP_SeqElem__182
# define fbextPP_SeqElem__184(___) fbextPP_SeqElem__183
# define fbextPP_SeqElem__185(___) fbextPP_SeqElem__184
# define fbextPP_SeqElem__186(___) fbextPP_SeqElem__185
# define fbextPP_SeqElem__187(___) fbextPP_SeqElem__186
# define fbextPP_SeqElem__188(___) fbextPP_SeqElem__187
# define fbextPP_SeqElem__189(___) fbextPP_SeqElem__188
# define fbextPP_SeqElem__190(___) fbextPP_SeqElem__189
# define fbextPP_SeqElem__191(___) fbextPP_SeqElem__190
# define fbextPP_SeqElem__192(___) fbextPP_SeqElem__191
# define fbextPP_SeqElem__193(___) fbextPP_SeqElem__192
# define fbextPP_SeqElem__194(___) fbextPP_SeqElem__193
# define fbextPP_SeqElem__195(___) fbextPP_SeqElem__194
# define fbextPP_SeqElem__196(___) fbextPP_SeqElem__195
# define fbextPP_SeqElem__197(___) fbextPP_SeqElem__196
# define fbextPP_SeqElem__198(___) fbextPP_SeqElem__197
# define fbextPP_SeqElem__199(___) fbextPP_SeqElem__198
# define fbextPP_SeqElem__200(___) fbextPP_SeqElem__199
# define fbextPP_SeqElem__201(___) fbextPP_SeqElem__200
# define fbextPP_SeqElem__202(___) fbextPP_SeqElem__201
# define fbextPP_SeqElem__203(___) fbextPP_SeqElem__202
# define fbextPP_SeqElem__204(___) fbextPP_SeqElem__203
# define fbextPP_SeqElem__205(___) fbextPP_SeqElem__204
# define fbextPP_SeqElem__206(___) fbextPP_SeqElem__205
# define fbextPP_SeqElem__207(___) fbextPP_SeqElem__206
# define fbextPP_SeqElem__208(___) fbextPP_SeqElem__207
# define fbextPP_SeqElem__209(___) fbextPP_SeqElem__208
# define fbextPP_SeqElem__210(___) fbextPP_SeqElem__209
# define fbextPP_SeqElem__211(___) fbextPP_SeqElem__210
# define fbextPP_SeqElem__212(___) fbextPP_SeqElem__211
# define fbextPP_SeqElem__213(___) fbextPP_SeqElem__212
# define fbextPP_SeqElem__214(___) fbextPP_SeqElem__213
# define fbextPP_SeqElem__215(___) fbextPP_SeqElem__214
# define fbextPP_SeqElem__216(___) fbextPP_SeqElem__215
# define fbextPP_SeqElem__217(___) fbextPP_SeqElem__216
# define fbextPP_SeqElem__218(___) fbextPP_SeqElem__217
# define fbextPP_SeqElem__219(___) fbextPP_SeqElem__218
# define fbextPP_SeqElem__220(___) fbextPP_SeqElem__219
# define fbextPP_SeqElem__221(___) fbextPP_SeqElem__220
# define fbextPP_SeqElem__222(___) fbextPP_SeqElem__221
# define fbextPP_SeqElem__223(___) fbextPP_SeqElem__222
# define fbextPP_SeqElem__224(___) fbextPP_SeqElem__223
# define fbextPP_SeqElem__225(___) fbextPP_SeqElem__224
# define fbextPP_SeqElem__226(___) fbextPP_SeqElem__225
# define fbextPP_SeqElem__227(___) fbextPP_SeqElem__226
# define fbextPP_SeqElem__228(___) fbextPP_SeqElem__227
# define fbextPP_SeqElem__229(___) fbextPP_SeqElem__228
# define fbextPP_SeqElem__230(___) fbextPP_SeqElem__229
# define fbextPP_SeqElem__231(___) fbextPP_SeqElem__230
# define fbextPP_SeqElem__232(___) fbextPP_SeqElem__231
# define fbextPP_SeqElem__233(___) fbextPP_SeqElem__232
# define fbextPP_SeqElem__234(___) fbextPP_SeqElem__233
# define fbextPP_SeqElem__235(___) fbextPP_SeqElem__234
# define fbextPP_SeqElem__236(___) fbextPP_SeqElem__235
# define fbextPP_SeqElem__237(___) fbextPP_SeqElem__236
# define fbextPP_SeqElem__238(___) fbextPP_SeqElem__237
# define fbextPP_SeqElem__239(___) fbextPP_SeqElem__238
# define fbextPP_SeqElem__240(___) fbextPP_SeqElem__239
# define fbextPP_SeqElem__241(___) fbextPP_SeqElem__240
# define fbextPP_SeqElem__242(___) fbextPP_SeqElem__241
# define fbextPP_SeqElem__243(___) fbextPP_SeqElem__242
# define fbextPP_SeqElem__244(___) fbextPP_SeqElem__243
# define fbextPP_SeqElem__245(___) fbextPP_SeqElem__244
# define fbextPP_SeqElem__246(___) fbextPP_SeqElem__245
# define fbextPP_SeqElem__247(___) fbextPP_SeqElem__246
# define fbextPP_SeqElem__248(___) fbextPP_SeqElem__247
# define fbextPP_SeqElem__249(___) fbextPP_SeqElem__248
# define fbextPP_SeqElem__250(___) fbextPP_SeqElem__249
# define fbextPP_SeqElem__251(___) fbextPP_SeqElem__250
# define fbextPP_SeqElem__252(___) fbextPP_SeqElem__251
# define fbextPP_SeqElem__253(___) fbextPP_SeqElem__252
# define fbextPP_SeqElem__254(___) fbextPP_SeqElem__253
# define fbextPP_SeqElem__255(___) fbextPP_SeqElem__254

# endif ' include guard
