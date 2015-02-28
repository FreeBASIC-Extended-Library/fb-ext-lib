#include "pnginc/png_image.bi"
#include once "fbgfx.bi"

#define make_u32(n) ((((n) and &h000000ff) shl 24) _
                  or (((n) and &h0000ff00) shl 8) _
                  or (((n) and &h00ff0000) shr 8) _
                  or (((n) and &hff000000) shr 24))

#define put_u32(p, n) *cptr( uinteger ptr, p ) = make_u32(n)

namespace ext.gfx.png
'::::::::
' This should be a lot cleaner....
function save cdecl alias "png_save" _
	( _
		byref filename as const string, _
		byval img      as const FB.IMAGE ptr _
	) as integer

	dim as integer w = any
	dim as integer h = any
	dim as integer bpp = any
	dim as integer pitch = any
	dim as FILE ptr hfile = any

	if (img = NULL) or (filename = "") then return 1

	if cptr( NEW_HEADER ptr, img )->type = PUT_HEADER_NEW then
		w = cptr( NEW_HEADER ptr, img )->width
		h = cptr( NEW_HEADER ptr, img )->height
		bpp = cptr( NEW_HEADER ptr, img )->bpp
		pitch = cptr( NEW_HEADER ptr, img )->pitch
		img += sizeof( NEW_HEADER )
	else
		w = cptr( OLD_HEADER ptr, img )->width
		h = cptr( OLD_HEADER ptr, img )->height
		bpp = cptr( OLD_HEADER ptr, img )->bpp
		pitch = w * bpp
		img += sizeof( OLD_HEADER )
	end if

	if bpp <> 4 then
		DEBUGPRINT( "Only 32 bit images allowed" )
		return 1
	end if

	hfile = fopen( filename, "wb" )
	if hfile = NULL then
		DEBUGPRINT( "Could not open file for write" )
		return 1
	end if

	if fwrite( @png_sig(0), 1, 8, hfile ) <> 8 then
		fclose( hfile )
		DEBUGPRINT( "Write failure" )
		return 1
	end if

	dim as ubyte IHDR(0 to 24) = {0, 0, 0, 0, asc( "I" ), asc( "H" ), asc( "D" ), asc( "R" )}

	put_u32( @IHDR(0), 13 ) ' Length of data

	put_u32( @IHDR(8), w )
	put_u32( @IHDR(12), h )
	IHDR(16) = 8 ' 8bpp
	IHDR(17) = 6 ' RGBA
	IHDR(18) = 0
	IHDR(19) = 0
	IHDR(20) = 0
	dim as uinteger crc = any
	crc = crc32( 0, @IHDR(4), 4 )
	crc = crc32( crc, @IHDR(8), 13 )
	put_u32( @IHDR(21), crc )

	if fwrite( @IHDR(0), 1, 25, hfile ) <> 25 then
		fclose( hfile )
		DEBUGPRINT( "Write failure" )
		return 1
	end if

	dim as ubyte ptr buffer = callocate( ((w * 4) + 1) * h )

	dim as integer x = 0
	dim as integer y = 0
	dim as ubyte ptr p1 = 0
	dim as ubyte ptr p2 = buffer

	for y = 0 to h - 1
		p1 = @cptr( ubyte ptr, img )[y * pitch]
		*p2 = 0
		p2 += 1
		for x = 0 to w - 1
			dim as ubyte r, g, b, a
			b = p1[0]
			g = p1[1]
			r = p1[2]
			a = p1[3]
			p2[0] = r
			p2[1] = g
			p2[2] = b
			p2[3] = a
			p1 += 4
			p2 += 4
		next x
	next y

	dim as ulong sz = 0
	dim as any ptr cmp = 0

	sz = ((w * 4) + 1) * h
	cmp = callocate( sz + 500 )

	dim as ulong destlen = sz + 500

	if compress( cmp, @destlen, buffer, sz ) <> 0 then
		deallocate( buffer )
		deallocate( cmp )
		DEBUGPRINT( "Compress failure" )
		return 1
	end if

	deallocate( buffer )

	dim as ubyte IDAT( 0 to 7 ) = {0, 0, 0, 0, asc( "I" ), asc( "D" ), asc( "A" ), asc( "T" )}

	put_u32( @IDAT(0), destlen )

	if fwrite( @IDAT(0), 1, 8, hfile ) <> 8 then
		fclose( hfile )
		deallocate( cmp )
		DEBUGPRINT( "Write failure" )
		return 1
	end if

	if fwrite( cmp, 1, destlen, hfile ) <> destlen then
		fclose( hfile )
		deallocate( cmp )
		DEBUGPRINT( "Write failure" )
		return 1
	end if

	crc = crc32( 0, @IDAT(4), 4 )
	crc = crc32( crc, cmp, destlen )

	deallocate( cmp )

	put_u32( @IDAT(0), crc )

	if fwrite( @IDAT(0), 1, 4, hfile ) <> 4 then
		fclose( hfile )
		DEBUGPRINT( "Write failure" )
		return 1
	end if

	dim as ubyte IEND( 0 to 7 ) = _
	        {0, 0, 0, 0, asc( "I" ), asc( "E" ), asc( "N" ), asc( "D" )}

	if fwrite( @IEND(0), 1, 8, hfile ) <> 8 then
		fclose( hfile )
		DEBUGPRINT( "Write failure" )
		return 1
	end if

	crc = crc32( 0, @IEND(4), 4 )

	put_u32( @IEND(0), crc )

	if fwrite( @IEND(0), 1, 4, hfile ) <> 4 then
		fclose( hfile )
		DEBUGPRINT( "Write failure" )
		return 1
	end if

	fclose( hfile )

end function

end namespace 'ext.gfx.png
