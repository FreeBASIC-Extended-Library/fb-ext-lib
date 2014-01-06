''Title: containers/bitarray.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_CONTAINERS_BITARRAY_BI__
# define FBEXT_CONTAINERS_BITARRAY_BI__ -1

# include once "ext/detail/common.bi"

#if not __FB_MT__
    #inclib "ext-containers"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-containers"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#endif

''Namespace: ext
namespace ext

''Class: BitArray
''Represents an arbitrarily long bitfield. Similiar to the C++ STL class
''bitset in that you cannot change its size once created.
''
''See Also:
''<BitArray and You>
''
type BitArray

Public:

    ''Sub: default constructor
    ''Creates a uninitialized bitfield.
    ''
    ''Usage:
    ''You must first use the size method to create a bitfield.
    ''
    declare constructor( )

    ''Function: constructor
    ''Creates a bitfield containing a number of bits.
    ''
    ''Parameters:
    ''num - the number of bits to allocate.
    ''
    declare constructor( byval num as SizeType )

    ''Function: isset
    ''Determines if the specified bit is set or not.
    ''
    ''Parameters:
    ''bit_ - the bit number (0 based) to check.
    ''
    ''Returns:
    ''ext.bool.true if set, ext.bool.false if not, ext.bool.invalid on error.
    ''
    declare function isset( byval bit_ as SizeType ) as ext.bool

    ''Sub: toggle
    ''Toggles the value of a certain bit.
    ''
    ''Parameters:
    ''bit_ - the bit number (0 based) to toggle.
    ''
    declare sub toggle( byval bit_ as SizeType )

    ''Sub: set
    ''Sets the value of a certain bit to 1 or on.
    ''
    ''Parameters:
    ''bit_ - the bit number (0 based) to on.
    ''
    declare sub set( byval bit_ as SizeType )

    ''Sub: reset
    ''Sets the value of a certain bit to 0 or off.
    ''
    ''Parameters:
    ''bit_ - the bit number (0 based) to 0 or off.
    ''
    declare sub reset( byval bit_ as SizeType )

    ''Sub: load
    ''Loads a string containing a bitfield into memory. You must first initialize the bitfield before using this procedure. Note that all 1's are considered 1 and anything else is 0.
    ''
    ''Parameters:
    ''bstring - string containing the bitfield.
    ''
    declare sub load( byref bstring as string )

    ''Sub: binLoad
    ''Loads a binary format bitfield previously output by <dumpBin>
    ''
    ''Parameters:
    ''x - ubyte ptr to the data
    ''len_x - the length in bytes of x
    ''
    declare sub binload( byval x as ubyte ptr, byval len_x as SizeType )

    ''Function: dump
    ''Converts the in memory bitfield into a binary string
    ''
    ''Returns:
    ''string containing the binary dump of the bitfield.
    ''
    declare function dump( ) as string

    ''Sub: dumpBin
    ''Converts the in-memory bitfield into an array for serialization.
    ''
    ''Parameters:
    ''vals - <SizeType> array that will hold the BitArray, includes metadata to allow loading.
    ''
    declare sub dumpbin( vals() as SizeType )

    ''Sub: size
    ''Used to set the initial size of the bitfield, will not work if the num constructor is used.
    ''
    ''Parameters:
    ''num - the size of the bitfield to create, in bits (1 based).
    ''
    declare sub size( byval num as SizeType )

    declare destructor( )

Private:

    m_bits as SizeType ptr
    m_size as SizeType


end type

''Example: BitArray and You
''(begin code)
''#include once "ext/containers/bitarray.bi"
''#include once "ext/strings.bi"
''
''var bitstring = ext.strings.repeat("10", 64)
''ext.strings.shuffle(bitstring)
''
''var bitarray = ext.BitArray(len(bitstring))
''bitarray.load(bitstring)
''print "bits: " & bitarray.dump()
''
''if bitarray.isset(0) then print "bit 0 is set"
''
''bitarray.toggle(30)
''bitarray.toggle(31)
''bitarray.toggle(32)
''print "bits: " & bitarray.dump()
''(end code)
''

end namespace


# endif ' include guard
