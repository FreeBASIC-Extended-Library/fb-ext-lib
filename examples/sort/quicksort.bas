''File: bubble.bas
''Description: Demonstration of ext.sort.bubble function.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/algorithms/quicksort.bi"

type Rational
	declare constructor (byval num as integer, byval den as integer = 1)
	as integer num, den
end type

constructor Rational (byval num as integer, byval den as integer)
	this.num = num
	this.den = den
end constructor

' ext.algorithms.quickSort requires objects to be less than comparable.
operator < (byref lhs as const Rational, byref rhs as const Rational) as ext.bool
	return (lhs.num / lhs.den) < (rhs.num / rhs.den)
end operator

	' Generate the code for QuickSort using the Ext Template System.
    fbext_Instanciate(fbext_quickSort, ((Rational)))
	
		'' ::::: (main)
		dim rationals1(8) as Rational = _
		{ _
			Rational(1, 2), _
			Rational(1, 4), _
			Rational(3, 4), _
			Rational(1, 3), _
			Rational(7, 8), _
			Rational(6, 13), _
			Rational(1, 5), _
			Rational(2, 5), _
			Rational(1, 32) _
		}

		var timein = timer
		ext.quickSort(rationals1())
		var timeout = timer
		
		print "QuickSort: ";
		for r as integer = 0 to 8
			print rationals1(r).num & "/" & rationals1(r).den & "   " ;
		next
		print
		print using "Time Taken for sort: ##.###### seconds."; timeout - timein
