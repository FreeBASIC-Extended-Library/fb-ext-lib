'' Copyright (c) 2007-2011, FreeBASIC Extended Library Development Group
''
'' All rights reserved.
''
'' Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''  * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''  * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''  * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
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

# include once "ext/error.bi"

namespace ext

    private function __internal_last_error( byval err_num as integer = -1, _
                        byref emsg as string ptr ) as integer

        static last_err as integer = 0
        static err_str as string

        if err_num >= 0 then
            last_err = err_num
            err_str = *emsg
        end if

        if err_num = -1 then
            if emsg <> 0 then *emsg = err_str
            return last_err
        end if

        if err_num = -2 then
            last_err = 0
            err_str = ""
        end if

        return 0

    end function

    '' :::::
    function GetErrorText (byval err_number as integer = -1) as string

        var errtext = ""
        var m_err_number = err_number

        if err_number = -1 then m_err_number = __internal_last_error(-1,0)

        select case as const m_err_number
            case 0 : errtext = "No error"
            case 1 : errtext = "Illegal function call"
            case 2 : errtext = "File not found signal"
            case 3 : errtext = "File I/O error"
            case 4 : errtext = "Out of memory"
            case 5 : errtext = "Illegal resume"
            case 6 : errtext = "Out of bounds array access"
            case 7 : errtext = "Null Pointer Access"
            case 8 : errtext = "No privileges"
            case 9 : errtext = "Interrupted signal"
            case 10 : errtext = "Illegal instruction signal"
            case 11 : errtext = "Floating point error signal"
            case 12 : errtext = "Segmentation violation signal"
            case 13 : errtext = "Termination request signal"
            case 14 : errtext = "Abnormal termination signal"
            case 15 : errtext = "Quit request signal"
            case else :
                errtext = "Unknown error"
                var es = ""
                __internal_last_error(-1,@es)
                if es <> "" then errtext = es
        end select

        return errtext

    end function

    sub setError( byval err_num as integer, byref msg as string = "" )
        __internal_last_error( err_num, @msg )
    end sub

    function getError( ) as integer

        return __internal_last_error(-1,0)

    end function

    sub clearError( )

        __internal_last_error(-2,0)

    end sub

end namespace ' ext

