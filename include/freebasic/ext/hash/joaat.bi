''Title: hash/joaat.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_HASH_JOAAT_BI__
# define FBEXT_HASH_JOAAT_BI__ -1

# include once "ext/detail/common.bi"

''Namespace: ext.hashes

namespace ext.hashes

    ''Function: joaat
    ''Calculates the Jenkins One At A Time hash of a string.
    ''
    ''Parameters:
    ''xStr - string to be hashed.
    ''
    ''Returns:
    ''uinteger containing the hash.
    ''
    declare function joaat overload ( byref xStr as const string ) as uinteger

    ''Function: joaat
    ''Calculates the Jenkins One At A Time hash of a memory buffer.
    ''
    ''Parameters:
    ''src - pointer to memory buffer.
    ''len_b - length of buffer in bytes.
    ''seed - optional value to initialize the hash
    ''
    ''Returns:
    ''uinteger containing the hash.
    ''
    declare function joaat ( byval src as const any ptr, byval len_b as uinteger, byval seed as uinteger = 0 ) as uinteger

    ''Function: joaat64
    ''Calculates the 64 bit Jenkins One At A Time hash of a string.
    ''
    ''Parameters:
    ''xStr - string to be hashed.
    ''
    ''Returns:
    ''ulongint containing the hash.
    ''
    declare function joaat64 overload ( byref xStr as const string ) as ulongint

    ''Function: joaat64
    ''Calculates the 64 bit Jenkins One At A Time hash of a memory buffer.
    ''
    ''Parameters:
    ''src - pointer to memory buffer.
    ''len_b - length of buffer in bytes.
    ''
    ''Returns:
    ''ulongint containing the hash.
    ''
    declare function joaat64 ( byval src as const any ptr, byval len_b as uinteger ) as ulongint

end namespace 'ext.hashes

# endif ' include guard
