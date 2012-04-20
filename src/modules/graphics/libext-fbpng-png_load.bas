#include once "pnginc/file_to_buffer.bi"
#include once "pnginc/png_image.bi"

namespace ext.gfx.png

    '' :::::
    function load _
        ( _
            byref filename as const string, _
            byval target   as target_e = TARGET_FBNEW _
        ) as any ptr

        if target <> TARGET_FBNEW AND target <> TARGET_OPENGL then return 0

        dim as any ptr buffer     = any
        dim as integer buffer_len = any

        buffer = file_to_buffer( strptr( filename ), buffer_len )

        if buffer <> NULL then
            function = load_mem( buffer, buffer_len, target )
            deallocate( buffer )
        end if

    end function

    '' :::::
    function load_mem _
        ( _
            byval buffer     as any ptr, _
            byval buffer_len as SizeType, _
            byval target     as target_e _
        ) as any ptr

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
