' Note: In this file, I have included the declarations for the
'       gfxlib headers, and the zlib functions.  This was because
'       of the problems involved in being 0.16 and 0.17 compatible

#ifndef _PNG_IMAGE_BI_
#define _PNG_IMAGE_BI_

#include "ext/graphics/png.bi"
#include "crt.bi"

namespace ext.gfx.png

#define PNG_DEFAULT_ALPHA 255

#define get_u32(p) (((cuint( cptr( ubyte ptr, p )[0] ) ) shl 24) _
                 or ((cuint( cptr( ubyte ptr, p )[1] ) ) shl 16) _
                 or ((cuint( cptr( ubyte ptr, p )[2] ) ) shl 8) _
                 or  (cuint( cptr( ubyte ptr, p )[3] ) ))

#define get_u16(p) (((cushort( cptr( ubyte ptr, p )[0] ) ) shl 8) _
                 or  (cushort( cptr( ubyte ptr, p )[1] ) ))

#define IS_CHUNK_TYPE(t,s) (*cptr( uinteger ptr, @(t) ) = *cptr( uinteger ptr, (s) ))

#if not __FB_DEBUG__
	#define DEBUGPRINT(x)
#else
	#include once "ext/debug.bi"
	#define DEBUGPRINT(x) FBEXT_DPRINT(x)
#endif

type bool_e as ext.bool

type OLD_HEADER field = 1
	bpp   : 3  as ushort
	width : 13 as ushort
	height     as ushort
end type

type NEW_HEADER field = 1
	union
		old  as OLD_HEADER
		type as uinteger
	end union
	bpp                as integer
	width              as uinteger
	height             as uinteger
	pitch              as uinteger
	_reserved(1 to 12) as ubyte
end type

type png_chunk_t
	length as uinteger
	type   as zstring * 4
	data   as ubyte ptr
	crc32  as uinteger
end type

type png_RGB8_t
	r as ubyte
	g as ubyte
	b as ubyte
end type

type plot_func_t as sub _
	( _
		byval p as uinteger ptr, _
		byval x as integer, _
		byval y as integer, _
		byval c as uinteger, _
		byval w as integer, _
		byval h as integer _
	)

type png_image_t
' IHDR
	width                   as uinteger
	height                  as uinteger
	bitdepth                as ubyte
	colortype               as ubyte
	compressionmethod       as ubyte
	filtermethod            as ubyte
	interlacemethod         as ubyte
' PLTE
	PLTE(0 to 255)          as png_RGB8_t
	PLTE_count              as uinteger
' IDAT
	IDAT                    as ubyte ptr
	IDAT_len                as uinteger
' tRNS
	has_tRNS                as bool_e
	tRNS_3(0 to 255)        as ubyte
	tRNS_0                  as ushort
	tRNS_2r                 as ushort
	tRNS_2g                 as ushort
	tRNS_2b                 as ushort
' Other
	buffer                  as ubyte ptr
	buffer_len              as uinteger
	buffer_pos              as uinteger
	bpp                     as uinteger
	chunk                   as png_chunk_t ptr ptr
	chunk_count             as uinteger
	initialized             as bool_e
	prepared                as bool_e
end type

declare sub png_image_init _
	( _
		byref png_image  as png_image_t, _
		byval buffer     as any ptr, _
		byval buffer_len as uinteger _
	)

declare sub png_image_deinit _
	( _
		byref png_image as png_image_t _
	)

declare sub png_image_prepare _
	( _
		byref png_image as png_image_t _
	)

declare function png_image_convert _
	( _
		byref png_image as png_image_t, _
		byval target    as target_e _
	) as any ptr

declare function chunk_find _
	( _
		byref png_image as png_image_t, _
		byval _type_    as zstring ptr, _
		byval start_pos as integer _
	) as integer

declare function calc_scan_size _
	( _
		byref png_image as png_image_t, _
		byval pass      as integer _
	) as integer

extern as integer tb_wfac(1 to 7)
extern as integer tb_hfac(1 to 7)
extern as integer tb_xoff(1 to 7)
extern as integer tb_yoff(1 to 7)
extern as ubyte png_sig(0 to 7)

const as integer PUT_HEADER_NEW = &h7



end namespace 'ext.gfx.png

type uInt as uinteger
type Bytef as Byte
type charf as byte
type intf as integer
type uIntf as uInt
type uLongf as uLong
type voidpc as any ptr
type voidpf as any ptr
type voidp as any ptr

extern "c"
declare function compress (byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as Bytef ptr, byval sourceLen as uLong) as integer
declare function compress2 (byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as Bytef ptr, byval sourceLen as uLong, byval level as integer) as integer
declare function compressBound (byval sourceLen as uLong) as uLong
declare function uncompress (byval dest as Bytef ptr, byval destLen as uLongf ptr, byval source as Bytef ptr, byval sourceLen as uLong) as integer
declare function crc32 (byval crc as uLong, byval buf as Bytef ptr, byval len as uInt) as uLong
end extern


#endif '_PNG_IMAGE_BI_
