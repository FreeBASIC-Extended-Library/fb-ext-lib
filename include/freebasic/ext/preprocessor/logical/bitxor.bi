'' Title: ext/preprocessor/logical/bitxor.bi
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
# ifndef FBEXT_INCLUDED_PP_BITXOR_BI__
# define FBEXT_INCLUDED_PP_BITXOR_BI__ -1

# define fbextPP_BitXor(a, b) fbextPP_BitXor_##a##b()

# define fbextPP_BitXor_00() 0
# define fbextPP_BitXor_01() 1
# define fbextPP_BitXor_10() 1
# define fbextPP_BitXor_11() 0

'
# define FBEXT_PP_BITXOR(a, b) fbextPP_BitXor(a, b)

# endif ' include guard
