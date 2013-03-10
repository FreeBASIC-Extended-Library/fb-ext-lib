'' Title: ext/config.bi
''
'' About: License
''  Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''
''  Distributed under the FreeBASIC Extended Library Group license. See
''  accompanying file LICENSE.txt or copy at
''  http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef __FB_EXT_JSON__
#define __FB_EXT_JSON__ -1

#include once "ext/detail/common.bi"

#if not __FB_MT__
    #inclib "ext-json"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-json.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

namespace ext.json

    enum jvalue_type
        jnull = 0
        jobject
        jstring
        array
        number
        boolean
    end enum

    type jarray_f as JSONarray
    type jobject_f as JSONobject

    type JSONvalue
        public:
        declare constructor( byval n as double )
        declare constructor( byref x as const string )
        declare constructor( byval b as bool )
        declare constructor( byval o as jobject_f ptr )
        declare constructor( byval a as jarray_f ptr )
        declare constructor()

        declare function valueType() as jvalue_type

        declare function getString() as string
        declare function getNumber() as double
        declare function getBool() as bool
        declare function getObject() as jobject_f ptr
        declare function getArray() as jarray_f ptr

        declare operator cast () as string

        declare destructor
        private:
        as double m_number
        as string m_string
        as bool m_bool
        m_child as any ptr
        m_type as jvalue_type
    end type

    type JSONpair
        declare constructor( byref k as const string, byval v as JSONvalue ptr )
        as string key
        as JSONvalue ptr value
        declare destructor
        declare operator cast () as string
    end type

    type JSONobject
        public:
        declare function loadString( byref jstr as const string ) as JSONobject ptr
        declare function addChild( byref k as const string, byval v as JSONvalue ptr ) as JSONvalue ptr
        declare function child( byref c as const string ) as JSONvalue ptr
        declare function children() as uinteger
        declare destructor
        declare operator cast () as string
        private:
        m_child as JSONpair ptr ptr
        m_children as uinteger

    end type

    type JSONarray
        public:
        declare constructor( byval i as JSONvalue ptr ptr, byval i_len as uinteger )
        declare function at( byval index as uinteger ) as JSONvalue ptr
        declare function length() as uinteger
        declare operator cast () as string
        declare destructor
        private:
        m_child as JSONvalue ptr ptr
        m_children as uinteger
    end type

end namespace

#endif
