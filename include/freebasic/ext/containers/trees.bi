''Title: containers/trees.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_CONTAINERS_TREES_BI__
#define FBEXT_CONTAINERS_TREES_BI__ -1

#include once "ext/detail/common.bi"

''Namespace: ext.trees

namespace ext.trees

	''Type: b_node
	''Generic b tree node for implementing a b tree.
	''
	''Description:
	''(begin code)
	''type b_node
	''	_data as any ptr
	''	_val as uinteger
	''	_left as b_node ptr
	''	_right as b_node ptr
	''	_next as b_node ptr
	''end type
	''(end code)
	''
	type b_node
		_data as any ptr
		_val as uinteger
		_left as b_node ptr
		_right as b_node ptr
		_next as b_node ptr
	end type

	''Type: b
	''Generic b tree root node for use with b_node
	''
	''Description:
	''(begin code)
	''type b
	''	_root as b_node ptr
	''	_last as b_node ptr
	''end type
	''(end code)
	''
	type b
		_root as b_node ptr
		_last as b_node ptr
	end type

end namespace ' ext.trees

#endif 'FBEXT_TREES_BI__
