''Copyright (c) 2007-2013, FreeBASIC Extended Library Development Group
''
''All rights reserved.
''
''Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
''
''    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
''    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
''    * Neither the name of the FreeBASIC Extended Library Development Group nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
''
''THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
''"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
''LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
''A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
''CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
''EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
''PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
''PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
''SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#include once "ext/xml/dom.bi"
#include once "ext/error.bi"

#include once "crt.bi"
#undef NULL

'' zero-terminated strncpy
private function strnztcpy(byval dest as ubyte ptr, byval src as ubyte ptr, byval n as size_t) as ubyte ptr
    dest[n] = 0
    return strncpy(dest, src, n)
end function

namespace ext.xml

    function node.m_child_index(byref tag_ as const string, byval index as integer) as integer
        '' search for the child
        dim as integer i = 0
        do while (i < m_children)
            if (m_child[i]->tag = tag_) then
                if (index = 0) then
                    return i
                end if
                index -= 1
            end if
            i += 1
        loop
        '' child not found
        return -1
    end function

    function node.Parent( ) as node ptr

        return m_parent

    end function


    function node.m_child_index(byval node_type_ as node_type_e, byval index as integer) as integer
        '' search for the child
        dim as integer i = 0
        do while (i < m_children)
            if (m_child[i]->nodeType = node_type_) then
                if (index = 0) then
                    return i
                end if
                index -= 1
            end if
            i += 1
        loop
        '' child not found
        return -1
    end function

    function node.m_emit() as string
        '' not finished
        select case m_node_type
        case element
            if tag = "" then return ""
            dim as string temp
            temp = "<" & tag
            if (m_attributes) then
                for i as integer = 0 to m_attributes - 1
                    temp &= " " & *m_attribute[i] & "=""" & encode_entities(*m_value[i]) & """"
                next
            end if
            if (m_children) then
                temp &= ">"
                for i as integer = 0 to m_children - 1
                    temp &= m_child[i]->m_emit()
                next
                temp &= "</" & tag & ">"
            else
                temp &= " />"
            end if
            return temp
        case comment
            return "<!--" & attribute("") & "-->"
        case text
        if tag = "" then return ""
            dim as string temp
            temp = "<" & tag
            if (m_attributes) then
                for i as integer = 0 to m_attributes - 1
                    temp &= " " & *m_attribute[i] & "=""" & encode_entities(*m_value[i]) & """"
                next
            end if
            temp &= ">"

            return temp & encode_entities(m_text) & "</" & tag & ">"
        case processingInstruction
            return "<?" & tag & attribute("") & "?>"
        case declaration
            return "<!" & tag & attribute("") & ">"
        end select
    end function

    sub node.m_parse(byref xmltext as const string)
        dim as node ptr root = @this
        dim as node ptr current = root

        dim as integer i = 0, l = len(xmltext) - 1

        do until i > l
            if xmltext[i] = lt then
                i += 1
                if (xmltext[i] = exclam and xmltext[i + 1] = hyphen and xmltext[i + 2] = hyphen) then
                    i += 3

                    '' grab the comment
                    dim as integer j = i
                    do until (xmltext[i] = hyphen and xmltext[i + 1] = hyphen and xmltext[i + 2] = gt) or i > l
                        i += 1
                    loop

                    if (i - j) then
                        dim as zstring ptr tempcomment = allocate(i - j + 1)
                        if tempcomment = 0 then
                            ext.setError(ERR_OUT_OF_MEMORY)
                            return
                        end if
                        strnztcpy(tempcomment, @xmltext[j], i - j)

                        '' create the comment child
                        current->appendChild("", comment)
                        *(current->m_child[current->m_children - 1]) = *tempcomment

                        deallocate(tempcomment)
                    else
                        '' empty comment?
                        current->appendChild("", comment)
                    end if

                    i += 3

                elseif (xmltext[i] = quest) then
                    i += 1

                    '' grab the tag
                    dim as integer j = i
                    do until FBEXT_XML_IS_WHITESPACE(xmltext[i]) or (xmltext[i] = quest and xmltext[i + 1] = gt) or i > l
                        i += 1
                    loop

                    if (i - j) then
                        dim as zstring ptr temptag = allocate(i - j + 1)
                        if temptag = 0 then
                            ext.setError(ERR_OUT_OF_MEMORY)
                            return
                        end if
                        strnztcpy(temptag, @xmltext[j], i - j)

                        '' create the child
                        current->appendChild(*temptag, processingInstruction)

                        deallocate(temptag)
                    else
                        '' MALFORMED
                        current->appendChild("", processingInstruction)
                    end if

                    '' grab the instructions
                    dim as integer k = i
                    do until (xmltext[i] = quest and xmltext[i + 1] = gt) or i > l
                        i += 1
                    loop

                    if (i - k) then
                        dim as zstring ptr temptext = allocate(i - k + 1)
                        if temptext = 0 then
                            ext.setError(ERR_OUT_OF_MEMORY)
                            return
                        end if
                        strnztcpy(temptext, @xmltext[k], i - k)

                        '' set the instructions
                        *current->m_child[current->m_children - 1] = *temptext

                        deallocate(temptext)
                    end if

                    i += 2

                elseif (xmltext[i] = exclam) then '' CDATA? halp
                    i += 1

                    '' grab the tag
                    dim as integer j = i
                    do until FBEXT_XML_IS_WHITESPACE(xmltext[i]) or xmltext[i] = gt or i > l
                        i += 1
                    loop

                    if (i - j) then
                        dim as zstring ptr temptag = allocate(i - j + 1)
                        if temptag = 0 then
                            ext.setError(ERR_OUT_OF_MEMORY)
                            return
                        end if
                        strnztcpy(temptag, @xmltext[j], i - j)

                        '' create the child
                        current->appendChild(*temptag, declaration)

                        deallocate(temptag)
                    else
                        '' MALFORMED
                        current->appendChild("", declaration)
                    end if

                    '' grab the instructions
                    dim as integer k = i
                    do until xmltext[i] = gt or i > l
                        i += 1
                    loop

                    if (i - k) then
                        dim as zstring ptr temptext = allocate(i - k + 1)
                        if temptext = 0 then
                            ext.setError(ERR_OUT_OF_MEMORY)
                            return
                        end if
                        strnztcpy(temptext, @xmltext[k], i - k)

                        '' set the instructions
                        *current->m_child[current->m_children - 1] = *temptext

                        deallocate(temptext)
                    end if

                    i += 2

                elseif (xmltext[i] = slash) then
                    i += 1

                    '' grab the tag
                    dim as integer j = i
                    do until xmltext[i] = gt or FBEXT_XML_IS_WHITESPACE(xmltext[i]) or i > l
                        i += 1
                    loop

                    if (i - j) then
                        dim as zstring ptr temptag = allocate(i - j + 1)
                        if temptag = 0 then
                            ext.setError(ERR_OUT_OF_MEMORY)
                            return
                        end if
                        strnztcpy(temptag, @xmltext[j], i - j)

                        '' run up the tree until the tag being closed is found
                        dim as node ptr depth = current
                        do until depth = root
                            if (depth->tag = *temptag) then
                                current = depth->m_parent
                                exit do
                            end if
                            depth = depth->m_parent
                        loop

                        deallocate(temptag)
                    else
                        /' new-fangled xml? '/
                    end if

                    '' get rid of the rest (should only be spaces, otherwise MALFORMED)
                    do until xmltext[i] = gt or i > l
                        i += 1
                    loop

                    i += 1

                else
                    '' grab the child tag
                    dim as integer j = i
                    do until xmltext[i] = gt or FBEXT_XML_IS_WHITESPACE(xmltext[i]) or xmltext[i] = slash or i > l
                        i += 1
                    loop

                    if (i - j) then
                        dim as zstring ptr temptag = allocate(i - j + 1)
                        if temptag = 0 then
                            ext.setError(ERR_OUT_OF_MEMORY)
                            return
                        end if
                        strnztcpy(temptag, @xmltext[j], i - j)

                        '' create the child
                        current = current->appendChild(*temptag)

                        deallocate(temptag)
                    else
                        '' MALFORMED
                        'current = current->appendChild("")
                    end if

                    '' grab attributes until the end of the tag
                    do until xmltext[i] = gt or (xmltext[i] = slash and xmltext[i + 1] = gt) or i > l
                        dim as zstring ptr tempattribute = 0, tempvalue = 0
                        if not FBEXT_XML_IS_WHITESPACE(xmltext[i]) then

                            '' grab the attribute
                            dim as integer j = i
                            do until xmltext[i] = eq or FBEXT_XML_IS_WHITESPACE(xmltext[i]) or xmltext[i] = gt or i > l
                                i += 1
                            loop

                            if (i - j) then
                                tempattribute = allocate(i - j + 1)
                                if tempattribute = 0 then
                                    ext.setError(ERR_OUT_OF_MEMORY)
                                    return
                                end if
                                strnztcpy(tempattribute, @xmltext[j], i - j)
                            end if

                            '' grab the value
                            if xmltext[i] = eq then
                                i += 1

                                '' if value is surrounded by quotes
                                if xmltext[i] = quot then
                                    i += 1

                                    dim as integer j = i
                                    do until xmltext[i] = quot or i > l
                                        i += 1
                                    loop

                                    if (i - j) then
                                        tempvalue = allocate(i - j + 1)
                                        if tempvalue = 0 then
                                            ext.setError(ERR_OUT_OF_MEMORY)
                                            return
                                        end if
                                        strnztcpy(tempvalue, @xmltext[j], i - j)
                                    end if

                                    i += 1

                                '' if value is not
                                else

                                    dim as integer j = i
                                    do until FBEXT_XML_IS_WHITESPACE(xmltext[i]) or xmltext[i] = gt or i > l
                                        i += 1
                                    loop

                                    if (i - j) then
                                        tempvalue = allocate(i - j + 1)
                                        if tempvalue = 0 then
                                            ext.setError(ERR_OUT_OF_MEMORY)
                                            return
                                        end if
                                        strnztcpy(tempvalue, @xmltext[j], i - j)
                                    end if

                                end if
                            end if

                            '' set the attribute
                            if (tempattribute) ANDALSO *tempattribute <> "" then
                                if (tempvalue) then

                                    current->attribute(*tempattribute) = decode_entities(*tempvalue)
                                    deallocate(tempvalue)
                                elseif *tempattribute <> "" then

                                    current->attribute(*tempattribute) = ""
                                end if
                                deallocate(tempattribute)
                            end if

                        else
                            '' skip the whitespace
                            i += 1
                        end if
                    loop

                    '' self-close tag
                    if (xmltext[i] = slash and xmltext[i + 1] = gt) then
                        current = current->m_parent
                        i += 2
                    else
                        i += 1
                    end if

                end if
            else
                '' this is so hackish, it's awesome
                ' if iif(current->m_children, current->m_child[current->m_children - 1]->nodeType = text, 0) = 0 then
                    current->appendChild("", text)
                ' end if

                '' grab the text
                dim as integer j = i
                do until xmltext[i] = lt or i > l
                    i += 1
                loop

                if (i - j) then

                    dim as zstring ptr temptext = allocate(i - j + 1)
                    if temptext = 0 then
                        ext.setError(ERR_OUT_OF_MEMORY)
                        return
                    end if
                    strnztcpy(temptext, @xmltext[j], i - j)

                    if temptext[0] <> 10 ANDALSO temptext[0] <> 13 then
                    '' set the text
                    current->m_text = decode_entities(*temptext)
                    current->m_node_type = text
                    current->removeChild(current->m_children -1)
                    else
                    'invalid tag

                        if FBEXT_XML_IS_WHITESPACE(temptext[0]) = false then
                            current->removeChild(current->m_children -1)
                            ext.setError(128,"XML Invalid Tag:'" & current->tag & "'")
                        end if
                    end if

                    deallocate(temptext)
                end if

            end if
        loop

    end sub

    constructor node
        m_ref = new integer
        *m_ref = 1
    end constructor

    constructor node( byref cpy as const node )

        this.m_ref = cpy.m_ref
        this.m_node_type = cpy.m_node_type

        this.m_attributes = cpy.m_attributes
        this.m_attribute = cpy.m_attribute
        this.m_value = cpy.m_value

        this.m_children = cpy.m_children
        this.m_child = cpy.m_child

        this.m_parent = cpy.m_parent
        this.m_text = cpy.m_text
        this.tag = cpy.tag

        *m_ref += 1

    end constructor

    constructor node( byref value as const string )
        m_ref = new integer
        *m_ref = 1
        this = value
    end constructor

    operator =  ( byref lhs as node, byref rhs as node ) as integer
        return iif(lhs.tag = rhs.tag ANDALSO lhs.child(0) = rhs.child(0), true, false)
    end operator

    operator <> ( byref lhs as node, byref rhs as node ) as integer
        return iif(lhs.tag <> rhs.tag ANDALSO lhs.child(0) <> rhs.child(0), true, false)
    end operator

    destructor node
        *m_ref -= 1
        if *m_ref > 0 then return

        if (m_attributes) then
            for i as integer = 0 to m_attributes - 1
                deallocate(m_attribute[i])
                deallocate(m_value[i])
            next
            deallocate(m_attribute)
            deallocate(m_value)
        end if
        do while (m_children)
            removeChild(0)
        loop
        tag = ""
        m_text = ""
    end destructor

    operator node.let(byref new_value as const string)
        '' not finished
        select case m_node_type
        case element
            m_parse(new_value)
        case comment, processingInstruction, declaration
            attribute("") = new_value
        case text
            m_text = new_value
        end select
    end operator

    operator node.cast() as string
        return m_emit()
    end operator

    function node.nodeType as node_type_e
        return m_node_type
    end function

    property node.getText( ) as string
        if m_node_type = text then

            return m_text

        end if

        return ""


    end property

    property node.setText( byref text_ as const string )

        if m_node_type  = text then

            m_text = text_

        end if

    end property

    property node.attribute(byref attribute_ as const string) as string
        '' return the attribute if it exists
        if (m_attributes) then
            for i as integer = 0 to m_attributes - 1
                if (*m_attribute[i] = attribute_) then
                    return *m_value[i]
                end if
            next
        end if
        '' return nothing if it doesn't
        return ""
    end property

    property node.attribute(byref attribute_ as const string, byref new_value as const string)
        '' modify the attribute if it exists
        if (m_attributes) then
            for i as integer = 0 to m_attributes - 1
                if (*m_attribute[i] = attribute_) then
                    m_value[i] = reallocate(m_value[i], len(new_value) + 1)
                    *m_value[i] = new_value
                    return
                end if
            next
        end if
        '' add the attribute if it doesn't
        m_attributes += 1
        m_attribute = reallocate(m_attribute, m_attributes * sizeof(zstring ptr))
        m_value = reallocate(m_value, m_attributes * sizeof(zstring ptr))
        m_attribute[m_attributes - 1] = allocate(len(attribute_) + 1)
        m_value[m_attributes - 1] = allocate(len(new_value) + 1)
        *m_attribute[m_attributes - 1] = attribute_
        *m_value[m_attributes - 1] = new_value
    end property

    function node.children() as integer
        return m_children
    end function

    function node.children(byref tag_ as const string) as integer
        dim as integer i = 0, c = 0
        do while (i < m_children)
            if (m_child[i]->tag = tag_) then
                c += 1
            end if
            i += 1
        loop
        return c
    end function

    function node.children(byval node_type_ as node_type_e) as integer
        dim as integer i = 0, c = 0
        do while (i < m_children)
            if (m_child[i]->nodeType = node_type_) then
                c += 1
            end if
            i += 1
        loop
        return c
    end function

    function node.child(byval index as integer = 0) as node ptr
        '' does that child exist?
        if (index < m_children) then
            return m_child[index]
        end if
        '' child does not exist
        return 0
    end function

    function node.child(byref tag_ as const string, byval index as integer = 0) as node ptr
        dim as integer i = m_child_index(tag_, index)
        if (i = -1) then
            '' child does not exist
            return 0
        end if
        return m_child[i]
    end function

    function node.child(byval node_type_ as node_type_e, byval index as integer = 0) as node ptr
        dim as integer i = m_child_index(node_type_, index)
        if (i = -1) then
            '' child does not exist
            return 0
        end if
        return m_child[i]
    end function

    function node.lastChild() as node ptr
        if (m_children) then
            return m_child[m_children - 1]
        end if
        return 0
    end function

    function node.appendChild(byref tag_ as const string, byval node_type_ as node_type_e = element) as node ptr
        m_children += 1
        var t_m_child = reallocate(m_child, m_children * sizeof(node ptr))
        if t_m_child = 0 then
            ext.setError(ERR_OUT_OF_MEMORY)
            m_children -= 1
            return 0
        end if
        m_child = t_m_child
        m_child[m_children - 1] = new node
        m_child[m_children - 1]->m_node_type = node_type_
        m_child[m_children - 1]->tag = tag_
        m_child[m_children - 1]->m_parent = @this
        return m_child[m_children - 1]
    end function

    sub node.removeChild(byval index as integer)
        dim as node ptr tempchild = child(index)
        '' if child exists
        if (tempchild) then
            '' shift the children up
            if (index < m_children - 1) then
                for i as integer = index to m_children - 2
                    swap m_child[i + 1], m_child[i]
                next
            end if
            m_children -= 1
            var t_m_child = reallocate(m_child, m_children * sizeof(node ptr))
            if t_m_child = 0 then
                ext.setError(ERR_OUT_OF_MEMORY)
                return
            end if
            m_child = t_m_child

            delete tempchild
        end if
    end sub

    sub node.removeChild(byref tag_ as const string, byval index as integer = 0)
        dim as integer i = m_child_index(tag_, index)
        if (i = -1) then
            '' child does not exist
            return
        end if
        removeChild(i)
    end sub

    sub node.removeChild(byval node_type_ as node_type_e, byval index as integer = 0)
        dim as integer i = m_child_index(node_type_, index)
        if (i = -1) then
            '' child does not exist
            return
        end if
        removeChild(i)
    end sub


    constructor tree
        root = new node
    end constructor

    destructor tree
        if (root) then
            do while root->children
                root->removeChild(0)
            loop
        end if
        delete root
    end destructor

    operator tree.let(byref new_value as const string)
        *root = new_value
    end operator

    operator tree.cast as string
        dim as string temp
        for i as integer = 0 to root->children - 1
            temp &= *root->child(i)
        next
        return temp
    end operator

    function tree.load(byref xmlfile as const string) as bool
        dim as integer f = freefile
        if (open(xmlfile for binary access read as #f) = 0) then
            dim as zstring ptr tempxml = callocate(sizeof(ubyte) * lof(f) + 1)
            if tempxml = 0 then
                ext.setError(ERR_OUT_OF_MEMORY)
                close #f
                return false
            end if
            get #f, , *cast(ubyte ptr, tempxml), lof(f)
            this = *tempxml
            deallocate(tempxml)
            close #f
            return false
        end if
        return true
    end function

    function tree.unload(byref xmlfile as const string) as bool
        dim as integer f = freefile
        if (open(xmlfile for binary access write as #f) = 0) then
            put #f, , cast(string, this)
            close #f
            return false
        end if
        return true
    end function

    sub tree.clear( )

        delete root
        root = new node
        if root = 0 then ext.setError(ERR_OUT_OF_MEMORY)

    end sub

end namespace 'ext.xml
