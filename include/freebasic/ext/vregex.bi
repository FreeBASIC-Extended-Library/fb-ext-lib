''Title: vregex.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef __FBEXT_VERBAL_REGULAR_EXPRESSIONS_BI__
#define __FBEXT_VERBAL_REGULAR_EXPRESSIONS_BI__ -1

#include once "ext/detail/common.bi"

#ifndef FBEXT_MISC
#if not __FB_MT__
    #inclib "ext-misc"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-misc.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif
#endif

type pcre__ as pcre
type pcre_extra__ as pcre_extra_

''Namespace: ext
namespace ext

''Class: VRegex
'' Provides a usable human readable wrapper around regular expressions.
''
type VRegex

    ''Sub: Default Constructor
    ''Creates a empty VRegex object.
    ''
    declare constructor()

    ''Sub: Pattern Constructor
    ''Create the VRegex object from an existing regular expression pattern.
    ''
    declare constructor( byref s as const string )

    ''Sub: Copy Constructor
    ''Create a VRegex object that is a clone of another VRegex object.
    ''
    declare constructor( byref rhs as const VRegex )

    ''Sub: Let Operator
    ''Copy one VRegex onto another.
    ''
    declare operator let( byref rhs as const VRegex )

    ''Sub: Destructor
    declare destructor

    ''Function: Cast as String operator
    ''Returns the VRegex object's pattern
    ''
    declare operator cast() as string

    ''Function: replace
    ''Replace text matching the VRegex with a specified string.
    ''
    ''Parameters:
    ''source - The string to replace text in.
    ''v - The string to replace the pattern with.
    ''
    ''Returns:
    ''Copy of the source string with the pattern replaced.
    ''
    declare function replace( byref source as string, byref v as string ) as string

    ''Function: test
    ''Check if the string matches the pattern.
    ''
    ''Parameters:
    ''rhs - the string to test against the pattern.
    ''
    ''Returns:
    ''Boolean
    declare function test( byref rhs as string ) as bool

    ''Function: _then
    ''Add a string to the expression.
    ''
    ''Parameters:
    ''rhs - the string to add
    ''
    ''Returns:
    ''Pointer to the current VRegex object for chaining
    ''
    declare function _then( byref rhs as string ) as VRegex ptr
    declare function startOfLine( byval enable as bool = true ) as VRegex ptr
    declare function endOfLine( byval enable as bool = true ) as VRegex ptr

    ''Function: find
    ''Add a string to the expression.
    ''
    ''Parameters:
    ''rhs - the string to add
    ''
    ''Returns:
    ''Pointer to the current VRegex object for chaining
    ''
    declare function find( byref rhs as string ) as VRegex ptr

    ''Function: maybe
    ''Add a string to the expression that might appear once (or not).
    ''
    ''Parameters:
    ''rhs - the string to search for
    ''
    ''Returns:
    ''Pointer to the current VRegex object for chaining
    ''
    declare function maybe( byref rhs as string ) as VRegex ptr
    declare function anything() as VRegex ptr
    declare function anythingBut( byref rhs as string ) as VRegex ptr
    declare function something() as VRegex ptr
    declare function somethingBut( byref rhs as string ) as VRegex ptr
    declare function lineBreak() as VRegex ptr
    declare function br() as VRegex ptr
    declare function tab() as VRegex ptr
    declare function word() as VRegex ptr
    declare function anyOf( byref rhs as string ) as VRegex ptr
    declare function _any( byref rhs as string ) as VRegex ptr
    declare function range( args() as string ) as VRegex ptr
    declare function addModifier( byref i as string ) as VRegex ptr
    declare function removeModifier( byref i as string ) as VRegex ptr
    declare function withAnyCase( byval enable as bool = true ) as VRegex ptr
    declare function searchOneLine( byval enable as bool = true ) as VRegex ptr
    declare function searchGlobal( byval enable as bool = true ) as VRegex ptr
    declare function multiple( byref rhs as string ) as VRegex ptr
    declare function alt( byref rhs as string ) as VRegex ptr

    private:
        as zstring ptr error_string
        as integer error_offset
        declare function add( byref rhs as string ) as VRegex ptr
        declare function checkFlags() as uinteger
        declare function reduceLines( byref rhs as string ) as string
        declare sub compile()
        dirty as bool
        re as pcre__ ptr
        re_study as pcre_extra__ ptr
        is_multiline as bool
        is_case_sensitive as bool
        prefixes as string
        source as string
        suffixes as string
        pattern as string
        modifiers as uinteger
end type

declare operator = ( byref lhs as VRegex, byref rhs as VRegex ) as integer
declare operator <> ( byref lhs as VRegex, byref rhs as VRegex ) as integer

end namespace

#endif '__FBEXT_VERBAL_REGULAR_EXPRESSIONS_BI__
