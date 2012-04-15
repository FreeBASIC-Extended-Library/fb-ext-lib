'' Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
'' All rights reserved.
''
'' Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
'' THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
'' "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
'' LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
'' A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
'' CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
'' EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
'' PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
'' PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
'' LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
'' NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
'' SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

'option.bas
#include once "ext/options.bi"

namespace ext.options

	constructor Option( byref short_opt as string, _
						byref long_opt as string = "", _
						byval has_arg as bool = false, _
						byval arg_required as bool = false, _
						byval can_repeat as bool = false, _
						byref rep_seperator as string = ";", _
						byref help_string as string = "" )

		m_short_opt = short_opt
		m_long_opt = long_opt
		m_has_arg = has_arg
		m_arg_required = arg_required
		m_can_repeat = can_repeat
		m_rep_seperator = rep_seperator
		m_help = help_string
		m_set = false
		m_processed = false

	end constructor

	constructor Option( byref cpy as Option )

		m_short_opt = cpy.m_short_opt
		m_long_opt = cpy.m_long_opt
		m_has_arg = cpy.m_has_arg
		m_arg_required = cpy.m_arg_required
		m_can_repeat = cpy.m_can_repeat
		m_rep_seperator = cpy.m_rep_seperator
		m_help = cpy.m_help
		m_set = cpy.m_set
		m_processed = cpy.m_processed
		m_arg = cpy.m_arg

	end constructor

	destructor Option()

		m_short_opt = ""
		m_long_opt = ""
		m_arg = ""
		m_help = ""

	end destructor

end namespace
