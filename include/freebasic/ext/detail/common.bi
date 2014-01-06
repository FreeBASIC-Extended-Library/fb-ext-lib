'' About: License
'' Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifdef FBEXT_NO_EXTERNAL_LIBS
    #define FBEXT_NO_LIBZ -1
    #define FBEXT_NO_LIBJPG -1
    #define FBEXT_NO_LIBFREETYPE -1
#endif

# pragma once
# ifndef FBEXT_DETAIL_COMMON_BI__
# define FBEXT_DETAIL_COMMON_BI__ -1

#if not __FB_MT__
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

' All standard headers include the preprocessor macros..
# include once "ext/preprocessor.bi"
# include once "ext/templates.bi"
# include once "ext/fbmld.bi"

'' Title: Usage
'' This file is automatically included and is required by all headers.
''
'' Namespace: ext
'' Contains global constants and enums.
namespace ext

'To fix issues with other headers we need to undef true and false
#undef true
#undef false

    '' Enum: bool
    '' Defines library wide boolean values.
    ''
    '' false - 0
    '' true - -1
    '' ctrue - 1
    '' invalid - not defined as a number
    ''
    enum bool
        false = 0
        true = not false
        ctrue = 1
        invalid
    end enum

    #ifndef null
    '' Constant: null
    '' Constant definition of null
    const null = cast(any ptr, 0)
    #endif

    '' Constant: FBEXT_MAJOR_VERSION
    ''The major (0.x.x) version of the library.
    const FBEXT_MAJOR_VERSION = 0

    '' Constant: FBEXT_MINOR_VERSION
    ''The minor (x.0.x) version of the library.
    const FBEXT_MINOR_VERSION = 5

    '' Constant: FBEXT_PATCH_VERSION
    ''The patch (x.x.0) version of the library.
    const FBEXT_PATCH_VERSION = 0

    '' Constant: FBEXT_VERSION
    ''Integer representation of the library version.
    const FBEXT_VERSION = (FBEXT_MAJOR_VERSION shl 16) OR (FBEXT_MINOR_VERSION shl 8) OR FBEXT_PATCH_VERSION

    '' Constant: FBEXT_VERSION_STRING
    '' String containing the full Extended Library version.
    const FBEXT_VERSION_STRING = "FreeBASIC Extended Standard Library " & FBEXT_MAJOR_VERSION & "." & FBEXT_MINOR_VERSION & "." & FBEXT_PATCH_VERSION

    ''Constant: FBEXT_MIN_BYTE
    ''Minimum allowed value in a Byte type.
    const FBEXT_MIN_BYTE as byte = -((2^(sizeof(byte)*8))/2)

    ''Constant: FBEXT_MAX_BYTE
    ''Maximum allowed value in a Byte type.
    const FBEXT_MAX_BYTE as byte = ((2^(sizeof(byte)*8))/2)-1

    ''Constant: FBEXT_MIN_UBYTE
    ''Minimum allowed value in a UByte type.
    const as ubyte FBEXT_MIN_UBYTE = 0

    ''Constant: FBEXT_MAX_UBYTE
    ''Maximum allowed value in a UByte type.
    const as ubyte FBEXT_MAX_UBYTE = (2^(sizeof(ubyte)*8))-1

    ''Constant: FBEXT_MIN_SHORT
    ''Minimum allowed value in a Short type.
    const as short FBEXT_MIN_SHORT = -((2^(sizeof(short)*8))/2)

    ''Constant: FBEXT_MAX_SHORT
    ''Maximum allowed value in a Short type.
    const as short FBEXT_MAX_SHORT = ((2^(sizeof(short)*8))/2)-1

    ''Constant: FBEXT_MIN_USHORT
    ''Minimum allowed value in a UShort type.
    const as ushort FBEXT_MIN_USHORT = 0

    ''Constant: FBEXT_MAX_USHORT
    ''Maximum allowed value in a UShort type.
    const as ushort FBEXT_MAX_USHORT = (2^(sizeof(ushort)*8))-1

    ''Constant: FBEXT_MIN_INTEGER
    ''Minimum allowed value in a Integer type.
    const as integer FBEXT_MIN_INTEGER = -((2^(sizeof(integer)*8))/2)

    ''Constant: FBEXT_MAX_INTEGER
    ''Maximum allowed value in a Integer type.
    const as integer FBEXT_MAX_INTEGER = ((2^(sizeof(integer)*8))/2)-1

    ''Constant: FBEXT_MIN_UINTEGER
    ''Minimum allowed value in a UInteger type.
    const as uinteger FBEXT_MIN_UINTEGER = 0

    ''Constant: FBEXT_MAX_UINTEGER
    ''Maximum allowed value in a UInteger type.
    const as uinteger FBEXT_MAX_UINTEGER = (2^(sizeof(uinteger)*8))-1

    ''Constant: FBEXT_MIN_LONG
    ''Minimum allowed value in a Long type.
    const as long FBEXT_MIN_LONG = -((2^(sizeof(long)*8))/2)

    ''Constant: FBEXT_MAX_LONG
    ''Maximum allowed value in a Long type.
    const as long FBEXT_MAX_LONG = ((2^(sizeof(long)*8))/2)-1

    ''Constant: FBEXT_MIN_ULONG
    ''Minimum allowed value in a ULong type.
    const as ulong FBEXT_MIN_ULONG = 0

    ''Constant: FBEXT_MAX_ULONG
    ''Maximum allowed value in a ULong type.
    const as ulong FBEXT_MAX_ULONG = (2^(sizeof(ulong)*8))-1

    ''Constant: FBEXT_MIN_LONGINT
    ''Minimum allowed value in a LongInt type.
    const as longint FBEXT_MIN_LONGINT = -((2^(sizeof(longint)*8))/2)

    ''Constant: FBEXT_MAX_LONGINT
    ''Maxmimum allowed value in a LongInt type.
    const as longint FBEXT_MAX_LONGINT =  ((2^(sizeof(longint)*8))/2)-1

    ''Constant: FBEXT_MIN_ULONGINT
    ''Minimum allowed value in a ULongInt type.
    const as ulongint FBEXT_MIN_ULONGINT = 0

    ''Constant: FBEXT_MAX_ULONGINT
    ''Maximum allowed value in a ULongInt type.
    const as ulongint FBEXT_MAX_ULONGINT = 2^(sizeof(ulongint)*8)-1


    ''Type: SizeType
    ''Globally used type when defining the Size of an object.
    ''
    type SizeType as uinteger

    '' Macro: FBEXT_IS_UNSIGNED
    '' Determines if a type is an intrinsic unsigned integral type.
    ''
    '' Parameters:
    '' T_ - A type.
    ''
    '' Returns:
    '' Returns a boolean expression that can be used in preprocessor #if
    '' (and it's variants) statements.
    ''
    # define FBEXT_IS_UNSIGNED(T_) _
        ( _
            (typeof(T_) = typeof(ubyte)) or (typeof(T_) = typeof(ushort)) or (typeof(T_) = typeof(uinteger)) or (typeof(T_) = typeof(ulong)) or (typeof(T_) = typeof(ulongint)) _
        )

    '' Macro: FBEXT_IS_SIGNED
    '' Determines if a type is an intrinsic signed integral type.
    ''
    '' Parameters:
    '' T_ - A type.
    ''
    '' Returns:
    '' Returns a boolean expression that can be used in preprocessor #if
    '' (and it's variants) statements.
    ''
    # define FBEXT_IS_SIGNED(T_) _
        ( _
            (typeof(T_) = typeof(byte)) or (typeof(T_) = typeof(short)) or (typeof(T_) = typeof(integer)) or (typeof(T_) = typeof(long)) or (typeof(T_) = typeof(longint)) _
        )

    '' Macro: FBEXT_IS_INTEGRAL
    '' Determines if a type is an intrinsic integral type.
    ''
    '' Parameters:
    '' T_ - A type.
    ''
    '' Returns:
    '' Returns a boolean expression that can be used in preprocessor #if
    '' (and it's variants) statements.
    ''
    # define FBEXT_IS_INTEGRAL(T_) (FBEXT_IS_UNSIGNED(T_) or FBEXT_IS_SIGNED(T_))

    '' Macro: FBEXT_IS_FLOATINGPOINT
    '' Determines if a type is an intrinsic floating-point type.
    ''
    '' Parameters:
    '' T_ - A type.
    ''
    '' Returns:
    '' Returns a boolean expression that can be used in preprocessor #if
    '' (and it's variants) statements.
    ''
    # define FBEXT_IS_FLOATINGPOINT(T_) ((typeof(T_) = typeof(single)) or (typeof(T_) = typeof(double)))

    '' Macro: FBEXT_IS_NUMERIC
    '' Determines if a type is an intrinsic numeric type.
    ''
    '' Parameters:
    '' T_ - A type.
    ''
    '' Returns:
    '' Returns a boolean expression that can be used in preprocessor #if
    '' (and it's variants) statements.
    ''
    # define FBEXT_IS_NUMERIC(T_) (FBEXT_IS_INTEGRAL(T_) or FBEXT_IS_FLOATINGPOINT(T_))

    '' Macro: FBEXT_IS_INTRINSIC
    '' Determines if a type is an instrinic type.
    ''
    '' Parameters:
    '' T_ - A type.
    ''
    '' Returns:
    '' Returns a boolean expression that can be used in preprocessor #if
    '' (and it's variants) statements.
    ''
    # define FBEXT_IS_INTRINSIC(T_) (FBEXT_IS_NUMERIC(T_) or (T_ = string))

    '' Macro: FBEXT_IS_SIMPLE
    '' Determines a type's simplicity (a type is simple if it is an intrinsic
    '' type that can be bit-copied).
    ''
    '' Parameters:
    '' T_ - A type.
    ''
    '' Returns:
    '' Returns a boolean expression that can be used in preprocessor #if
    '' (and it's variants) statements.
    ''
    # define FBEXT_IS_SIMPLE(T_) (FBEXT_IS_NUMERIC(T_))

    # define FBEXT_IS_STRING(T_) (typeof( T_) = string)

end namespace

# endif ' include guard
