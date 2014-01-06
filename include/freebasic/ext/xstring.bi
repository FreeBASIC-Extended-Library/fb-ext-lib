''Title: XString.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_XSTRING_BI__
# define FBEXT_XSTRING_BI__ -1

# inclib "ext-xstring"

# include once "ext/detail/common.bi"

'' Namespace: ext.strings
namespace ext.strings


	''  Enum: PAD_OPTION
	''
	''  STR_PAD_LEFT - Causes the pad method to pad to the left
	''  STR_PAD_RIGHT - Causes the pad method to pad to the right
	''  STR_PAD_BOTH - Causes the pad method to alternate between right and left padding
	''
	enum PAD_OPTION

		STR_PAD_LEFT
		STR_PAD_RIGHT
		STR_PAD_BOTH

	end enum




	'' Class: XString
	'' Implements: Comparable, Equatable, Printable, Assignable
	''
	'' Enhanced string type fully compatible with standard strings.
	''
	'' Supports the use of the +, &, -(Subtract a substring), -(Negate or reverse)
	'' and the * (repetition of the string) operators.
	''
	type XString

	public:
		'' Sub: default cosntructor
		'' Constructs an XString
		''
		'' Parameters:
		'' text - the text to construct with
		declare constructor ( byref text as const string = "" )

		'' Sub: operator let
		'' Assigns the value of another XString
		''
		'' Parameters:
		'' x - the XString value to assign
		declare operator let ( byref x as const XString )
		declare operator let ( byref x as const string )

		'' Sub: operator +=
		'' Appends the value of an XString
		''
		'' Parameters:
		'' x - the XString value to append
		declare operator += ( byref x as const XString )
		declare operator += ( byref x as const string )

		'' Sub: operator &=
		'' Appends the value of an XString
		''
		'' Parameters:
		'' x - the XString value to append
		declare operator &= ( byref x as const XString )
		declare operator &= ( byref x as const string )

		'' Sub: operator -=
		'' Removes all occurances of a substring
		''
		'' Parameters:
		'' x - the substring to remove
		declare operator -= ( byref x as const XString )
		declare operator -= ( byref x as const string )

		'' Sub: operator *=
		'' Appends the value of the XString a number of times
		''
		'' Parameters:
		'' n - the number of times to append
		declare operator *= ( byval n as ext.SizeType )

		'' Function: Empty
		'' Returns ext.true if empty, ext.false otherwise
		declare const function Empty ( ) as bool

		'' Function: Len
		'' Returns the length, in characters.
		declare const function Len ( ) as ext.SizeType

		'' Function: arg
		'' Substitutes %n with some text.
		declare function arg ( byref x as string ) as xstring

		' FB Built-in string commands
		'' Sub: Trim
		'' Trims whitespace from both sides of the XString object
		declare sub Trim ( )

		'' Sub: LTrim
		'' Trims whitespace from the left side of a XString object
		declare sub LTrim ( )

		'' Sub: RTrim
		'' Trims whitespace from the right side of a XString object
		declare sub RTrim ( )

		'' Function: Instr
		'' Searchs a string for the first occurence of a substring
		''
		'' Parameters:
		'' start - integer value specifying what character position in the string to start the search at.
		'' search - string or XString value specifying the substring to search for.
		''
		'' Returns:
		''
		'' Integer value reflecting the character postition of the first occurence of substring.
		declare function Instr ( byval start as integer = 1, byref search as const string ) as integer

		'' Sub: UCase
		'' Transforms the alphabetical characters into uppercase
		declare sub UCase ( )

		'' Sub: LCase
		'' Transforms the alphabetical characters into lowercase
		declare sub LCase ( )

		'' Function: Left
		'' Returns a string of length characters from the left side of the XString object
		''
		'' Parameters:
		'' length - the number of characters to return
		''
		'' Returns:
		'' Returns the left-most characters.
		declare function Left ( byval length as integer ) as string

		'' Function: Right
		'' Returns a string of length characters from the right side of the XString object
		''
		'' Parameters:
		'' length - the number of characters to return
		''
		'' Returns:
		'' Returns the right-most characters.
		declare function Right ( byval length as integer ) as string

		'' Sub: Mid
		'' Performs an in-object text replace
		''
		'' Parameters:
		'' text - the text you will be putting in
		'' start - the character position in the object to start replacement
		'' length - the amount of characters to replace
		declare sub Mid ( byref text as const string, byval start as integer, byval length as integer )

		'' Function: Mid
		'' Retrieves a portion of the XString object.
		''
		'' Parameters:
		'' start - character position to start at
		'' length - length of string to return, 0 for up to length of XString object
		''
		'' Returns:
		'' A string containing up to length characters from the XString object
		declare function Mid ( byval start as integer, byval length as integer = 0 ) as string

		'' Sub: Replace
		'' Replaces a substring with a string you provide
		''
		'' Parameters:
		'' oldtext - text to search for in the XString object
		'' newtext - text to replace oldtext with
		declare sub Replace ( byref oldtext as const string, byref newtext as const string )

		'' Sub: Replace
		'' Replaces an array of substrings in a XString object
		''
		'' Parameters:
		'' oldtext() - array of substrings to search for in the XString object
		'' newtext - string to replace with
		declare sub Replace ( oldtext() as const string, byref newtext as const string )

		'' Sub: Replace
		'' Replaces an array of substrings in a XString object
		''
		'' Parameters:
		'' oldtext() - array of substrings to search for in the XString object
		'' newtext() - matched array of strings to replace with
		declare sub Replace ( oldtext() as const string, newtext() as const string )

		'' Sub: UCFirst
		'' Capitalizes the first letter in the XString object
		declare sub UCFirst ( )

		'' Sub: LCFirst
		'' Makes the first letter in the XString object lower case
		declare sub LCFirst ( )

		'' Sub: Pad
		'' Pads a XString object with another string, similiar to php's str_pad
		''
		'' Parameters:
		'' length - Final length the string must reach
		'' pad_str - The string to pad the XString object with
		'' opt - Optional Padding behaviour, defaults to <STR_PAD_RIGHT>
		declare sub Pad ( byval length as integer, byref pad_str as const string = " ", byval opt as PAD_OPTION = STR_PAD_RIGHT )

		'' Function: PadCopy
		'' Pads a XString object with another string, similiar to php's str_pad
		''
		'' Parameters:
		'' length - Final length the string must reach
		'' pad_str - The string to pad the XString object with
		'' opt - Optional Padding behaviour, defaults to <STR_PAD_RIGHT>
		''
		'' Returns:
		'' Padded string.
		declare const function PadCopy ( byval length as integer, byref pad_str as const string = " ", byval opt as PAD_OPTION = STR_PAD_RIGHT ) as XString

		'' Sub: Rot13
		'' Performs a rot13 rotation on a XString object
		declare sub Rot13 ( )

		'' Function: Rot13Copy
		'' Performs a rot13 rotation on a XString object
		''
		'' Returns:
		'' rot13 encoded string.
		declare const function Rot13Copy ( ) as XString

		'' Sub: CRC32
		'' Calculates the 32 bit Cyclic Redundancy Check of a XString object and
		'' replaces the string with the hexidecimal representation of the CRC
		declare sub CRC32 ( )

		'' Function: CRC32Copy
		'' Calculates the 32 bit Cyclic Redundancy Check of a XString object
		''
		'' Returns:
		'' Hexidecimal representation of a XString object
		declare const function CRC32Copy ( ) as XString

		'' Function: ReplaceCopy
		'' Performs a text substitution in the XString object
		''
		'' Parameters:
		'' oldtext - the text to search for
		'' newtext - the text to replace with
		''
		'' Returns:
		'' The modified string.
		declare const function ReplaceCopy ( byref oldtext as const string, byref newtext as const string ) as XString

		'' Function: ReplaceCopy
		'' Performs a text substitution in a XString object
		''
		'' Parameters:
		'' oldtext() - array of strings to look for
		'' newtext - text to replace with
		''
		'' Returns:
		'' The modified string.
		declare const function ReplaceCopy ( oldtext() as const string, byref newtext as const string ) as XString

		'' Function: ReplaceCopy
		'' Performs a text substitution in a XString object
		''
		'' Parameters:
		'' oldtext() - array of strings to look for
		'' newtext() - matched array of strings to replace with
		''
		'' Returns:
		'' The modified string.
		declare const function ReplaceCopy ( oldtext() as const string, newtext() as const string ) as XString

		'' Function: Explode
		'' Splits the string into an array.
		''
		'' Parameters:
		'' delimit - The delimiter to use when splitting the array, only first character is used.
		'' res() - string array that results will be passed into.
		''
		'' Returns:
		'' Integer number of delimited strings found.
		declare function Explode ( byref delimit as const string, res() as string ) as integer

		'' Function: Split
		'' Splits the string into an array.
		''
		'' Parameters:
		'' result() - string array for results.
		'' delimiter - the delimiter to use when splitting the string.
		'' limit - the maximum number of strings to split into.
		''
		'' Returns:
		'' Integer number of delimited strings found.
		declare function Split ( result() as string, byref delimiter as const string, byval limit as integer ) as integer


		'' Sub: Shuffle
		'' Randomly shuffles the characters in the string.
		declare sub Shuffle ( )

		'' Function: shuffleCopy
		'' Randomly shuffles the characters in the string
		''
		'' Returns:
		'' XString object containing the modified string
		declare const function ShuffleCopy () as XString

		'' Function: Substr
		'' Returns a portion of a string.
		''
		'' Parameters:
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		''
		'' Returns:
		'' The portion of the string following the offset passed.
		declare function Substr ( byval offset as integer = 0 ) as XString

		'' Function: Substr
		'' Returns a portion of a string.
		''
		'' Parameters:
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		'' length - the number of characters from *offset* to include. if
		'' negative, specifies all but the remaining (-length) characters.
		''
		'' Returns:
		'' The requested sub string.
		declare function Substr ( byval offset as integer, byval length as integer ) as XString

		'' Function: SubstrCompare
		'' Compares a portion of an XString with another.
		''
		'' Parameters:
		'' b - A string.
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		''
		'' Returns:
		'' Returns a negative, zero or positive value if the substring is less
		'' than, equal to or greater than *b*.
		declare const function SubstrCompare ( byref b as const string, byval offset as integer = 0 ) as integer

		'' Function: SubstrCompare
		'' Compares a portion of an XString with another.
		''
		'' Parameters:
		'' b - A string.
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		'' length - the number of characters from *offset* to include. if
		'' negative, specifies all but the remaining (-length) characters.
		''
		'' Returns:
		'' Returns a negative, zero or positive value if the substring is less
		'' than, equal to or greater than *b*.
		declare const function SubstrCompare ( byref b as const string, byval offset as integer, byval length as integer ) as integer

		'' Function: SubstrCount
		'' Finda the number of strings contained in the XString.
		''
		'' Parameters:
		'' needle - substring to search for
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		''
		'' Returns:
		'' The number of substrings found.
		declare const function SubstrCount ( byref needle as const string, byval offset as integer = 0 ) as integer

		'' Function: SubstrCount
		'' Finda the number of strings contained in the XString.
		''
		'' Parameters:
		'' needle - substring to search for
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		'' length - the number of characters from *offset* to include. if
		'' negative, specifies all but the remaining (-length) characters.
		''
		'' Returns:
		'' The number of substrings found.
		declare const function SubstrCount ( byref needle as const string, byval offset as integer, byval length as integer ) as integer

		'' Sub: SubstrReplace
		'' Replaces a portion of the XString with another.
		''
		'' Parameters:
		'' replacement - replacement string
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		declare sub SubstrReplace ( byref replacement as const string, byval offset as integer = 0 )

		'' Sub: SubstrReplace
		'' Replaces a portion of the XString with another.
		''
		'' Parameters:
		'' replacement - replacement string
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		'' length - the number of characters from *offset* to include. if
		'' negative, specifies all but the remaining (-length) characters.
		declare sub SubstrReplace ( byref replacement as const string, byval offset as integer, byval length as integer )

		'' Function: Pos
		'' Find the position of a string in the object
		''
		'' Parameters:
		'' needle - the string to search for.
		'' offset - zero-based offset of substring. if negative, specifies
		'' (*-offset*) chars from the end of the string
		''
		'' Returns:
		'' The first index of the found string.
		declare const function Pos ( byref needle as const string, byval offset as integer = 0 ) as integer

		'' Function: Repeat
		'' Repeats the string a certain number of times.
		''
		'' Parameters:
		'' n - the number of times to repeat
		''
		'' Returns:
		'' The modified XString object
		declare function Repeat ( byval n as integer ) as XString

		'' Sub: Reverse
		'' Reverses the string in-place.
		declare sub Reverse ( )

		'' Function: ReverseCopy
		'' Reverses the string.
		''
		'' Returns:
		'' The modified XString object.
		declare const function ReverseCopy ( ) as XString

		'' Sub: ucwords
		'' Capitalizes every word in the string.
		declare sub UCWords ( )

		'' Function: ucwordsCopy
		'' Capitalizes every word in the string.
		''
		'' Returns:
		'' The modified XString object.
		declare const function UCWordsCopy ( ) as XString

		declare const operator cast ( ) as string

		declare destructor( )
	public:
	' public so the global relational ops have easy access..
		m_str as string

	end type

	' Concatenation operators..
	declare operator & ( byref a as const XString, byref b as const XString ) as XString
	declare operator + ( byref a as const XString, byref b as const XString ) as XString

	' Function operators..
	declare operator - ( byref a as const XString, byref b as const XString ) as XString
	declare operator * ( byref a as const XString, byref rhs as integer ) as XString
	declare operator - ( byref a as const XString ) as XString

	' Relational operators..

	declare operator = ( byref a as const XString, byref b as const XString ) as integer
	declare operator <> ( byref a as const XString, byref b as const XString ) as integer
	declare operator > ( byref a as const XString, byref b as const XString ) as integer
	declare operator < ( byref a as const XString, byref b as const XString ) as integer
	declare operator >= ( byref a as const XString, byref b as const XString ) as integer
	declare operator <= ( byref a as const XString, byref b as const XString ) as integer

	' string procedures..

	'' Function: t
	'' Constructs a <XString> from a String.
	'' Will eventually be used for internationalization.
	declare function t( byref rhs as string ) as xstring


end namespace

# endif ' include guard
