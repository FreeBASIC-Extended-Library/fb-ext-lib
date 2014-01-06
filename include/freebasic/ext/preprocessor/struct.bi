'' Title: ext/preprocessor/struct.bi
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
# ifndef FBEXT_INCLUDED_PP_STRUCT_BI__
# define FBEXT_INCLUDED_PP_STRUCT_BI__ -1

# include once "ext/preprocessor/arithmetic.bi"
# include once "ext/preprocessor/array.bi"
# include once "ext/preprocessor/cat.bi"
# include once "ext/preprocessor/comparison.bi"
# include once "ext/preprocessor/control.bi"
# include once "ext/preprocessor/facilities.bi"
# include once "ext/preprocessor/logical.bi"
# include once "ext/preprocessor/punctuation.bi"
# include once "ext/preprocessor/repetition.bi"
# include once "ext/preprocessor/seq.bi"
# include once "ext/preprocessor/stringize.bi"
# include once "ext/preprocessor/tuple.bi"

    ' fixme: put all this somewhere else..
    # define fbextPP_DebugPrint(text) _fbextEmitPrint(text)
    
    # macro _fbextEmitPrint(text)
    :
        # print text
    :
    # endmacro
    
    # macro _fbextEmitDefine(id, paramlist, body)
    :
        # define id##paramlist body
    :
    # endmacro
    
    '' ##### fbext_DefineEnumMacros
    
    # define fbext_DefineEnumMacros(id_, enums_) _
        fbext_DefineEnumMacrosFrom(0, id_, enums_)
    
    '' ##### fbext_DefineEnumMacrosFrom
    
    # define fbext_DefineEnumMacrosFrom(n_, id_, enums_) _
        fbextPP_SeqForEachI(fbext_DefineEnumMacrosFrom_M, (n_, id_), enums_)
    
    # define fbext_DefineEnumMacrosFrom_M(n_id_, i_, enum_) _
        fbext_DefineEnumMacrosFrom_M_I(fbextPP_TupleRemParens(2, n_id_), i_, enum_)
    
    # define fbext_DefineEnumMacrosFrom_M_I(n_, id_, i_, enum_) _
        _fbextEmitDefine(id_##enum_, (), fbextPP_Add(n_, i_))

'' Macro: fbextPP_Struct
''  defines a new preprocessor struct *sname_* with members *mdecls_*.
# macro fbextPP_Struct(sname_, mdecls_)
    fbext_DefineEnumMacros(sname_, fbextPP_SeqTransform(_fbextPP_Struct_T1, __, mdecls_))
    _fbextEmitDefine(_fbext_##sname_##defvalue, (), (sname_, fbextPP_SeqTransform(_fbextPP_Struct_T2, __, mdecls_)))
# endmacro

# define _fbextPP_Struct_T1(__, mdecl_) FBEXT_PP_TUPLE_ELEM(2, 0, mdecl_)
# define _fbextPP_Struct_T2(__, mdecl_) FBEXT_PP_TUPLE_ELEM(2, 1, mdecl_)

'' Macro: fbextPP_StructNew
''  expands to an instance of the struct *sname_*. The instance members are
''  initialized with the initializers in *minits*, if any. Note that *minits_*
''  must have (:) as the first element.
''
'' Parameters:
''  sname_ - is the name of the struct created with <fbextPP_Struct>.
''  minits_ - is a sequence of two-element tuples representing member
''      initializers, and has the form,
''          (member, initvalue)
# define fbextPP_StructNew(sname_, minits_) _
    FBEXT_PP_IIF(fbextPP_Equal(1, fbextPP_SeqSize(minits_)), _
        _fbextPP_StructNew_NoInits, _
        _fbextPP_StructNew_Inits _
    )(sname_, minits_) _
    ''

# define _fbextPP_StructNew_NoInits(sname_, minits_) _fbext_##sname_##defvalue()

# define _fbextPP_StructNew_Inits(sname_, minits_) _
    fbextPP_SeqFoldLeft(_fbextPP_StructNew_O,     _
        _fbext_##sname_##defvalue(),                _
        fbextPP_SeqTail(minits_)                  _
    )                                               _
    ''

# define _fbextPP_StructNew_O(struct_, minit_) _fbextPP_StructNew_O_ex(struct_, fbextPP_TupleRemParens(2, minit_))
# define _fbextPP_StructNew_O_ex(struct_, member_, initvalue_) fbextPP_StructSetMember(struct_, member_, initvalue_)

'' Macro: fbextPP_StructMember
''  expands to the value of the member *member_* of the struct *struct_*.
# define fbextPP_StructMember(struct_, member_) _fbextPP_StructMember_aux(fbextPP_TupleRemParens(2, struct_), member_)

# define _fbextPP_StructMember_aux(sname_, values_, member_) fbextPP_SeqElem(sname_##member_(), values_)

'' Macro: fbextPP_StructSetMember
''  expands to a copy of a struct *struct_* with member *member_* set to
''  *value_*.
# define fbextPP_StructSetMember(struct_, member_, value_) _
    _fbextPP_StructSetMember_aux(fbextPP_TupleRemParens(2, struct_), member_, value_)

# define _fbextPP_StructSetMember_aux(sname_, values_, member_, value_) _
    (sname_, fbextPP_SeqReplace(values_, sname_##member_(), value_))

'' Macro: fbextPP_StructSetMembers
# define fbextPP_StructSetMembers(struct_, memvalues_) _
    fbextPP_SeqFoldLeft(_fbextPP_StructSetMembers_O, struct_, memvalues_)

# define _fbextPP_StructSetMembers_O(struct_, memvalue_) _fbextPP_StructSetMembers_O_I(struct_, fbextPP_TupleRemParens(2, memvalue_))
# define _fbextPP_StructSetMembers_O_I(struct_, member_, value_) _
    fbextPP_StructSetMember(struct_, member_, value_)


# endif ' include guard
