'' Title: ext/preprocessor/repetition/for.bi
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
# ifndef FBEXT_INCLUDED_PP_REPETITION_FOR_BI__
# define FBEXT_INCLUDED_PP_REPETITION_FOR_BI__ -1

# include "ext/preprocessor/cat.bi"
# include "ext/preprocessor/detail/auto_rec.bi"

# if 0
#    define fbextPP_For(state, pred, op, macro)
# endif

# define FBEXT_PP_FOR fbextPP_For

# define fbextPP_For FBEXT_PP_CAT(fbextPP_For_, FBEXT_PP_AUTO_REC(fbextPP_For_P, 256))

# define fbextPP_For_P(n) FBEXT_PP_CAT(fbextPP_For_CHECK_, fbextPP_For_##n(1, fbextPP_For_SR_P, fbextPP_For_SR_O, fbextPP_For_SR_M))

# define fbextPP_For_SR_P(r, s) s
# define fbextPP_For_SR_O(r, s) 0
# define fbextPP_For_SR_M(r, s) FBEXT_PP_NIL

# include once "ext/preprocessor/repetition/detail/for.bi"

# define fbextPP_For_257(s, p, o, m) FBEXT_PP_ERROR(0x0002)

# define fbextPP_For_CHECK_FBEXT_PP_NIL 1

# define fbextPP_For_CHECK_fbextPP_For_1(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_2(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_3(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_4(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_5(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_6(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_7(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_8(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_9(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_10(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_11(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_12(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_13(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_14(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_15(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_16(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_17(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_18(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_19(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_20(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_21(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_22(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_23(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_24(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_25(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_26(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_27(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_28(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_29(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_30(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_31(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_32(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_33(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_34(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_35(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_36(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_37(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_38(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_39(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_40(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_41(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_42(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_43(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_44(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_45(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_46(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_47(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_48(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_49(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_50(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_51(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_52(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_53(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_54(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_55(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_56(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_57(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_58(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_59(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_60(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_61(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_62(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_63(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_64(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_65(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_66(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_67(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_68(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_69(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_70(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_71(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_72(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_73(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_74(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_75(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_76(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_77(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_78(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_79(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_80(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_81(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_82(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_83(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_84(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_85(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_86(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_87(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_88(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_89(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_90(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_91(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_92(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_93(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_94(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_95(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_96(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_97(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_98(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_99(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_100(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_101(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_102(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_103(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_104(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_105(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_106(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_107(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_108(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_109(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_110(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_111(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_112(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_113(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_114(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_115(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_116(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_117(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_118(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_119(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_120(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_121(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_122(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_123(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_124(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_125(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_126(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_127(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_128(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_129(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_130(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_131(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_132(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_133(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_134(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_135(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_136(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_137(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_138(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_139(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_140(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_141(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_142(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_143(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_144(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_145(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_146(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_147(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_148(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_149(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_150(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_151(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_152(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_153(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_154(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_155(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_156(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_157(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_158(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_159(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_160(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_161(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_162(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_163(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_164(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_165(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_166(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_167(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_168(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_169(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_170(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_171(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_172(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_173(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_174(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_175(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_176(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_177(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_178(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_179(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_180(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_181(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_182(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_183(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_184(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_185(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_186(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_187(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_188(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_189(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_190(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_191(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_192(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_193(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_194(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_195(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_196(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_197(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_198(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_199(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_200(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_201(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_202(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_203(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_204(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_205(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_206(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_207(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_208(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_209(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_210(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_211(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_212(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_213(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_214(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_215(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_216(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_217(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_218(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_219(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_220(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_221(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_222(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_223(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_224(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_225(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_226(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_227(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_228(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_229(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_230(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_231(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_232(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_233(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_234(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_235(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_236(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_237(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_238(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_239(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_240(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_241(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_242(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_243(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_244(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_245(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_246(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_247(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_248(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_249(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_250(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_251(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_252(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_253(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_254(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_255(s, p, o, m) 0
# define fbextPP_For_CHECK_fbextPP_For_256(s, p, o, m) 0

# endif
