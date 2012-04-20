#include once "pnginc/file_to_buffer.bi"
#include once "pnginc/png_image.bi"
#include once "ext/file/file.bi"
#ifndef FBEXT_BUILD_NO_GFX_LOADERS
#define FBEXT_BUILD_NO_GFX_LOADERS -1
#include once "ext/graphics/image.bi"
#undef FBEXT_BUILD_NO_GFX_LOADERS
#endif

namespace ext.gfx.png

    '' :::::
    function load _
        ( _
            byref filename as const string, _
            byval t   as target_e = TARGET_FBNEW _
        ) as ext.gfx.Image ptr

        Dim As ext.FILE  hFile
        dim as any ptr img
        dim as ubyte ptr fbuf

        if t <> TARGET_FBNEW ANDALSO t <> TARGET_OPENGL then return 0

        If hFile.open( filename ) Then
                'con.WriteLine("File not loaded")
                Return NULL
        End If

        var fsiz = hFile.toBuffer(fbuf)
        hFile.close()

        img = load_mem(fbuf,fsiz,t)
        delete[] fbuf

        Return img

    end function

    '' :::::
    function load_mem _
        ( _
            byval buffer     as any ptr, _
            byval buffer_len as SizeType, _
            byval target     as target_e _
        ) as ext.gfx.Image ptr

        dim as png_image_t img

        if (buffer = NULL) or (buffer_len < 49) then ' 49/50 is the bare minimum
            exit function
        end if

        png_image_init( img, buffer, buffer_len )
        png_image_prepare( img )
        function = png_image_convert( img, target )
        png_image_deinit( img )

    end function

end namespace 'ext.gfx.png
