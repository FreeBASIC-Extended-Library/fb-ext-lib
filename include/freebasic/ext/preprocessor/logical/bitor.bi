'' Title: ext/preprocessor/logical/bitor.bi
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
# ifndef FBEXT_INCLUDED_PP_BITOR_BI__
# define FBEXT_INCLUDED_PP_BITOR_BI__ -1

# define fbextPP_BitOr(a, b) fbextPP_BitOr_##a##b()

# define fbextPP_BitOr_00() 0
# define fbextPP_BitOr_01() 1
# define fbextPP_BitOr_10() 1
# define fbextPP_BitOr_11() 1

'
# define FBEXT_PP_BITOR(a, b) fbextPP_BitOr(a, b)

# endif ' include guard
