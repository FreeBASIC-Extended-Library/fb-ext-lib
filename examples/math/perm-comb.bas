''File: perm-comb.bas
''Description: !!Write Me!!
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/math.bi"


using ext.math

print "number of 5-card poker hands = " & nPr(52, 5)
print "number of unique 5-card poker hands = " & nCr(52, 5)
