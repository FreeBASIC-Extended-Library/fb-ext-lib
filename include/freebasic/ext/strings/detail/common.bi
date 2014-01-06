''Title: strings/detail/common.bi
''
''About: License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# ifndef FBEXT_STRINGS_DETAIL_BI__
# define FBEXT_STRINGS_DETAIL_BI__ -1

# include once "ext/detail/common.bi"
#include once "ext/math/detail/common.bi"

#if not __FB_MT__
	#inclib "ext-strings"
	#ifdef FBEXT_MULTITHREADED
		#error "The multithreaded version of the library must be built using the -mt compiler option."
	#endif
#else
	#inclib "ext-strings.mt"
	#ifndef FBEXT_MULTITHREADED
		#define FBEXT_MULTITHREADED 1
	#endif
#endif

'' Namespace: ext.strings
''
'' Contains string procedures and the xstring class
''
namespace ext.strings

	'' Enum: CHAR
	'' ASCII character codes
	''
	'' See strings.bi for complete listing.
	enum
		CHAR_NULL = 0
		CHAR_SOH
		CHAR_STX
		CHAR_ETX
		CHAR_EOT
		CHAR_ENQ
		CHAR_ACK
		CHAR_BEL
		CHAR_BS
		CHAR_HT
		CHAR_LF
		CHAR_VT
		CHAR_FF
		CHAR_CR
		CHAR_SO
		CHAR_SI
		CHAR_DLE
		CHAR_DC1
		CHAR_DC2
		CHAR_DC3
		CHAR_DC4
		CHAR_NAK
		CHAR_SYN
		CHAR_ETB
		CHAR_CAN
		CHAR_EM
		CHAR_SUB
		CHAR_ESC
		CHAR_FS
		CHAR_GS
		CHAR_RS
		CHAR_US
		CHAR_SPACE = 32
		CHAR_BANG
		CHAR_DBLQUOTE
		CHAR_SHARP
		CHAR_DOLLAR
		CHAR_PERCENT
		CHAR_AMP
		CHAR_RQUOTE
		CHAR_LPAREN
		CHAR_RPAREN
		CHAR_STAR
		CHAR_PLUS
		CHAR_COMMA
		CHAR_DASH
		CHAR_DOT
		CHAR_FSLASH
		CHAR_0
		CHAR_1
		CHAR_2
		CHAR_3
		CHAR_4
		CHAR_5
		CHAR_6
		CHAR_7
		CHAR_8
		CHAR_9
		CHAR_COLON
		CHAR_SEMICOLON
		CHAR_LESSTHAN
		CHAR_EQUAL
		CHAR_GREATERTHAN
		CHAR_QUESTION
		CHAR_AT
		CHAR_UC_A
		CHAR_UC_B
		CHAR_UC_C
		CHAR_UC_D
		CHAR_UC_E
		CHAR_UC_F
		CHAR_UC_G
		CHAR_UC_H
		CHAR_UC_I
		CHAR_UC_J
		CHAR_UC_K
		CHAR_UC_L
		CHAR_UC_M
		CHAR_UC_N
		CHAR_UC_O
		CHAR_UC_P
		CHAR_UC_Q
		CHAR_UC_R
		CHAR_UC_S
		CHAR_UC_T
		CHAR_UC_U
		CHAR_UC_V
		CHAR_UC_W
		CHAR_UC_X
		CHAR_UC_Y
		CHAR_UC_Z
		CHAR_LBRACKET
		CHAR_BSLASH
		CHAR_RBRACKET
		CHAR_CARROT
		CHAR_USCORE
		CHAR_LQUOTE
		CHAR_LC_A
		CHAR_LC_B
		CHAR_LC_C
		CHAR_LC_D
		CHAR_LC_E
		CHAR_LC_F
		CHAR_LC_G
		CHAR_LC_H
		CHAR_LC_I
		CHAR_LC_J
		CHAR_LC_K
		CHAR_LC_L
		CHAR_LC_M
		CHAR_LC_N
		CHAR_LC_O
		CHAR_LC_P
		CHAR_LC_Q
		CHAR_LC_R
		CHAR_LC_S
		CHAR_LC_T
		CHAR_LC_U
		CHAR_LC_V
		CHAR_LC_W
		CHAR_LC_X
		CHAR_LC_Y
		CHAR_LC_Z
		CHAR_LBRACE
		CHAR_PIPE
		CHAR_RBRACE
		CHAR_TILDE
		CHAR_DEL
	end enum

	'' Enum: String Errors
	''
	'' STR_NOT_FOUND - Defined to be -1
	''
	enum
	
		STR_NOT_FOUND = -1
	
	end enum

end namespace

# endif ' include guard
