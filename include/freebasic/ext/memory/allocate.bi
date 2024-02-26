''Title: memory/allocate.bi
''
''About: License
''Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# pragma once
# ifndef FBEXT_MEMORY_ALLOCATE_BI__
# define FBEXT_MEMORY_ALLOCATE_BI__ -1
#include once "ext/detail/common.bi"

''Namespace: ext
namespace ext

''Function: callocateAligned
''Allocate a special buffer, that is aligned to a multiple of 16, for SSE usage
''
declare function callocateAligned( byval size as sizetype ) as any ptr

end namespace

# endif