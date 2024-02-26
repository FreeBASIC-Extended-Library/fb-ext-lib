''Title: math/ncr.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# ifndef FBEXT_MATH_NCR_BI__
# define FBEXT_MATH_NCR_BI__ -1

# include once "ext/math/detail/common.bi"

'' Namespace: ext.math

namespace ext.math

	'' Function: nCr
	'' Finds the number of combinations of a sub-set of elements of a set.
	''
	'' Parameters:
	'' n - the total number of elements in the set.
	'' r - the number of elements in the sub-set.
	''
	'' Returns:
	'' The number of combinations of size //r// possible from a set of
	'' size //n//.
	declare function nCr (byval n as ulongint, byval r as ulongint) as ulongint

end namespace

# endif
