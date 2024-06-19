'#include once "pnginc/file_to_buffer.bi"
#include once "pnginc/png_image.bi"


#define FBEXT_BUILD_NO_GFX_LOADERS -1
#include once "ext/graphics/png.bi"
#include once "ext/graphics/image.bi"
#undef FBEXT_BUILD_NO_GFX_LOADERS
#include once "ext/detail/common.bi"
#include once "ext/file/file.bi"
#include once "ext/graphics/detail/common.bi"


namespace ext.gfx.png

    '' :::::
    function load _
        ( _
            byref hFile as File, _
            byval t   as target_e = TARGET_FBNEW _
        ) as Image ptr

        dim as any ptr img
        dim as ubyte ptr fbuf

        if t <> TARGET_FBNEW ANDALSO t <> TARGET_OPENGL then return 0

        If hFile.open( ) Then
                Return NULL
        End If

        var fsiz = hFile.toBuffer(fbuf)
        hFile.close()

        dim as png_image_t pimg

        if (fbuf = NULL) or (fsiz < 49) then ' 49/50 is the bare minimum
            delete[] fbuf
            return NULL
        end if

        png_image_init( pimg, fbuf, fsiz )
        png_image_prepare( pimg )
        img = png_image_convert( pimg, t )
        png_image_deinit( pimg )

        delete[] fbuf

        Return img

    end function

end namespace 'ext.gfx.png
