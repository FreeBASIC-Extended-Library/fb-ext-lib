''Title: math/random.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Contains code contributed and Copyright (c) 2007, mr_cha0s: ruben.coder@gmail.com
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_MATH_RANDOM
#define FBEXT_MATH_RANDOM

''Namespace: ext.math

#include once "ext/detail/common.bi"
#include once "ext/math/detail/common.bi"

namespace ext.math

	''Function: RndRange
	''Returns an integer within the specified range.
	''
	''Parameters:
	''min_ - the minimum number to return.
	''max - the maximum number to return.
	''getnew - optional parameter to pass to rnd, defaults to 1.
	''
	''Returns:
	''Random integer between min_ and max.
	''
	declare function RndRange overload (byval min_ as integer, byval max as integer, byval getnew as integer = 1) as integer

	''Function: RndRange
	''Returns an double within the specified range.
	''
	''Parameters:
	''min_ - the minimum number to return.
	''max - the maximum number to return.
	''getnew - optional parameter to pass to rnd, defaults to 1.
	''
	''Returns:
	''Random double between min_ and max.
	''
	declare function RndRange overload (byval lower as double, byval upper as double, byval getnew as integer = 1) as double

end namespace

#endif