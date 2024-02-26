''File: perm-comb.bas
''Description: !!Write Me!!
''
''Copyright (c) 2007-2024 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING)

# include once "ext/math.bi"


using ext.math

print "number of 5-card poker hands = " & nPr(52, 5)
print "number of unique 5-card poker hands = " & nCr(52, 5)
