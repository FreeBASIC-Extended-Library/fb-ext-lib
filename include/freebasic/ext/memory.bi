''Title: memory.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_MEMORY_BI__
# define FBEXT_MEMORY_BI__ -1

#if not __FB_MT__
	#inclib "ext-memory"
	#ifdef FBEXT_MULTITHREADED
		#error "The multithreaded version of the library must be built using the -mt compiler option."
	#endif
#else
	#inclib "ext-memory.mt"
	#ifndef FBEXT_MULTITHREADED
		#define FBEXT_MULTITHREADED 1
	#endif
#endif

# include once "ext/memory/construct.bi"

# include once "ext/memory/scopedptr.bi"
# include once "ext/memory/scopedptrarray.bi"
# include once "ext/memory/sharedptr.bi"
# include once "ext/memory/sharedarray.bi"

# include once "ext/memory/arrays.bi"

# include once "ext/memory/allocate.bi"

namespace ext

	'' Function: SetPlacementAddress
	'' Sets a new address that is used for in-place construction and
	'' destruction of objects.
	''
	'' Parameters:
	'' p - The new placement address.
	'
	'' Returns:
	'' Returns the previous placement address.
	''
	declare function SetPlacementAddress ( byval p as any ptr ) as any ptr

	'' Macro: FBEXT_DECLARE_PLACEMENT_NEWDEL
	'' Declares member operators new and delete. This macro should only be
	'' used inside TYPE or CLASS definitions.
	''
	'' Parameters:
	'' T_ - The TYPE or CLASS being defined.
	''
	# macro FBEXT_DECLARE_PLACEMENT_NEWDEL(T_)
	:
		declare operator new ( byval n as ext.SizeType ) as T_ ptr
		declare operator delete ( byval p as T_ ptr )
	:
	# endmacro

	'' Macro: FBEXT_DEFINE_PLACEMENT_NEWDEL
	'' Defines member operators new and delete.
	''
	'' Parameters:
	'' T_ - The TYPE or CLASS being defined.
	''
	# macro FBEXT_DEFINE_PLACEMENT_NEWDEL(T_)
	:
		'' :::::
		operator T_##.new ( byval n as ext.SizeType ) as T_ ptr

			var placement_address = ext.SetPlacementAddress(0)

			if placement_address then
				return placement_address
			else
				return ..allocate(n)
			end if

		end operator

		'' :::::
		operator T_##.delete ( byval p as T_ ptr )

			var placement_address = ext.SetPlacementAddress(0)

			if placement_address then
				ASSERT( p = placement_address )
			else
				..deallocate(p)
			end if

		end operator
	:
	# endmacro

end namespace

# endif ' include guard
