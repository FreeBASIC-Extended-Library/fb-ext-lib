''Title: containers/bloomfilter.bi
''
''About: License
''Copyright (c) 2013, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef __FB_EXT_BLOOMFILTER__
#define __FB_EXT_BLOOMFILTER__ -1

#include once "ext/containers/bitarray.bi"
#include once "ext/hash.bi"

''Namespace: ext
namespace ext

''Class: BloomFilter
''Used to perform a test to see if an item may exist in a more expensive storage location.
''
type BloomFilter

    ''Sub: Default Constructor
    declare constructor( )

    ''Sub: Standard Constructor
    ''
    ''Parameters:
    ''expected - sets the number of items in the set.
    ''
    declare constructor( byval expected as uinteger )

    ''Sub: Copy Constructor
    declare constructor( byref rhs as BloomFilter )
    declare destructor( )

    ''Function: load
    ''Loads a previously saved bloomfilter.
    ''
    ''Parameters:
    ''fname - the file name to load.
    ''
    ''Returns:
    ''True if an error occured.
    ''
    declare function load( byref fname as const string ) as ext.bool

    ''Function: save
    ''Saves the bloomfilter to disk.
    ''
    ''Parameters:
    ''fname - the file to save to.
    ''
    ''Returns:
    ''True if an error occured.
    ''
    declare function save( byref fname as const string ) as ext.bool

    ''Sub: add
    ''Adds a record as existing to the filter.
    ''
    ''Parameters:
    ''x - string representing the item.
    ''
    declare sub add( byref x as const string )

    ''Function: lookup
    ''Checks the filter to see if item may exist in it.
    ''
    ''Parameters:
    ''x - string representing the item.
    ''
    ''Returns:
    ''True if found in the filter.
    ''
    declare function lookup( byref x as const string ) as ext.bool

    'private:
    declare function calc_sizeof_bf( byval n as uinteger, byval p as double ) as uinteger
    declare function calc_numberof_hashes( byval m as uinteger, byval n as uinteger ) as uinteger
    declare sub setExpected( byval n as uinteger )
    m_ba as ext.BitArray ptr
    m_basize as uinteger
    m_hashruns as uinteger
    m_expected as uinteger
end type

end namespace

#endif '__FB_EXT_BLOOMFILTER__
