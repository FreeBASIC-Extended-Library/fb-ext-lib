'' Title: ext/preprocessor/seq/totuple.bi
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
# ifndef FBEXT_INCLUDED_PP_SEQ_TOTUPLE_BI__
# define FBEXT_INCLUDED_PP_SEQ_TOTUPLE_BI__ -1

# include once "ext/preprocessor/seq/enum.bi"

# define FBEXT_PP_SEQ_TOTUPLE(seq) fbextPP_SeqToTuple(seq)

'' Macro: fbextPP_SeqToTuple
'' Converts a sequence into a tuple.
''
'' Parameters:
'' seq - the sequence to convert
''
'' Returns:
'' Returns the tuple representation of the sequence.
''
'' Description:
'' Given a sequence *(a)(b)(c)(d)*, this macro expands to
'' *(a, b, c, d)*.
# define fbextPP_SeqToTuple(seq) _
         (FBEXT_PP_SEQ_ENUM(seq))

# endif ' include guard
