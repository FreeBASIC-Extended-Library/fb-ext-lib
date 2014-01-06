''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
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

#include once "ext/options.bi"

'parser.bas
'I'd really like to use fbExt_List for this
namespace ext.options

destructor OptionList()
    if d <> null then delete d
    if NextNode <> null then delete NextNode
end destructor

constructor Parser()
    last_index = 0
    addBool( "h", "help", "Shows this Help Information." )
end constructor

sub Parser.addnode( byval x as Option ptr )

    var t = m_opt
    var o = t
    if t = null then

        m_opt = new OptionList
        m_opt->d = x
    else
        while 1

            if t = 0 then

                t = new OptionList
                if o <> null then o->NextNode = t
                exit while
            else
                o = t
                t = t->NextNode
            end if

        wend

        t->d = x
    end if

end sub

function Parser.addOption( byref opt as Option ) as integer

    addnode( @opt )
    last_index += 1
    return last_index - 1

end function

function Parser.addBool( byref short_opt as string, _
                    byref long_opt as string = "", _
                    byref help_string as string = "" ) as integer

    addnode( new Option( short_opt, long_opt,,,,,help_string ) )
    last_index += 1
    return last_index - 1

end function

function Parser.addOption( byref short_opt as string, _
                            byref long_opt as string = "", _
                            byval has_arg as bool = false, _
                            byval arg_required as bool = false, _
                            byval can_repeat as bool = false, _
                            byref rep_seperator as string = ";",  _
                            byref help_string as string = "" ) as integer
    addnode( new Option(short_opt, long_opt, has_arg, arg_required, can_repeat, rep_seperator, help_string) )
    last_index += 1
    return last_index - 1

end function

sub Parser.parse( byval argc as integer, byval argv as zstring ptr ptr )
'here be dragons

    var cindex = 1
    var maxindex = argc - 1
    dim as string retstring

    while cindex <= maxindex

        var sopto = "-"
        var lopto = "--"
        var t = m_opt
        var gotone = 0
        if t = null then return

        while t <> null

            var sopt = sopto & t->d->m_short_opt

            var lopt = lopto & t->d->m_long_opt

            if (sopt = *(argv[cindex]) OR lopt = *(argv[cindex])) and gotone = 0 then
                gotone = 1

                t->d->m_set = true

                if t->d->m_processed = true and t->d->m_can_repeat = false then
                    m_error = "Option: " & sopt & " / " & lopt & " repeated."
                    return
                end if

                t->d->m_processed = true

                if t->d->m_has_arg = true then
                    if t->d->m_arg_required = true then
                        if (cindex+1) > maxindex then exit while
                        cindex += 1
                        if left(*(argv[cindex]),1) = "-" then
                            m_error = "Required argument for " & sopt & " / " & lopt & " not found."
                            return
                        else
                            if t->d->m_can_repeat = true then
                                t->d->m_arg = t->d->m_arg & *(argv[cindex]) & t->d->m_rep_seperator
                            else
                                t->d->m_arg = *(argv[cindex])
                            end if
                        end if

                    else 'argument is optional
                        if (cindex+1) > maxindex then exit while
                        cindex +=1
                        if left(*(argv[cindex]),1) <> "-" then

                            if t->d->m_can_repeat = true then
                                t->d->m_arg = t->d->m_arg & *(argv[cindex]) & t->d->m_rep_seperator

                            else
                                t->d->m_arg = *(argv[cindex])
                            end if

                        else
                            cindex -= 1
                        end if
                    end if
                end if
                exit while
            else


                'return
            end if

            t = t->NextNode

        wend
        if gotone = 0 and left(*(argv[cindex]),1) = "-" then
            m_error = "Invalid option: " & *(argv[cindex])
            return
        elseif gotone = 0 then
            retstring = retstring & " " & *(argv[cindex])
        end if
        cindex += 1
    wend

    m_remainder = trim(retstring)

    if( isSet(0) ) then
        showHelp()
        end
    end if

end sub

function Parser.hasError() as bool

    return iif( len(m_error)>0, true, false )

end function

function Parser.getError() as string

    return m_error

end function

function Parser.isSet( byval index as integer ) as bool

    if index < 0 or index > last_index then
        return false
    end if

    if m_opt = null then
        return false
    end if

    var t = m_opt
    var o = t

    for n as integer = 0 to index

        o = t
        t = t->NextNode

    next

    return o->d->m_set

end function

function Parser.getArg( byval index as integer ) as string

    if index < 0 or index > last_index then return ""
    if m_opt = null then return ""

    var t = m_opt
    var o = t

    for n as integer = 0 to index

        o = t
        t = t->NextNode

    next

    return o->d->m_arg

end function

sub Parser.setHelpHeader( byref s as string )
    h_head = s
end sub

sub Parser.setHelpFooter( byref s as string )
    h_foot = s
end sub

sub Parser.showHelp()

    print h_head
    print

    var t = m_opt

    for n as integer = 0 to last_index - 1

    if t->d->m_long_opt = "" then
        print using "-&  &"; t->d->m_short_opt; t->d->m_help
    else
        print using "-&/--&  &"; t->d->m_short_opt; t->d->m_long_opt; t->d->m_help
    end if

    t = t->NextNode

    next

    print
    print h_foot

end sub

function Parser.getRemainder() as string

    return m_remainder

end function

destructor Parser()

    m_remainder = ""
    m_error = ""
    h_head = ""
    h_foot = ""
    if m_opt <> null then delete m_opt

end destructor

end namespace
