'' Title: ext/preprocessor/seq.bi
''  This file is part of the <ext/Preprocessor> library API, and can be
''  directly included by user programs.
''
'' About: License
''  Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''  Copyright (c) 2002, Paul Mensonides
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License
''
''  Distributed under the Boost Software License, Version 1.0. See
''  accompanying file LICENSE_1_0.txt or copy at
''  http://www.boost.org/LICENSE_1_0.txt)

# pragma once
# ifndef FBEXT_INCLUDED_PP_SEQ_BI__
# define FBEXT_INCLUDED_PP_SEQ_BI__

/' lmf: note the order of least recursion '/
# include once "ext/preprocessor/seq/head.bi"
# include once "ext/preprocessor/seq/size.bi"
# include once "ext/preprocessor/seq/elem.bi"
# include once "ext/preprocessor/seq/tail.bi"
# include once "ext/preprocessor/seq/cat.bi"
# include once "ext/preprocessor/seq/enum.bi"
# include once "ext/preprocessor/seq/firstn.bi"
# include once "ext/preprocessor/seq/fromvalue.bi"
# include once "ext/preprocessor/seq/insert.bi"
# include once "ext/preprocessor/seq/popback.bi"
# include once "ext/preprocessor/seq/popfront.bi"
# include once "ext/preprocessor/seq/pushback.bi"
# include once "ext/preprocessor/seq/pushfront.bi"
# include once "ext/preprocessor/seq/replace.bi"
# include once "ext/preprocessor/seq/restn.bi"
# include once "ext/preprocessor/seq/reverse.bi"
# include once "ext/preprocessor/seq/split.bi"
# include once "ext/preprocessor/seq/totuple.bi"
# include once "ext/preprocessor/seq/transform.bi"
# include once "ext/preprocessor/seq/foreach.bi"
# include once "ext/preprocessor/seq/foreachi.bi"
# include once "ext/preprocessor/seq/foldleft.bi"
# include once "ext/preprocessor/seq/foldright.bi"

# endif ' include guard
