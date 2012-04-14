#ifndef _FILE_TO_BUFFER_BI_
#define _FILE_TO_BUFFER_BI_

namespace ext.gfx.png

declare function file_to_buffer _
	( _
		byval fname as zstring ptr, _
		byref fsize as integer _
	) as any ptr

end namespace

#endif '_FILE_TO_BUFFER_BI_
