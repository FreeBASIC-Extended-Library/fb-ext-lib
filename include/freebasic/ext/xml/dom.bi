''Title: xml/dom.bi
''
''About: About this Module
''This is the XML-DOM api module. This allows you to parse small XML
''documents rapidly using a simple interface.
''
''For a simple example of creating a document using this interface see https://code.google.com/p/fb-extended-lib/source/browse/examples/xml/simple.bas or
''for a more advanced example of document creation see https://code.google.com/p/fb-extended-lib/source/browse/examples/xml/advanced.bas. You can also
''look in the examples/xml folder for more examples.
''
''About: Code License
''Copyright (c) 2007-2014, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_XML_DOM_BI__
# define FBEXT_XML_DOM_BI__ -1

# include once "ext/xml/detail/common.bi"

'' Namespace: ext.xml
''
namespace ext.xml

    '' Enum: node_type_e
    '' Represents the different types of nodes supported.
    ''
    '' Valid values are:
    ''   * element
    ''   * text
    ''   * comment
    ''   * processingInstruction
    ''   * cdata
    ''   * declaration
    ''
    enum node_type_e
        element
        text
        comment
        processingInstruction
        cdata
        declaration '' document type declaration, element type declaration, attribute-list declarations
                    '' conditional sections, entity declarations
    end enum

    '' Class: node
    '' Child XML class, branch and leaf nodes.
    ''
    '' Supports casting to string to print out XML data of the node and its children.
    '' Any Unicode characters in the XML are internally converted to UTF-8.
    ''
    type node
        private:
        as integer ptr      m_ref
        as node_type_e      m_node_type

        as integer          m_attributes
        as zstring ptr ptr  m_attribute
        as zstring ptr ptr  m_value

        as integer          m_children
        as node ptr ptr     m_child

        as node ptr         m_parent
        as string       m_text

        declare function m_emit() as string
        declare sub      m_parse(byref xmltext as const string)

        declare function m_child_index(byref tag as const string, byval index as integer) as integer
        declare function m_child_index(byval node_type as node_type_e, byval index as integer) as integer

        public:

        '' Variable: tag
        '' Contains this child's tag name
        ''
        as string           tag

        declare constructor
        declare constructor( byref cpy as const node )
        declare constructor( byref value as const string )

        declare destructor

        declare operator let(byref new_value as const string)
        declare operator cast() as string

        '' Function: node_type
        '' Access the type of the node.
        ''
        '' Returns:
        '' node_type_e, this node's type.
        ''
        declare function nodeType() as node_type_e

        '' Property: attribute
        '' Access the value of an attribute of the node.
        ''
        '' Parameters:
        '' attribute - the name of the attribute you wish to retrieve.
        ''
        '' Returns:
        '' string, the requested attribute's value.
        ''
        declare property attribute(byref attribute as const string) as string

        '' Property: attribute
        '' Set the value of an attribute of this node.
        ''
        '' Parameters:
        '' attribute - the name of the attribute
        '' new_value - the value to assign to attribute
        ''
        declare property attribute(byref attribute as const string, byref new_value as const string)

        '' Property: getText
        '' Returns the value of a Text element.
        ''
        declare property getText( ) as string

        '' Property: setText
        '' Sets the value of a Text element.
        ''
        '' Parameters:
        '' text_ - the value to assign to the Text element.
        ''
        declare property setText( byref text_ as const string )

        '' Function: children
        '' Count the number of child nodes.
        ''
        '' Returns:
        '' integer, count of children of this node.
        ''
        declare function children() as integer

        '' Function: children
        '' Count the number of child nodes with a specific tag.
        ''
        '' Parameters:
        '' tag - tag to limit count.
        ''
        '' Returns:
        '' integer, count of children of this node matching the specified tag.
        ''
        declare function children(byref tag as const string) as integer

        '' Function: children
        '' Count the number of child nodes with a specific type.
        ''
        '' Parameters:
        '' node_type - node type to limit count.
        ''
        '' Returns:
        '' integer, count of children of this node matching the specified type.
        ''
        declare function children(byval node_type as node_type_e) as integer

        '' Function: child
        '' Access a specific child of this node.
        ''
        '' Parameters:
        '' index - integer index value of child.
        ''
        '' Returns:
        '' node ptr, access with ->
        ''
        declare function child(byval index as integer = 0) as node ptr

        '' Function: child
        '' Access a specific child of this node by tag.
        ''
        '' Parameters:
        '' tag - tag to limit index to.
        '' index - integer index value of child.
        ''
        '' Returns:
        '' node ptr, access with ->
        ''
        declare function child(byref tag as const string, byval index as integer = 0) as node ptr

        '' Function: child
        '' Access a specific child of this node by type.
        ''
        '' Parameters:
        '' node_type - node type to limit index to.
        '' index - integer index value of child.
        ''
        '' Returns:
        '' node ptr, access with ->
        ''
        declare function child(byval node_type as node_type_e, byval index as integer = 0) as node ptr

        '' Function: last_child
        '' Access the child with the highest integer index.
        ''
        '' Returns:
        '' node ptr, access with ->
        ''
        declare function lastChild() as node ptr

        '' Function: appendChild
        '' Add a child onto this node.
        ''
        '' Parameters:
        '' tag - tag to give new child.
        '' node_type - optional type of node to create, defaults to element.
        ''
        '' Returns:
        '' node ptr of the new child, not needed for normal usage.
        ''
        declare function appendChild(byref tag as const string, byval node_type as node_type_e = element) as node ptr

        '' Sub: remove_child
        '' Remove a child from this node.
        ''
        '' Parameters:
        '' index - integer index of node to remove.
        ''
        declare sub      removeChild(byval index as integer)

        '' Sub: remove_child
        '' Remove a child from this node by tag.
        ''
        '' Parameters:
        '' tag - tag of node to limit index to.
        '' index - integer index of node to remove.
        ''
        declare sub      removeChild(byref tag as const string, byval index as integer = 0)

        '' Sub: remove_child
        '' Remove a child from this node by type.
        ''
        '' Parameters:
        '' node_type - node type to limit index to.
        '' index - integer index of node to remove.
        ''
        declare sub      removeChild(byval node_type as node_type_e, byval index as integer = 0)

        '' Function: Parent( ) as node ptr
        ''
        declare function parent( ) as node ptr

    end type

    declare operator =  ( byref lhs as node, byref rhs as node ) as integer
    declare operator <> ( byref lhs as node, byref rhs as node ) as integer

    '' Class: tree
    '' Base XML class, node is a sub-class of this class.
    ''
    '' Supports casting to a string to print all XML data.
    ''
    type tree
        '' Variable: root
        '' Used to access the XML document structure.
        ''
        as node ptr     root

        declare constructor
        declare destructor

        declare operator let(byref new_value as const string)
        declare operator cast as string

        '' Function: load
        '' Loads a XML data structure from a file.
        ''
        '' Parameters:
        '' xmlfile - the file to load
        ''
        '' Returns:
        '' bool, returns false on success, true on error.
        ''
        declare function load(byref xmlfile as const string) as bool

        '' Function: unload
        '' Unloads a XML data structure to a file
        ''
        '' this does not destroy the structure
        ''
        '' Parameters:
        '' xmlfile - the file to unload to
        ''
        '' Returns:
        '' bool, returns false on success, true on error.
        ''
        declare function unload(byref xmlfile as const string) as bool

        '' Sub: clear
        '' Clears all data from the xml tree.
        ''
        declare sub clear( )
    end type

end namespace 'ext.xml

#endif 'FBEXT_XML_BI__
