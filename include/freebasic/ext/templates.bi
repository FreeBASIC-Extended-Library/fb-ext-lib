'' Title: templates.bi
''
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_TEMPLATES_BI__
# define FBEXT_TEMPLATES_BI__ -1

# include once "ext/detail/common.bi"

    # ifndef fbext_NoBuiltinInstanciations
    # define fbext_NoBuiltinInstanciations() 0
    # endif
    
    # macro fbext_InstanciateForBuiltins__(tname_)
    :
    fbextPP_Iif( fbext_NoBuiltinInstanciations(), _
        fbextPP_TupleEat__2,    _
        fbext_InstanciateMulti  _
        )(tname_, fbext_NumericTypes() (((string))) )
    :
    # endmacro
    
    '' Macro: fbext_TypeName
    ''  Gets the qualified name of *T_*, which is often a template type
    ''  parameter.
    ''
    '' Parameters:
    ''  T_ - a template parameter.
    ''
    ''  *fbext_TypeName* is most often used in template declarations and
    ''  template definitions to transform a template type parameter into an
    ''  identifier suitable for use in statements such as Dim and in procedure
    ''  parameter declarations.
    ''
    ''  For example, *fbext_TypeName((MyNamespace)(MyType))* expands to
    ''  *MyNamespace.MyType*.
    # define fbext_TypeName(T_) fbextPP_SeqCat(fbextPP_SeqForEachI(fbext_TypeName_I, __, T_))
    # define fbext_TypeName_I(__, i, elem) (fbextPP_If(i, .##elem, elem))
    
    '' Macro: fbext_TypeID
    ''  Gets the concatenated name of *T_*, which is often a template type
    ''  parameter.
    ''
    '' Parameters:
    ''  T_ - a template parameter.
    ''
    ''  *fbext_TypeName* is used to transform a template type parameter into an
    ''  identifier suitable for a macro name.
    ''
    ''  For example, *fbext_TypeID((MyNamespace)(MyType))* expands to
    ''  *MyNamespaceMyType*.
    # define fbext_TypeID(T_) _
        fbextPP_SeqCat(T_)
    
    '' Macro: fbext_TID
    ''  Gets the concatenated name of *T_*, which is often a template type
    ''  parameter.
    ''
    '' Parameters:
    ''  tname_ - a template name.
    ''  targs_ - a sequence of one or more template arguments.
    ''
    ''  *fbext_TID* is used to transform a template name and a sequence of
    ''  template arguments into an identifier suitable for a macro name.
    ''
    ''  For example, *fbext_TID((MyNamespace)(MyType))* expands to
    ''  *MyNamespaceMyType*.
    # define fbext_TID(tname_, targs_) _
        fbext_TypeID((tname_) fbextPP_SeqTransform(fbext_TID_O, __, targs_))
    
    # define fbext_TID_O(__, targ_) fbext_TypeID(targ_)
    
    '' Macro: fbext_TemplateID
    # define fbext_TemplateID( tname_, targs_, deftargs_) _
        fbext_TemplateID_I( tname_, fbext_GetTArgsWithDefaults__( targs_, deftargs_) )
    
    # define fbext_TemplateID_I( tname_, targs_) _
        fbext_TID( tname_, targs_)
    
    '' Macro: fbext_TDeclare
    ''  Declares the template *tname_* with *targs_*.
    ''
    '' Parameters:
    ''  tname_ - the name of the template.
    ''  targs_ - a sequence of one or more template arguments.
    ''
    ''  *fbext_TDeclare* expands the macro *tname_*##_Declare with each of the
    ''  elements in *targs_* as arguments. No expansion occurs if
    ''  *tname_*##_Declare is not defined, or if it has already been expanded
    ''  with the given arguments.
    # macro fbext_TDeclare(tname_, targs_)
    :
    # ifndef tname_##_DefaultTArgs
    # define tname_##_DefaultTArgs() targs_
    # endif
    
    fbext_TDeclare_I( _
        fbext_TID(tname_, fbext_GetTArgsWithDefaults__(targs_, tname_##_DefaultTArgs())), _
        tname_, _
        fbext_GetTArgsWithDefaults__(targs_, tname_##_DefaultTArgs()) _
    )
    :
    # endmacro
    
    # macro fbext_TDeclare_I(tid_, tname_, targs_)
    :
    # if defined(tname_##_Declare)
        # ifndef fbext_Declared_##tid_##__
        # define fbext_Declared_##tid_##__
        
        tname_##_Declare(fbextPP_SeqEnum(targs_))
        
        # endif
    # endif
    :
    # endmacro
    
    # define fbext_TArgs__(targs_, deftargs_) targs_
    # define fbext_TArgsWithDefaults__(targs_, deftargs_) targs_ fbextPP_SeqRestN(fbextPP_SeqSize(targs_), deftargs_)
    
    # define fbext_GetTArgsWithDefaults__(targs_, deftargs_) _
        fbextPP_Iif(                                    _
            fbextPP_Equal(                              _
                fbextPP_SeqSize(targs_),                _
                fbextPP_SeqSize(deftargs_)              _
            ),                                          _
            fbext_TArgs__,                              _
            fbext_TArgsWithDefaults__                   _
        )(targs_, deftargs_)
    
    '' Macro: fbext_TDefine
    ''  Defines the template *tname_* with *targs_*.
    ''
    '' Parameters:
    ''  tname_ - the name of the template.
    ''  linkage_ - "public" or "private" specifying, respectively, external or
    ''      internal linkage.
    ''  targs_ - a sequence of one or more template arguments.
    ''
    ''  *fbext_TDefine* expands the macro *tname_*##_Define with *linkage_* and
    ''  each of the elements in *targs_* as arguments. No expansion occurs if
    ''  *tname_*##_Define is not defined, or if it has already been expanded
    ''  with the given arguments.
    # macro fbext_TDefine(tname_, linkage_, targs_)
    :
    # ifndef tname_##_DefaultTArgs
    # define tname_##_DefaultTArgs() targs_
    # endif
    
    fbext_TDefine_I( _
        fbext_TID(tname_, fbext_GetTArgsWithDefaults__(targs_, tname_##_DefaultTArgs())), _
        tname_, _
        linkage_, _
        fbext_GetTArgsWithDefaults__(targs_, tname_##_DefaultTArgs()) _
    )
    :
    # endmacro
    
    # macro fbext_TDefine_I(tid_, tname_, linkage_, targs_)
    :
    # if defined(tname_##_Define)
        # ifndef fbext_Defined_##tid_##__
        # define fbext_Defined_##tid_##__
        
        tname_##_Define(linkage_, fbextPP_SeqEnum(targs_))
        
        # endif
    # endif
    :
    # endmacro
    
    '' Macro: fbext_Instanciate
    ''  Fully instanciates the template *tname_* with arguments *targs_*.
    ''
    '' Parameters:
    ''  tname_ - the name of the template to instanciate.
    ''  targs_ - a sequence of one or more template arguments.
    ''
    ''  *fbext_Instanciate* effectively behaves like,
    ''  (begin code)
    ''  fbext_TDeclare(tname_, targs_)
    ''  fbext_TDefine(tname_, private, targs_)
    ''  (end code)
    # macro fbext_Instanciate(tname_, targs_)
    :
        fbext_TDeclare(tname_, targs_)
        fbext_TDefine(tname_, private, targs_)
    :
    # endmacro
    
    '' Macro: fbext_InstanciateMulti
    ''  Fully instanciates the template *tname_* with each set of arguments
    ''  in *seq_of_targs_*.
    ''
    '' Parameters:
    ''  tname_ - the name of the template to instanciate.
    ''  seq_of_targs_ - a sequence of one or more sequences of one or more
    ''      template arguments.
    ''
    ''  *fbext_InstanciateMulti* effectively behaves like,
    ''  (begin code)
    ''  fbext_Instanciate(tname_, fbextPP_SeqElem(0, seq_of_targs))
    ''  fbext_Instanciate(tname_, fbextPP_SeqElem(1, seq_of_targs))
    ''      ...
    ''  fbext_Instanciate(tname_, fbextPP_SeqElem(N-1, seq_of_targs))
    ''  (end code)
    ''  where *N* is the number of sequences of template arguments in
    ''  *seq_of_targs*.
    # macro fbext_InstanciateMulti(tname_, seq_of_targs_)
    :
        fbextPP_SeqForEach(fbext_Instanciate, tname_, seq_of_targs_)
    :
    # endmacro
    
    '' Macro: fbext_UnsignedIntegralTypes
    '' A preprocessor sequence of unsigned integral types.
    ''
    # define fbext_UnsignedIntegralTypes() _
        (((ubyte)))(((ushort)))(((uinteger)))(((ulongint)))
    
    '' Macro: fbext_SignedIntegralTypes
    '' A preprocessor sequence of signed integral types.
    ''
    # define fbext_SignedIntegralTypes() _
        (((byte)))(((short)))(((integer)))(((longint)))
    
    '' Macro: fbext_IntegralTypes
    '' A preprocessor sequence of integral types.
    ''
    # define fbext_IntegralTypes() _
        fbext_UnsignedIntegralTypes() _
        fbext_SignedIntegralTypes()
    
    '' Macro: fbext_FloatTypes
    '' A preprocessor sequence of floating-point types.
    ''
    # define fbext_FloatTypes() _
        (((single)))(((double)))
    
    '' Macro: fbext_NumericTypes
    '' A preprocessor sequence of numeric types.
    ''
    # define fbext_NumericTypes() _
        fbext_IntegralTypes() _
        fbext_FloatTypes()
    
    # define fbext_BuiltinTypes() _
        fbext_NumericTypes() (((string)))

# endif ' include guard
