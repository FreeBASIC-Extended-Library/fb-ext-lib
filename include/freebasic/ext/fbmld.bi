''Title: fbmld.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
'' fbmld (FB Memory Leak Detector) version 0.6
''
'' Copyright (C) 2006 Daniel R. Verkamp http://drv.nu/
''
'' Tree storage implemented by yetifoot
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License
''
''Usage:
''This file implements the FreeBASIC Memory Leak Detector.
''
''You do not need to explicitly include this file in your project to use it,
''
''it is included automatically. To use the features of this file, you must
''
''define FBEXT_USE_MLD before including any Extended Library headers.
''(start code)
''#define FBEXT_USE_MLD
''#include "ext/strings.bi"
''using ext
''print "This is a program believed to have memory leaks."
''(end code)
''

# pragma once
#ifndef __FBMLD__
#define __FBMLD__

#ifdef FBEXT_USE_MLD

#include once "crt.bi"

#undef allocate
#undef callocate
#undef reallocate
#undef deallocate

#define allocate(bytes) fbmld_allocate((bytes), __FILE__, __LINE__)
#define callocate(bytes) fbmld_callocate((bytes), __FILE__, __LINE__)
#define reallocate(pt, bytes) fbmld_reallocate((pt), (bytes), __FILE__, __LINE__, #pt)
#define deallocate(pt) fbmld_deallocate((pt), __FILE__, __LINE__, #pt)

type fbmld_t
	pt      as any ptr
	bytes   as uinteger
	file    as string
	linenum as integer
	left    as fbmld_t ptr
	right   as fbmld_t ptr
end type

common shared fbmld_tree as fbmld_t ptr
common shared fbmld_mutex as any ptr
common shared fbmld_instances as integer

private sub fbmld_print(byref s as string)
	fprintf(stderr, "(FBMLD) " & s & chr(10))
end sub
 
private sub fbmld_mutexlock( )
#ifdef FBEXT_MULTITHREADED
	mutexlock(fbmld_mutex)
#endif
end sub

private sub fbmld_mutexunlock( )
#ifdef FBEXT_MULTITHREADED
	mutexunlock(fbmld_mutex)
#endif
end sub

 
private function new_node _
	( _
		byval pt      as any ptr, _
		byval bytes   as uinteger, _
		byref file    as string, _
		byval linenum as integer _
	) as fbmld_t ptr

	dim as fbmld_t ptr node = calloc(1, sizeof(fbmld_t))

	node->pt = pt
	node->bytes = bytes
	node->file = file
	node->linenum = linenum
	node->left = NULL
	node->right = NULL
	
	function = node

end function
 
private sub free_node _
	( _
		byval node as fbmld_t ptr _
	)

	node->file = ""
	free( node )

end sub

private function fbmld_search _
	( _
		byval root    as fbmld_t ptr ptr, _
		byval pt      as any ptr _
	) as fbmld_t ptr ptr

	dim as fbmld_t ptr ptr node = root
	dim as any ptr a = pt, b = any
	
	asm
		mov eax, dword ptr [a]
		bswap eax
		mov dword ptr [a], eax
	end asm
	
	while *node <> NULL
		b = (*node)->pt
		asm
			mov eax, dword ptr [b]
			bswap eax
			mov dword ptr [b], eax
		end asm
		if a < b then
			node = @(*node)->left
		elseif a > b then
			node = @(*node)->right
		else
			exit while
		end if
	wend
	
	function = node

end function

private sub fbmld_insert _
	( _
		byval root    as fbmld_t ptr ptr, _
		byval pt      as any ptr, _
		byval bytes   as uinteger, _
		byref file    as string, _
		byval linenum as integer _
	)

	dim as fbmld_t ptr ptr node = fbmld_search(root, pt)

	if *node = NULL then
		*node = new_node( pt, bytes, file, linenum )
	end if

end sub

private sub fbmld_swap _
	( _
		byval node1 as fbmld_t ptr ptr, _
		byval node2 as fbmld_t ptr ptr _
	)

	swap (*node1)->pt,      (*node2)->pt
	swap (*node1)->bytes,   (*node2)->bytes
	swap (*node1)->file,    (*node2)->file
	swap (*node1)->linenum, (*node2)->linenum

end sub

private sub fbmld_delete _
	( _
		byval node as fbmld_t ptr ptr _
	)

	dim as fbmld_t ptr old_node = *node
	dim as fbmld_t ptr ptr pred

	if (*node)->left = NULL then
		*node = (*node)->right
		free_node( old_node )
	elseif (*node)->right = NULL then
		*node = (*node)->left
		free_node( old_node )
	else
		pred = @(*node)->left
		while (*pred)->right <> NULL
			pred = @(*pred)->right
		wend
		fbmld_swap( node, pred )
		fbmld_delete( pred )
	end if

end sub

private sub fbmld_init _
	( _
	) constructor 101

	if fbmld_instances = 0 then
#ifdef FBEXT_MULTITHREADED
		fbmld_mutex = mutexcreate()
#endif
	end if
	fbmld_instances += 1
end sub

private sub fbmld_tree_clean _
	( _
		byval node as fbmld_t ptr ptr _
	)

	if *node <> NULL then
		fbmld_tree_clean( @((*node)->left) )
		fbmld_tree_clean( @((*node)->right) )
		fbmld_print( "error: " & (*node)->bytes & " bytes allocated at " & (*node)->file & ":" & (*node)->linenum & " [&H" & hex( (*node)->pt, 8 ) & "] not deallocated" )
		(*node)->file = ""
		free( (*node)->pt )
		free( *node )
		*node = NULL
	end if
end sub

private sub fbmld_exit _
	( _
	) destructor 101

	fbmld_instances -= 1
	
	if fbmld_instances = 0 then
		
		if fbmld_tree <> NULL then
			fbmld_print("---- memory leaks ----")
			fbmld_tree_clean(@fbmld_tree)
		else
			fbmld_print("all memory deallocated")
		end if
		
#ifdef FBEXT_MULTITHREADED
		if fbmld_mutex <> 0 then
			mutexdestroy(fbmld_mutex)
			fbmld_mutex = 0
		end if
#endif
	
	end if

end sub

private function fbmld_allocate(byval bytes as uinteger, byref file as string, byval linenum as integer) as any ptr
	dim ret as any ptr = any
	
	fbmld_mutexlock()
	
	if bytes = 0 then
		fbmld_print("warning: allocate(0) called at " & file & ":" & linenum & "; returning NULL")
		ret = 0
	else
		ret = malloc(bytes)
		fbmld_insert(@fbmld_tree, ret, bytes, file, linenum)
	end if
	
	fbmld_mutexunlock()
	
	return ret
end function

private function fbmld_callocate(byval bytes as uinteger, byref file as string, byval linenum as integer) as any ptr
	dim ret as any ptr = any
	
	fbmld_mutexlock()
	
	if bytes = 0 then
		fbmld_print("warning: callocate(0) called at " & file & ":" & linenum & "; returning NULL")
		ret = 0
	else
		ret = calloc(1, bytes)
		fbmld_insert(@fbmld_tree, ret, bytes, file, linenum)
	end if
	
	fbmld_mutexunlock()
	
	return ret
end function

private function fbmld_reallocate(byval pt as any ptr, byval bytes as uinteger, byref file as string, byval linenum as integer, byref varname as string) as any ptr
	dim ret as any ptr = any
	dim node as fbmld_t ptr ptr = any
	
	fbmld_mutexlock()
	
	node = fbmld_search(@fbmld_tree, pt)
	
	if pt = NULL then
		if bytes = 0 then
			fbmld_print("error: reallocate(" & varname & " [NULL] , 0) called at " & file & ":" & linenum)
			ret = NULL
		else
			ret = malloc(bytes)
			fbmld_insert(@fbmld_tree, ret, bytes, file, linenum)
		end if
	elseif *node = NULL then
		fbmld_print("error: invalid reallocate(" & varname & " [&H" & hex(pt, 8) & "] ) at " & file & ":" & linenum)
		ret = NULL
	elseif bytes = 0 then
		fbmld_print("warning: reallocate(" & varname & " [&H" & hex(pt, 8) & "] , 0) called at " & file & ":" & linenum & "; deallocating")
		free(pt)
		if *node <> NULL then fbmld_delete(node)
		ret = NULL
	else
		ret = realloc(pt, bytes)
		
		if ret = pt then
			(*node)->bytes = bytes
			(*node)->file = file
			(*node)->linenum = linenum
		else
			fbmld_delete(node)
			fbmld_insert(@fbmld_tree, ret, bytes, file, linenum)
		end if
	end if
	
	fbmld_mutexunlock()
	
	return ret
end function

private sub fbmld_deallocate(byval pt as any ptr, byref file as string, byval linenum as integer, byref varname as string)
	dim node as fbmld_t ptr ptr
	
	fbmld_mutexlock()
	
	if pt = NULL then
		fbmld_print("warning: deallocate(" & varname & " [NULL] ) at " & file & ":" & linenum)
	else
		node = fbmld_search(@fbmld_tree, pt)
		
		if *node = NULL then
			fbmld_print("error: invalid deallocate(" & varname & " [&H" & hex(pt, 8) & "] ) at " & file & ":" & linenum)
		else
			fbmld_delete(node)
			free(pt)
		end if
	end if
	
	fbmld_mutexunlock()
end sub

#endif 'ifdef FBEXT_USE_MLD

#endif '' __FBMLD__
