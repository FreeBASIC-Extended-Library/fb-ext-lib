'' Title: ext/config.bi
''
'' About: License
''  Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONFIG_BI__
# define FBEXT_CONFIG_BI__ -1

# include once "ext/detail/common.bi"
# include once "ext/xml/dom.bi"

#if not __FB_MT__
    #inclib "ext-config"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-config.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

namespace ext.config

declare sub setAppName( byref appn as string )
declare sub setPath( byref path as string )

declare sub load()
declare sub save()

'Basic usage
declare function getBool( byref name_ as string, byval default as bool = false ) as bool
declare function getString( byref name_ as string, byref default as string = "" ) as string
declare function getInteger( byref name_ as string, byval default as integer = 0 ) as integer
declare function getDouble( byref name_ as string, byval default as double = 0.0 ) as double

declare sub getBoolArray( byref name_ as string, byref subname as string, array() as bool )
declare sub getIntegerArray( byref name_ as string, byref subname as string, array() as integer )
declare sub getDoubleArray( byref name_ as string, byref subname as string, array() as double )
declare sub getStringArray( byref name_ as string, byref subname as string, array() as string )

declare sub setBool( byref name_ as string, byval v as bool )
declare sub setString( byref name_ as string, byref v as string )
declare sub setInteger( byref name_ as string, byval v as integer )
declare sub setDouble( byref name_ as string, byval v as double )

declare sub setBoolArray( byref name_ as string, byref subname as string, array() as bool )
declare sub setIntegerArray( byref name_ as string, byref subname as string, array() as integer )
declare sub setDoubleArray( byref name_ as string, byref subname as string, array() as double )
declare sub setStringArray( byref name_ as string, byref subname as string, array() as string )

declare function exists( byref name_ as string ) as bool
declare sub remove( byref name_ as string )

'Advanced usage
declare function get_rawxml( byref name_ as string ) as ext.xml.node ptr

end namespace

#endif
