''File: list.bas
''Description: Demonstration of ext.List object.
''
''Copyright (c) 2007-2014 FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. (See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License)

# include once "ext/containers/list.bi"

private function ToString ( byref list as const ext.fbext_List( ((integer)) ) ) as string

	var result = ""
	var first = list.cBegin()
	var last = list.cEnd()
	
	do while first <> last
		result &= "(" & **first & ")"
		first.Increment()
	loop
	return result

end function

private function IsEven ( byref n as const integer ) as ext.bool
	return 0 = (n mod 2)
end function

		'' ::::: (main)
		var list = ext.fbext_List( ((integer)) )
		
		for n as integer = 1 to 5
			list.PushFront(-n)
			list.PushBack(n)
		next
		print ToString(list)
		
		list.RemoveIf(@IsEven)
		print ToString(list)
