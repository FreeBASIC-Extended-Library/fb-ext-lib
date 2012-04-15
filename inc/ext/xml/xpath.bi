''Title: xml/xpath.bi
''
''About: License
''Copyright (c) 2007-2012, FreeBASIC Extended Library Development Group
''
''Distributed under the FreeBASIC Extended Library Group license. See
''accompanying file LICENSE.txt or copy at
''http://code.google.com/p/fb-extended-lib/wiki/License

# pragma once
# ifndef FBEXT_XML_XPATH_BI__
# define FBEXT_XML_XPATH_BI__ -1

# include once "ext/xml/dom.bi"
#ifndef fbext_NoBuiltinInstanciations
#define fbext_NoBuiltinInstanciations() 1
# include once "ext/containers/list.bi"
#undef fbext_NoBuiltinInstanciations
#else
# include once "ext/containers/list.bi"
#endif

fbext_TDeclare( fbExt_List, ((xml)(node)) )

''Namespace: ext.xml
''
namespace ext.xml


''Type: XMLNodeList
''A <ext.List> of <ext.xml.node>
''
type XMLNodeList as fbExt_List( ((node)) )

''Function: xpath
''XPath uses path expressions to select nodes or node-sets in an XML document.
''The node is selected by following a path or steps.
''For Help with XPath syntax see: http://www.w3schools.com/xpath/xpath_syntax.asp
''
''Parameters:
''DOM - <ext.xml.tree> pointer to pull nodes from.
''xpathstr - string containing the XPath "code" to use.
''
''Returns:
''<XMLNodeList> of matching nodes.
''
declare function xpath( byval DOM as xml.tree ptr, byref xpathstr as string ) as XMLNodeList ptr

end namespace

#endif 'FBEXT_XML_XPATH_BI__
