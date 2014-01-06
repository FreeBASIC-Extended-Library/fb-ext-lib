''Title: math/factorial.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_MATH_FACTORIAL_BI__
# define FBEXT_MATH_FACTORIAL_BI__ -1

# include once "ext/math/detail/common.bi"

''Namespace: ext.math

namespace ext.math

	''Function: factorial
	''Computes a factorial number up to <MAX_FACTORIAL>
	''
	''Parameters:
	''n - the number to calculate the factorial of.
	''
	''Returns:
	''The factorial of n.
	''
	declare function factorial (byval n as double) as double

	''Constant: MAX_FACTORIAL
	const MAX_FACTORIAL = 256#

end namespace

# endif
