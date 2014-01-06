''Title: math/npr.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MATH_NPR_BI__
# define FBEXT_MATH_NPR_BI__ -1

# include once "ext/math/detail/common.bi"

'' Namespace: ext.math

namespace ext.math

	'' Function: nPr
	'' Finds the number of permutations of a sub-set of elements of a set.
	''
	'' Parameters:
	'' n - the total number of elements in the set.
	'' r - the number of elements in the sub-set.
	''
	'' Returns:
	'' The number of permutations of size //r// possible from a set of
	'' size //n//.
	declare function nPr (byval n as ulongint, byval r as ulongint) as ulongint

end namespace

# endif
