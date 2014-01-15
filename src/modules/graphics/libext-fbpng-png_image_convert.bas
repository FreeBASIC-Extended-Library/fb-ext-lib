#include once "pnginc/png_image.bi"
#include once "ext/memory/allocate.bi"
#include once "crt.bi"

#define FBEXT_BUILD_NO_GFX_LOADERS -1
#include once "ext/graphics/image.bi"

namespace ext.gfx.png
'::::::::
' Purpose : filter the current row that uses method 1 or 2
sub png_image_filter_row_12 _
    ( _
        byval pcb       as ubyte ptr, _ ' pointer to first byte of row to be filtered
        byval filter    as integer, _
        byval y         as integer, _
        byval scan_size as integer, _
        byval bpp       as integer _
    )

    dim as integer count = scan_size - 1
    dim as ubyte ptr src = any

    if filter = 1 then
        pcb += bpp ' ignore first pixel
        count -= bpp
        src = @pcb[-bpp]
    else
        if y <= 0 then exit sub
        src = @pcb[-scan_size]
    end if

    if count and 1 then
        pcb[0] += src[0]
        pcb += 1
        src += 1
    end if

    if count and 2 then
        pcb[0] += src[0]
        pcb[1] += src[1]
        pcb += 2
        src += 2
    end if

    count shr= 2

    for x as integer = count - 1 to 0 step -1
        pcb[0] += src[0]
        pcb[1] += src[1]
        pcb[2] += src[2]
        pcb[3] += src[3]
        pcb += 4
        src += 4
    next x

end sub

'::::::::
' Purpose : filter the current row that uses method 3
sub png_image_filter_row_3 _
    ( _
        byval pcb       as ubyte ptr, _ ' pointer to first byte of row to be filtered
        byval filter    as integer, _
        byval y         as integer, _
        byval scan_size as integer, _
        byval bpp       as integer _
    )

    if y > 0 then
        for x as integer = bpp - 1 to 0 step - 1
            *pcb += pcb[-scan_size] shr 1
            pcb += 1
        next x

        dim as ubyte ptr srcA = @pcb[-bpp]
        dim as ubyte ptr srcB = @pcb[-scan_size]

        dim as integer count = (scan_size - 1) - bpp

        if count and 1 then
            pcb[0] += (srcA[0] + srcB[0]) shr 1
            pcb += 1
            srcA += 1
            srcB += 1
        end if

        if count and 2 then
            pcb[0] += (srcA[0] + srcB[0]) shr 1
            pcb[1] += (srcA[1] + srcB[1]) shr 1
            pcb += 2
            srcA += 2
            srcB += 2
        end if

        count shr= 2

        for x as integer = count - 1 to 0 step -1
            pcb[0] += (srcA[0] + srcB[0]) shr 1
            pcb[1] += (srcA[1] + srcB[1]) shr 1
            pcb[2] += (srcA[2] + srcB[2]) shr 1
            pcb[3] += (srcA[3] + srcB[3]) shr 1
            pcb += 4
            srcA += 4
            srcB += 4
        next x
    else
        pcb += bpp

        for x as integer = (scan_size - 2) - bpp to 0 step -1
            *pcb += pcb[-bpp] shr 1
            pcb += 1
        next x
    end if

end sub

'::::::::
' Purpose : filter the current row that uses method 4
sub png_image_filter_row_4 _
    ( _
        byval pcb       as ubyte ptr, _ ' pointer to first byte of row to be filtered
        byval filter    as integer, _
        byval y         as integer, _
        byval scan_size as integer, _
        byval bpp       as integer _
    )

    if y > 0 then
        for x as integer = bpp - 1 to 0 step - 1
            *pcb += pcb[-scan_size]
            pcb += 1
        next x

        for x as integer = (scan_size - 2) - bpp to 0 step - 1
            dim as uinteger a      = any
            dim as uinteger b      = any
            dim as integer  p      = any
            dim as integer  pa     = any
            dim as integer  pb     = any
            dim as integer  pc     = any
            dim as uinteger amount = any

            a = pcb[-bpp]
            b = pcb[-scan_size]
            amount = pcb[-(scan_size + bpp)]

            ' Paeth predictor
            p = a + b - amount
            pa = abs( p - a )
            pb = abs( p - b )
            pc = abs( p - amount )

            if (pa <= pb) and (pa <= pc) then
                amount = a
            elseif pb <= pc then
                amount = b
            end if

            *pcb += amount
            pcb += 1
        next x
    else
        pcb += bpp

        for x as integer = (scan_size - 2) - bpp to 0 step - 1
            *pcb += pcb[-bpp]
            pcb += 1
        next x
    end if

end sub

'::::::::
' Purpose : The rows have now been drawn OK, but if it's an OpenGL image, the colors
'           will be wrong, so time to fix that.
' Return  : none
sub png_image_fix_opengl _
    ( _
        byref png_image  as png_image_t, _
        byval out_img    as any ptr, _
        byval pitch      as integer _
    )

    for y as integer = 0 to png_image.height - 1
        for x as integer = 0 to png_image.width - 1
            dim as uinteger c = cast( uinteger ptr, out_img )[x]
            cast( uinteger ptr, out_img )[x] = (cuint( (c shr 16) and &hff ) shl  0) _
                            or (cuint( (c shr  8) and &hff ) shl  8) _
                            or (cuint( (c shr  0) and &hff ) shl 16) _
                            or (cuint( (c shr 24) and &hff ) shl 24)
        next x
        out_img += abs( pitch )
    next y

end sub

'::::::::
' Purpose : Enough data has been seen, so a row can now be output
' Return  : none
sub png_image_draw_row _
    ( _
        byref png_image  as png_image_t, _
        byval out_img    as any ptr, _
        byval p          as ubyte ptr, _
        byval x1         as integer, _
        byval wfactor    as integer, _
        byval line_start as any ptr, _
        byval scan_size  as integer _
    )

    p -= 1

    for __x as integer = 0 to ((scan_size - 1) \ png_image.bpp) - 1

        dim as uinteger c      = any
        dim as integer  i      = any
        dim as ubyte    alpha  = PNG_DEFAULT_ALPHA
        dim as integer  max    = any
        dim as integer  mask   = any

        with png_image

            p += .bpp

            if .colortype = 0 then
                if .bitdepth <> 16 then
                    max  = (8 \ .bitdepth) - 1
                    mask = (2 ^ .bitdepth) - 1
                    for i = 0 to max
                        if x1 < .width then
                            c = (*p shr ((max - i) * .bitdepth)) and mask
                            alpha = PNG_DEFAULT_ALPHA
                            if .has_tRNS and (c = .tRNS_0) then
                                alpha = 0
                            end if
                            c *= 255 \ mask
                            cast( uinteger ptr, line_start )[x1] = RGBA( c, c, c, alpha )
                        end if
                        x1 += wfactor
                    next i
                else
                    c = get_u16( @p[-1] )
                    if .has_tRNS and (c = .tRNS_0) then
                        alpha = 0
                    end if
                    c shr= 8
                    cast( uinteger ptr, line_start )[x1] = RGBA( c, c, c, alpha )
                    x1 += wfactor
                end if
            elseif .colortype = 3 then
                dim as integer max    = (8 \ .bitdepth) - 1
                dim as integer mask   = (2 ^ .bitdepth) - 1
                for i = 0 to max
                    if x1 < .width then
                        c = (*p shr ((max - i) * .bitdepth)) and mask
                        alpha = PNG_DEFAULT_ALPHA
                        if .has_tRNS then
                            alpha = .tRNS_3(c)
                        end if
                        with .PLTE(c)
                            c = RGBA( .r, .g, .b, alpha )
                        end with
                        cast( uinteger ptr, line_start )[x1] = c
                    end if
                    x1 += wfactor
                next i
            elseif .colortype = 4 then
                if .bitdepth = 8 then
                    c = p[-1]
                    alpha = *p
                else
                    c = p[-3]
                    alpha = p[-1]
                end if
                cast( uinteger ptr, line_start )[x1] = RGBA( c, c, c, alpha )
                x1 += wfactor
            elseif (.colortype = 2) or (.colortype = 6) then
                if .bitdepth = 8 then
                    if .bpp = 3 then
                        if .has_tRNS = TRUE then
                            if (p[-2] = .tRNS_2r) and (p[-1] = .tRNS_2g) and (*p = .tRNS_2b) then
                                alpha = 0
                            end if
                        end if
                        c = RGBA( p[-2], p[-1], *p, alpha )
                    else
                        c = RGBA( p[-3], p[-2], p[-1], *p )
                    end if
                    cast( uinteger ptr, line_start )[x1] = c
                    x1 += wfactor
                else
                    dim as ushort r2 = any
                    dim as ushort g2 = any
                    dim as ushort b2 = any
                    if .bpp = 6 then
                        r2 = get_u16( @p[-5] )
                        g2 = get_u16( @p[-3] )
                        b2 = get_u16( @p[-1] )
                        if .has_tRNS = TRUE then
                            if (r2 = .tRNS_2r) and (g2 = .tRNS_2g) and (b2 = .tRNS_2b) then
                                alpha = 0
                            end if
                        end if
                    else
                        r2 = get_u16( @p[-7] )
                        g2 = get_u16( @p[-5] )
                        b2 = get_u16( @p[-3] )
                        alpha = p[-1]
                    end if
                    cast( uinteger ptr, line_start )[x1] = RGBA( r2 shr 8, g2 shr 8, b2 shr 8, alpha )
                    x1 += wfactor
                end if
            end if

        end with

    next __x

end sub

    # define FBEXT_CALC_IMAGE_PITCH(w, bitdepth) (((w) * (bitdepth) + &HF) and not &HF)' ((((w) * (bitdepth / 8)) + 31) and &hffffffe0)
    # define FBEXT_CALC_IMAGE_BUFFERSIZE(w, h, bitdepth) (header_size + (FBEXT_CALC_IMAGE_PITCH(w, bitdepth) * (h)))

    '' :::::
    private function GetImageBuffer_ ( byval w as SizeType, byval h as SizeType ) as any ptr

        function = null

    #if Not __FB_MIN_VERSION__(0, 20, 1)
        var x = cast(fb.image ptr, callocateAligned( ((((.width * 4) + 31) and &hffffffe0)*h)+sizeof(fb.image) ))
        x->width = w
        x->height = h
        x->bpp = 4
        x->pitch = ((.width * 4) + 31) and &hffffffe0
        x->type = PUT_HEADER_NEW
        return x
    #else
        return imagecreate( w, h, 32 )
    #endif

    end function


    '' :::::
    private sub ImageConvert_ ( byval src as fb.Image ptr, byref dst as fb.Image ptr, byval bitdepth as SizeType )

        if (src = null) then
            DEBUGPRINT( "null source image buffer" )
            dst = null
            exit sub
        end if

        dim src_width as const SizeType = src->width
        dim src_pitch as const SizeType = src->pitch
        dim src_bitdepth as const SizeType = src->bpp * 8
        dim dst_pitch as SizeType = src_width * (bitdepth / 8)

        ' new-style buffer ?
        if (src->type = PUT_HEADER_NEW) then
            dst = imagecreate( src_width, src->height, bitdepth )
            dst_pitch = FBEXT_CALC_IMAGE_PITCH(src_width, bitdepth)

        end if

        var src_row = cast(ubyte ptr, src) + sizeof(FB.IMAGE)
        var dst_row = cast(ubyte ptr, dst) + sizeof(FB.IMAGE)

        for row as SizeType = 0 to src->height - 1
            ..ImageConvertRow(              _
            src_row, src_bitdepth,      _
            dst_row, bitdepth,          _
            src_width, 0)

            src_row += src_pitch
            dst_row += dst_pitch
        next
    end sub

    '' ///
    '' /// /lmf
    '' ///

    '::::::::
    ' Purpose : Create an image buffer of requested target type, and unpack the IDAT
    ' Return  : NULL on failure, valid pointer to buffer on success
    function png_image_convert _
        ( _
        byref png_image as png_image_t, _
        byval target    as target_e _
        ) as any ptr

    dim as integer      offset    = 0
    dim as integer      data_read = 0
    dim as uinteger ptr out_img   = any
    dim as ubyte ptr    in_img    = any
    dim as integer      pass_max  = 1
    dim as integer      pass      = any
    dim as any ptr      pixels    = any
    dim as uinteger     pitch     = any

        function = NULL

        with png_image

            if .prepared = FALSE then
                DEBUGPRINT( "Not prepared" )
                exit function
            end if

            ' Make a copy of the IDAT, because unfiltering will overwrite
            in_img = callocate( .IDAT_len )
            if in_img = NULL then
                DEBUGPRINT( "IDAT copy allocate failed" )
                exit function
            end if
            memcpy( in_img, .IDAT, .IDAT_len )

            select case as const target
            case TARGET_FBNEW
                out_img = GetImageBuffer_( .width, .height )
                pixels = cast( any ptr, out_img ) + sizeof( fb.Image )
                pitch = cast( fb.image ptr, out_img)->pitch

            case TARGET_OPENGL
                out_img = callocateAligned( .width * .height * 4 )
                pixels = cast( any ptr, out_img )
                pixels += (.height - 1) * (.width * 4)
                pitch = -(.width * 4)

            case else
                DEBUGPRINT( "bad target" )
                deallocate( in_img )
                return null
            end select


            if out_img = NULL then
                deallocate( in_img )
                DEBUGPRINT( "Output buffer allocate failed" )
                return null
            end if

            if .interlacemethod = 1 then
                pass_max = 7
            end if

            ' Make a number of passes, 1 for non interlaced, 7 for interlaced
            for pass = 1 to pass_max
                dim as integer scan_size = calc_scan_size( png_image, pass )
                dim as integer y1        = 0
                dim as integer wfactor   = 1
                dim as integer hfactor   = 1
                dim as integer y_max     = .height - 1
                dim as integer y         = any
                if .interlacemethod = 1 then
                    dim as integer iheight = any
                    wfactor = tb_wfac(pass)
                    hfactor = tb_hfac(pass)
                    iheight = (.height + hfactor - tb_yoff(pass) - 1) \ hfactor
                    y1 = tb_yoff(pass)
                    y_max = iheight - 1
                    ' Force the y loop to not do anything if theres nothing to do this pass
                    if .width <= tb_xoff(pass) then
                        y_max = -1
                    end if
                end if
                for y = 0 to y_max
                    dim as integer x1     = 0
                    dim as ubyte   filter = in_img[offset]
                    offset += 1 ' Jump past the filter byte
                    if .interlacemethod = 1 then
                        x1 = tb_xoff(pass)
                    end if
                    dim as any ptr _inp = @in_img[offset]

                    select case as const filter
                    case 0
                        ' No filtering
                    case 1, 2
                        png_image_filter_row_12( _inp, filter, y, scan_size, .bpp )
                    case 3
                        png_image_filter_row_3( _inp, filter, y, scan_size, .bpp )
                    case 4
                        png_image_filter_row_4( _inp, filter, y, scan_size, .bpp )
                    case else
                        deallocate( in_img )
                        deallocate( out_img )
                        DEBUGPRINT( "Bad filter byte" )
                        exit function
                    end select

                    offset += scan_size - 1
                    png_image_draw_row( png_image, out_img, _inp, x1, wfactor, pixels + (y1 * pitch), scan_size )

                    y1 += hfactor
                next y
            next pass

            if target = TARGET_OPENGL then
                png_image_fix_opengl( png_image, out_img, pitch )
            end if

            deallocate( in_img )
        end with

        var scrn_bitdepth = 0
        scope
        var unused = 0
        screeninfo unused, unused, scrn_bitdepth
        end scope

        if (target = TARGET_OPENGL) then
            function = new ext.gfx.Image(png_image.width,png_image.height,cast(any ptr,out_img))

        elseif target = TARGET_FBNEW andalso scrn_bitdepth = 32 then
            function = new ext.gfx.Image(cast(fb.image ptr,out_img))
        else
            dim new_img as fb.Image ptr = any
            ImageConvert_(cast( fb.image ptr,out_img), new_img, scrn_bitdepth)
            imagedestroy( out_img )

            function = new ext.gfx.Image(new_img)
        end if

    end function

end namespace 'ext.gfx.png
