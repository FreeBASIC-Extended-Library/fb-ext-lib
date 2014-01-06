''Title: graphics/detail/common.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

#ifndef FBEXT_GFX_DETAIL_COMMON_BI__
#define FBEXT_GFX_DETAIL_COMMON_BI__ -1

#if not __FB_MT__
    #inclib "ext-graphics"
    #ifdef FBEXT_MULTITHREADED
        #error "The multithreaded version of the library must be built using the -mt compiler option."
    #endif
#else
    #inclib "ext-graphics.mt"
    #ifndef FBEXT_MULTITHREADED
        #define FBEXT_MULTITHREADED 1
    #endif
#EndIf

# include once "ext/detail/common.bi"

namespace ext.gfx

    ''Enum: DrawMethods
    ''Used to determine the method to use when drawing an image.
    ''
    ''PSET_ - Source pixel values are copied without modification.
    ''PRESET_ - Source pixel values are 1's-complement negated before being copied.
    ''TRANS_ - Source pixel values are copied without modification. Does not draw source pixels of mask color.
    ''AND_ - Destination pixels are bitwise ANDed with source pixels.
    ''OR_ - Destination pixels are bitwise ORed with source pixels.
    ''XOR_ - Destination pixels are bitwise XORed with source pixels.
    ''ALPHA_ - Source is blended with a transparency factor specified in the image's individual pixels.
    ''
    enum DrawMethods
        PSET_
        PRESET_
        TRANS_
        AND_
        OR_
        XOR_
        ALPHA_
    end enum

    ''Enum: target_e
    ''Contains the valid destinations/locations for the image.
    ''
    ''TARGET_FBNEW - use the new (.17 and up) style graphics buffer.
    ''
    ''TARGET_OPENGL - use an OpenGL compatible buffer.
    ''
    enum target_e
        TARGET_FBNEW
        TARGET_OPENGL
    end enum

end namespace

#endif ' include guard

