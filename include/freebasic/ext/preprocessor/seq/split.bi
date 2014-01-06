'' Title: ext/preprocessor/seq/split.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_SPLIT_BI__
# define FBEXT_INCLUDED_PP_SEQ_SPLIT_BI__ -1

# define FBEXT_PP_SEQ_SPLIT(n, seq) fbextPP_SeqSplit(n, seq)

'' ##### fbextPP_SeqSplit

# define fbextPP_SeqSplit(n, seq) _
         (fbextPP_SeqSplit__##n seq)

# define fbextPP_SeqSplit__1(elem) (elem),
# define fbextPP_SeqSplit__2(elem) (elem) fbextPP_SeqSplit__1
# define fbextPP_SeqSplit__3(elem) (elem) fbextPP_SeqSplit__2
# define fbextPP_SeqSplit__4(elem) (elem) fbextPP_SeqSplit__3
# define fbextPP_SeqSplit__5(elem) (elem) fbextPP_SeqSplit__4
# define fbextPP_SeqSplit__6(elem) (elem) fbextPP_SeqSplit__5
# define fbextPP_SeqSplit__7(elem) (elem) fbextPP_SeqSplit__6
# define fbextPP_SeqSplit__8(elem) (elem) fbextPP_SeqSplit__7
# define fbextPP_SeqSplit__9(elem) (elem) fbextPP_SeqSplit__8
# define fbextPP_SeqSplit__10(elem) (elem) fbextPP_SeqSplit__9
# define fbextPP_SeqSplit__11(elem) (elem) fbextPP_SeqSplit__10
# define fbextPP_SeqSplit__12(elem) (elem) fbextPP_SeqSplit__11
# define fbextPP_SeqSplit__13(elem) (elem) fbextPP_SeqSplit__12
# define fbextPP_SeqSplit__14(elem) (elem) fbextPP_SeqSplit__13
# define fbextPP_SeqSplit__15(elem) (elem) fbextPP_SeqSplit__14
# define fbextPP_SeqSplit__16(elem) (elem) fbextPP_SeqSplit__15
# define fbextPP_SeqSplit__17(elem) (elem) fbextPP_SeqSplit__16
# define fbextPP_SeqSplit__18(elem) (elem) fbextPP_SeqSplit__17
# define fbextPP_SeqSplit__19(elem) (elem) fbextPP_SeqSplit__18
# define fbextPP_SeqSplit__20(elem) (elem) fbextPP_SeqSplit__19
# define fbextPP_SeqSplit__21(elem) (elem) fbextPP_SeqSplit__20
# define fbextPP_SeqSplit__22(elem) (elem) fbextPP_SeqSplit__21
# define fbextPP_SeqSplit__23(elem) (elem) fbextPP_SeqSplit__22
# define fbextPP_SeqSplit__24(elem) (elem) fbextPP_SeqSplit__23
# define fbextPP_SeqSplit__25(elem) (elem) fbextPP_SeqSplit__24
# define fbextPP_SeqSplit__26(elem) (elem) fbextPP_SeqSplit__25
# define fbextPP_SeqSplit__27(elem) (elem) fbextPP_SeqSplit__26
# define fbextPP_SeqSplit__28(elem) (elem) fbextPP_SeqSplit__27
# define fbextPP_SeqSplit__29(elem) (elem) fbextPP_SeqSplit__28
# define fbextPP_SeqSplit__30(elem) (elem) fbextPP_SeqSplit__29
# define fbextPP_SeqSplit__31(elem) (elem) fbextPP_SeqSplit__30
# define fbextPP_SeqSplit__32(elem) (elem) fbextPP_SeqSplit__31
# define fbextPP_SeqSplit__33(elem) (elem) fbextPP_SeqSplit__32
# define fbextPP_SeqSplit__34(elem) (elem) fbextPP_SeqSplit__33
# define fbextPP_SeqSplit__35(elem) (elem) fbextPP_SeqSplit__34
# define fbextPP_SeqSplit__36(elem) (elem) fbextPP_SeqSplit__35
# define fbextPP_SeqSplit__37(elem) (elem) fbextPP_SeqSplit__36
# define fbextPP_SeqSplit__38(elem) (elem) fbextPP_SeqSplit__37
# define fbextPP_SeqSplit__39(elem) (elem) fbextPP_SeqSplit__38
# define fbextPP_SeqSplit__40(elem) (elem) fbextPP_SeqSplit__39
# define fbextPP_SeqSplit__41(elem) (elem) fbextPP_SeqSplit__40
# define fbextPP_SeqSplit__42(elem) (elem) fbextPP_SeqSplit__41
# define fbextPP_SeqSplit__43(elem) (elem) fbextPP_SeqSplit__42
# define fbextPP_SeqSplit__44(elem) (elem) fbextPP_SeqSplit__43
# define fbextPP_SeqSplit__45(elem) (elem) fbextPP_SeqSplit__44
# define fbextPP_SeqSplit__46(elem) (elem) fbextPP_SeqSplit__45
# define fbextPP_SeqSplit__47(elem) (elem) fbextPP_SeqSplit__46
# define fbextPP_SeqSplit__48(elem) (elem) fbextPP_SeqSplit__47
# define fbextPP_SeqSplit__49(elem) (elem) fbextPP_SeqSplit__48
# define fbextPP_SeqSplit__50(elem) (elem) fbextPP_SeqSplit__49
# define fbextPP_SeqSplit__51(elem) (elem) fbextPP_SeqSplit__50
# define fbextPP_SeqSplit__52(elem) (elem) fbextPP_SeqSplit__51
# define fbextPP_SeqSplit__53(elem) (elem) fbextPP_SeqSplit__52
# define fbextPP_SeqSplit__54(elem) (elem) fbextPP_SeqSplit__53
# define fbextPP_SeqSplit__55(elem) (elem) fbextPP_SeqSplit__54
# define fbextPP_SeqSplit__56(elem) (elem) fbextPP_SeqSplit__55
# define fbextPP_SeqSplit__57(elem) (elem) fbextPP_SeqSplit__56
# define fbextPP_SeqSplit__58(elem) (elem) fbextPP_SeqSplit__57
# define fbextPP_SeqSplit__59(elem) (elem) fbextPP_SeqSplit__58
# define fbextPP_SeqSplit__60(elem) (elem) fbextPP_SeqSplit__59
# define fbextPP_SeqSplit__61(elem) (elem) fbextPP_SeqSplit__60
# define fbextPP_SeqSplit__62(elem) (elem) fbextPP_SeqSplit__61
# define fbextPP_SeqSplit__63(elem) (elem) fbextPP_SeqSplit__62
# define fbextPP_SeqSplit__64(elem) (elem) fbextPP_SeqSplit__63
# define fbextPP_SeqSplit__65(elem) (elem) fbextPP_SeqSplit__64
# define fbextPP_SeqSplit__66(elem) (elem) fbextPP_SeqSplit__65
# define fbextPP_SeqSplit__67(elem) (elem) fbextPP_SeqSplit__66
# define fbextPP_SeqSplit__68(elem) (elem) fbextPP_SeqSplit__67
# define fbextPP_SeqSplit__69(elem) (elem) fbextPP_SeqSplit__68
# define fbextPP_SeqSplit__70(elem) (elem) fbextPP_SeqSplit__69
# define fbextPP_SeqSplit__71(elem) (elem) fbextPP_SeqSplit__70
# define fbextPP_SeqSplit__72(elem) (elem) fbextPP_SeqSplit__71
# define fbextPP_SeqSplit__73(elem) (elem) fbextPP_SeqSplit__72
# define fbextPP_SeqSplit__74(elem) (elem) fbextPP_SeqSplit__73
# define fbextPP_SeqSplit__75(elem) (elem) fbextPP_SeqSplit__74
# define fbextPP_SeqSplit__76(elem) (elem) fbextPP_SeqSplit__75
# define fbextPP_SeqSplit__77(elem) (elem) fbextPP_SeqSplit__76
# define fbextPP_SeqSplit__78(elem) (elem) fbextPP_SeqSplit__77
# define fbextPP_SeqSplit__79(elem) (elem) fbextPP_SeqSplit__78
# define fbextPP_SeqSplit__80(elem) (elem) fbextPP_SeqSplit__79
# define fbextPP_SeqSplit__81(elem) (elem) fbextPP_SeqSplit__80
# define fbextPP_SeqSplit__82(elem) (elem) fbextPP_SeqSplit__81
# define fbextPP_SeqSplit__83(elem) (elem) fbextPP_SeqSplit__82
# define fbextPP_SeqSplit__84(elem) (elem) fbextPP_SeqSplit__83
# define fbextPP_SeqSplit__85(elem) (elem) fbextPP_SeqSplit__84
# define fbextPP_SeqSplit__86(elem) (elem) fbextPP_SeqSplit__85
# define fbextPP_SeqSplit__87(elem) (elem) fbextPP_SeqSplit__86
# define fbextPP_SeqSplit__88(elem) (elem) fbextPP_SeqSplit__87
# define fbextPP_SeqSplit__89(elem) (elem) fbextPP_SeqSplit__88
# define fbextPP_SeqSplit__90(elem) (elem) fbextPP_SeqSplit__89
# define fbextPP_SeqSplit__91(elem) (elem) fbextPP_SeqSplit__90
# define fbextPP_SeqSplit__92(elem) (elem) fbextPP_SeqSplit__91
# define fbextPP_SeqSplit__93(elem) (elem) fbextPP_SeqSplit__92
# define fbextPP_SeqSplit__94(elem) (elem) fbextPP_SeqSplit__93
# define fbextPP_SeqSplit__95(elem) (elem) fbextPP_SeqSplit__94
# define fbextPP_SeqSplit__96(elem) (elem) fbextPP_SeqSplit__95
# define fbextPP_SeqSplit__97(elem) (elem) fbextPP_SeqSplit__96
# define fbextPP_SeqSplit__98(elem) (elem) fbextPP_SeqSplit__97
# define fbextPP_SeqSplit__99(elem) (elem) fbextPP_SeqSplit__98
# define fbextPP_SeqSplit__100(elem) (elem) fbextPP_SeqSplit__99
# define fbextPP_SeqSplit__101(elem) (elem) fbextPP_SeqSplit__100
# define fbextPP_SeqSplit__102(elem) (elem) fbextPP_SeqSplit__101
# define fbextPP_SeqSplit__103(elem) (elem) fbextPP_SeqSplit__102
# define fbextPP_SeqSplit__104(elem) (elem) fbextPP_SeqSplit__103
# define fbextPP_SeqSplit__105(elem) (elem) fbextPP_SeqSplit__104
# define fbextPP_SeqSplit__106(elem) (elem) fbextPP_SeqSplit__105
# define fbextPP_SeqSplit__107(elem) (elem) fbextPP_SeqSplit__106
# define fbextPP_SeqSplit__108(elem) (elem) fbextPP_SeqSplit__107
# define fbextPP_SeqSplit__109(elem) (elem) fbextPP_SeqSplit__108
# define fbextPP_SeqSplit__110(elem) (elem) fbextPP_SeqSplit__109
# define fbextPP_SeqSplit__111(elem) (elem) fbextPP_SeqSplit__110
# define fbextPP_SeqSplit__112(elem) (elem) fbextPP_SeqSplit__111
# define fbextPP_SeqSplit__113(elem) (elem) fbextPP_SeqSplit__112
# define fbextPP_SeqSplit__114(elem) (elem) fbextPP_SeqSplit__113
# define fbextPP_SeqSplit__115(elem) (elem) fbextPP_SeqSplit__114
# define fbextPP_SeqSplit__116(elem) (elem) fbextPP_SeqSplit__115
# define fbextPP_SeqSplit__117(elem) (elem) fbextPP_SeqSplit__116
# define fbextPP_SeqSplit__118(elem) (elem) fbextPP_SeqSplit__117
# define fbextPP_SeqSplit__119(elem) (elem) fbextPP_SeqSplit__118
# define fbextPP_SeqSplit__120(elem) (elem) fbextPP_SeqSplit__119
# define fbextPP_SeqSplit__121(elem) (elem) fbextPP_SeqSplit__120
# define fbextPP_SeqSplit__122(elem) (elem) fbextPP_SeqSplit__121
# define fbextPP_SeqSplit__123(elem) (elem) fbextPP_SeqSplit__122
# define fbextPP_SeqSplit__124(elem) (elem) fbextPP_SeqSplit__123
# define fbextPP_SeqSplit__125(elem) (elem) fbextPP_SeqSplit__124
# define fbextPP_SeqSplit__126(elem) (elem) fbextPP_SeqSplit__125
# define fbextPP_SeqSplit__127(elem) (elem) fbextPP_SeqSplit__126
# define fbextPP_SeqSplit__128(elem) (elem) fbextPP_SeqSplit__127
# define fbextPP_SeqSplit__129(elem) (elem) fbextPP_SeqSplit__128
# define fbextPP_SeqSplit__130(elem) (elem) fbextPP_SeqSplit__129
# define fbextPP_SeqSplit__131(elem) (elem) fbextPP_SeqSplit__130
# define fbextPP_SeqSplit__132(elem) (elem) fbextPP_SeqSplit__131
# define fbextPP_SeqSplit__133(elem) (elem) fbextPP_SeqSplit__132
# define fbextPP_SeqSplit__134(elem) (elem) fbextPP_SeqSplit__133
# define fbextPP_SeqSplit__135(elem) (elem) fbextPP_SeqSplit__134
# define fbextPP_SeqSplit__136(elem) (elem) fbextPP_SeqSplit__135
# define fbextPP_SeqSplit__137(elem) (elem) fbextPP_SeqSplit__136
# define fbextPP_SeqSplit__138(elem) (elem) fbextPP_SeqSplit__137
# define fbextPP_SeqSplit__139(elem) (elem) fbextPP_SeqSplit__138
# define fbextPP_SeqSplit__140(elem) (elem) fbextPP_SeqSplit__139
# define fbextPP_SeqSplit__141(elem) (elem) fbextPP_SeqSplit__140
# define fbextPP_SeqSplit__142(elem) (elem) fbextPP_SeqSplit__141
# define fbextPP_SeqSplit__143(elem) (elem) fbextPP_SeqSplit__142
# define fbextPP_SeqSplit__144(elem) (elem) fbextPP_SeqSplit__143
# define fbextPP_SeqSplit__145(elem) (elem) fbextPP_SeqSplit__144
# define fbextPP_SeqSplit__146(elem) (elem) fbextPP_SeqSplit__145
# define fbextPP_SeqSplit__147(elem) (elem) fbextPP_SeqSplit__146
# define fbextPP_SeqSplit__148(elem) (elem) fbextPP_SeqSplit__147
# define fbextPP_SeqSplit__149(elem) (elem) fbextPP_SeqSplit__148
# define fbextPP_SeqSplit__150(elem) (elem) fbextPP_SeqSplit__149
# define fbextPP_SeqSplit__151(elem) (elem) fbextPP_SeqSplit__150
# define fbextPP_SeqSplit__152(elem) (elem) fbextPP_SeqSplit__151
# define fbextPP_SeqSplit__153(elem) (elem) fbextPP_SeqSplit__152
# define fbextPP_SeqSplit__154(elem) (elem) fbextPP_SeqSplit__153
# define fbextPP_SeqSplit__155(elem) (elem) fbextPP_SeqSplit__154
# define fbextPP_SeqSplit__156(elem) (elem) fbextPP_SeqSplit__155
# define fbextPP_SeqSplit__157(elem) (elem) fbextPP_SeqSplit__156
# define fbextPP_SeqSplit__158(elem) (elem) fbextPP_SeqSplit__157
# define fbextPP_SeqSplit__159(elem) (elem) fbextPP_SeqSplit__158
# define fbextPP_SeqSplit__160(elem) (elem) fbextPP_SeqSplit__159
# define fbextPP_SeqSplit__161(elem) (elem) fbextPP_SeqSplit__160
# define fbextPP_SeqSplit__162(elem) (elem) fbextPP_SeqSplit__161
# define fbextPP_SeqSplit__163(elem) (elem) fbextPP_SeqSplit__162
# define fbextPP_SeqSplit__164(elem) (elem) fbextPP_SeqSplit__163
# define fbextPP_SeqSplit__165(elem) (elem) fbextPP_SeqSplit__164
# define fbextPP_SeqSplit__166(elem) (elem) fbextPP_SeqSplit__165
# define fbextPP_SeqSplit__167(elem) (elem) fbextPP_SeqSplit__166
# define fbextPP_SeqSplit__168(elem) (elem) fbextPP_SeqSplit__167
# define fbextPP_SeqSplit__169(elem) (elem) fbextPP_SeqSplit__168
# define fbextPP_SeqSplit__170(elem) (elem) fbextPP_SeqSplit__169
# define fbextPP_SeqSplit__171(elem) (elem) fbextPP_SeqSplit__170
# define fbextPP_SeqSplit__172(elem) (elem) fbextPP_SeqSplit__171
# define fbextPP_SeqSplit__173(elem) (elem) fbextPP_SeqSplit__172
# define fbextPP_SeqSplit__174(elem) (elem) fbextPP_SeqSplit__173
# define fbextPP_SeqSplit__175(elem) (elem) fbextPP_SeqSplit__174
# define fbextPP_SeqSplit__176(elem) (elem) fbextPP_SeqSplit__175
# define fbextPP_SeqSplit__177(elem) (elem) fbextPP_SeqSplit__176
# define fbextPP_SeqSplit__178(elem) (elem) fbextPP_SeqSplit__177
# define fbextPP_SeqSplit__179(elem) (elem) fbextPP_SeqSplit__178
# define fbextPP_SeqSplit__180(elem) (elem) fbextPP_SeqSplit__179
# define fbextPP_SeqSplit__181(elem) (elem) fbextPP_SeqSplit__180
# define fbextPP_SeqSplit__182(elem) (elem) fbextPP_SeqSplit__181
# define fbextPP_SeqSplit__183(elem) (elem) fbextPP_SeqSplit__182
# define fbextPP_SeqSplit__184(elem) (elem) fbextPP_SeqSplit__183
# define fbextPP_SeqSplit__185(elem) (elem) fbextPP_SeqSplit__184
# define fbextPP_SeqSplit__186(elem) (elem) fbextPP_SeqSplit__185
# define fbextPP_SeqSplit__187(elem) (elem) fbextPP_SeqSplit__186
# define fbextPP_SeqSplit__188(elem) (elem) fbextPP_SeqSplit__187
# define fbextPP_SeqSplit__189(elem) (elem) fbextPP_SeqSplit__188
# define fbextPP_SeqSplit__190(elem) (elem) fbextPP_SeqSplit__189
# define fbextPP_SeqSplit__191(elem) (elem) fbextPP_SeqSplit__190
# define fbextPP_SeqSplit__192(elem) (elem) fbextPP_SeqSplit__191
# define fbextPP_SeqSplit__193(elem) (elem) fbextPP_SeqSplit__192
# define fbextPP_SeqSplit__194(elem) (elem) fbextPP_SeqSplit__193
# define fbextPP_SeqSplit__195(elem) (elem) fbextPP_SeqSplit__194
# define fbextPP_SeqSplit__196(elem) (elem) fbextPP_SeqSplit__195
# define fbextPP_SeqSplit__197(elem) (elem) fbextPP_SeqSplit__196
# define fbextPP_SeqSplit__198(elem) (elem) fbextPP_SeqSplit__197
# define fbextPP_SeqSplit__199(elem) (elem) fbextPP_SeqSplit__198
# define fbextPP_SeqSplit__200(elem) (elem) fbextPP_SeqSplit__199
# define fbextPP_SeqSplit__201(elem) (elem) fbextPP_SeqSplit__200
# define fbextPP_SeqSplit__202(elem) (elem) fbextPP_SeqSplit__201
# define fbextPP_SeqSplit__203(elem) (elem) fbextPP_SeqSplit__202
# define fbextPP_SeqSplit__204(elem) (elem) fbextPP_SeqSplit__203
# define fbextPP_SeqSplit__205(elem) (elem) fbextPP_SeqSplit__204
# define fbextPP_SeqSplit__206(elem) (elem) fbextPP_SeqSplit__205
# define fbextPP_SeqSplit__207(elem) (elem) fbextPP_SeqSplit__206
# define fbextPP_SeqSplit__208(elem) (elem) fbextPP_SeqSplit__207
# define fbextPP_SeqSplit__209(elem) (elem) fbextPP_SeqSplit__208
# define fbextPP_SeqSplit__210(elem) (elem) fbextPP_SeqSplit__209
# define fbextPP_SeqSplit__211(elem) (elem) fbextPP_SeqSplit__210
# define fbextPP_SeqSplit__212(elem) (elem) fbextPP_SeqSplit__211
# define fbextPP_SeqSplit__213(elem) (elem) fbextPP_SeqSplit__212
# define fbextPP_SeqSplit__214(elem) (elem) fbextPP_SeqSplit__213
# define fbextPP_SeqSplit__215(elem) (elem) fbextPP_SeqSplit__214
# define fbextPP_SeqSplit__216(elem) (elem) fbextPP_SeqSplit__215
# define fbextPP_SeqSplit__217(elem) (elem) fbextPP_SeqSplit__216
# define fbextPP_SeqSplit__218(elem) (elem) fbextPP_SeqSplit__217
# define fbextPP_SeqSplit__219(elem) (elem) fbextPP_SeqSplit__218
# define fbextPP_SeqSplit__220(elem) (elem) fbextPP_SeqSplit__219
# define fbextPP_SeqSplit__221(elem) (elem) fbextPP_SeqSplit__220
# define fbextPP_SeqSplit__222(elem) (elem) fbextPP_SeqSplit__221
# define fbextPP_SeqSplit__223(elem) (elem) fbextPP_SeqSplit__222
# define fbextPP_SeqSplit__224(elem) (elem) fbextPP_SeqSplit__223
# define fbextPP_SeqSplit__225(elem) (elem) fbextPP_SeqSplit__224
# define fbextPP_SeqSplit__226(elem) (elem) fbextPP_SeqSplit__225
# define fbextPP_SeqSplit__227(elem) (elem) fbextPP_SeqSplit__226
# define fbextPP_SeqSplit__228(elem) (elem) fbextPP_SeqSplit__227
# define fbextPP_SeqSplit__229(elem) (elem) fbextPP_SeqSplit__228
# define fbextPP_SeqSplit__230(elem) (elem) fbextPP_SeqSplit__229
# define fbextPP_SeqSplit__231(elem) (elem) fbextPP_SeqSplit__230
# define fbextPP_SeqSplit__232(elem) (elem) fbextPP_SeqSplit__231
# define fbextPP_SeqSplit__233(elem) (elem) fbextPP_SeqSplit__232
# define fbextPP_SeqSplit__234(elem) (elem) fbextPP_SeqSplit__233
# define fbextPP_SeqSplit__235(elem) (elem) fbextPP_SeqSplit__234
# define fbextPP_SeqSplit__236(elem) (elem) fbextPP_SeqSplit__235
# define fbextPP_SeqSplit__237(elem) (elem) fbextPP_SeqSplit__236
# define fbextPP_SeqSplit__238(elem) (elem) fbextPP_SeqSplit__237
# define fbextPP_SeqSplit__239(elem) (elem) fbextPP_SeqSplit__238
# define fbextPP_SeqSplit__240(elem) (elem) fbextPP_SeqSplit__239
# define fbextPP_SeqSplit__241(elem) (elem) fbextPP_SeqSplit__240
# define fbextPP_SeqSplit__242(elem) (elem) fbextPP_SeqSplit__241
# define fbextPP_SeqSplit__243(elem) (elem) fbextPP_SeqSplit__242
# define fbextPP_SeqSplit__244(elem) (elem) fbextPP_SeqSplit__243
# define fbextPP_SeqSplit__245(elem) (elem) fbextPP_SeqSplit__244
# define fbextPP_SeqSplit__246(elem) (elem) fbextPP_SeqSplit__245
# define fbextPP_SeqSplit__247(elem) (elem) fbextPP_SeqSplit__246
# define fbextPP_SeqSplit__248(elem) (elem) fbextPP_SeqSplit__247
# define fbextPP_SeqSplit__249(elem) (elem) fbextPP_SeqSplit__248
# define fbextPP_SeqSplit__250(elem) (elem) fbextPP_SeqSplit__249
# define fbextPP_SeqSplit__251(elem) (elem) fbextPP_SeqSplit__250
# define fbextPP_SeqSplit__252(elem) (elem) fbextPP_SeqSplit__251
# define fbextPP_SeqSplit__253(elem) (elem) fbextPP_SeqSplit__252
# define fbextPP_SeqSplit__254(elem) (elem) fbextPP_SeqSplit__253
# define fbextPP_SeqSplit__255(elem) (elem) fbextPP_SeqSplit__254
# define fbextPP_SeqSplit__256(elem) (elem) fbextPP_SeqSplit__255

# endif ' include guard
