# include once "ext/testly.bi"
# include once "ext/xml/dom.bi"

namespace ext.tests.xml

    private sub test_xml_dom_parse

        var txml = !"<xml>\n<tag><tag2 />\n</tag>\r</xml>"
        var tr = ext.xml.tree
        tr = txml

        TESTLY_ASSERT_STRING_EQUAL( "<xml><tag><tag2 /></tag></xml>", cast(string, tr) )
        TESTLY_ASSERT_TRUE( tr.root <> null )
        TESTLY_ASSERT_TRUE( tr.root->child("xml") <> null )
        TESTLY_ASSERT_STRING_EQUAL( "xml", tr.root->child("xml")->tag )
        TESTLY_ASSERT_TRUE( tr.root->child("xml")->child("tag") <> null )
        TESTLY_ASSERT_STRING_EQUAL( "tag", tr.root->child("xml")->child("tag")->tag )
        TESTLY_ASSERT_TRUE( tr.root->child("xml")->child("tag")->child("tag2") <> null )
        TESTLY_ASSERT_STRING_EQUAL( "tag2", tr.root->child("xml")->child("tag")->child("tag2")->tag )

    end sub

    private sub test_xml_dom_text_parse

        var txml = "<html><head><title>Extended Library</title></head></html>"
        var tr = ext.xml.tree
        tr = txml

        TESTLY_ASSERT_STRING_EQUAL( txml, tr )
        TESTLY_ASSERT_TRUE( tr.root->child(0)->child(0)->child(0) <> null )
        TESTLY_ASSERT_STRING_EQUAL( "Extended Library", tr.root->child(0)->child(0)->child(0)->getText() )

    end sub

    private sub test_xml_dom_parse_line_endings

        #define _CRLF chr(10)+chr(13)
        #define _LF chr(13)
        var win32xml = "<xml>" & _CRLF & "<child>" & _CRLF & "<children>Hello World!</children>" & _CRLF & "</child>" & _CRLF & "</xml>"
        var unixxml = "<xml>" & _LF & "<child>" & _LF & "<children>Hello World!</children>" & _LF & "</child>" & _LF & "</xml>"

        var wt = ext.xml.tree
        wt = win32xml

        var ut = ext.xml.tree
        ut = unixxml

        var wtt = cast(string,wt)
        var utt = cast(string,ut)

        TESTLY_ASSERT_TRUE(wt.root <> null)
        TESTLY_ASSERT_TRUE(wt.root->child("xml") <> null)
        TESTLY_ASSERT_TRUE(wt.root->child("xml")->child("child") <> null)
        TESTLY_ASSERT_TRUE(wt.root->child("xml")->child("child")->child("children") <> null)
        TESTLY_ASSERT_STRING_EQUAL("Hello World!",wt.root->child("xml")->child("child")->child("children")->getText())

        TESTLY_ASSERT_TRUE(ut.root <> null)
        TESTLY_ASSERT_TRUE(ut.root->child("xml") <> null)
        TESTLY_ASSERT_TRUE(ut.root->child("xml")->child("child") <> null)
        TESTLY_ASSERT_TRUE(ut.root->child("xml")->child("child")->child("children") <> null)
        TESTLY_ASSERT_STRING_EQUAL("Hello World!",ut.root->child("xml")->child("child")->child("children")->getText())

        TESTLY_ASSERT_STRING_EQUAL(wtt,utt)


    end sub

    private sub register constructor
        ext.testly.addSuite("ext-xml-dom-parse")
        ext.testly.addTest("test_xml_dom_parse", @test_xml_dom_parse)
        ext.testly.addTest("test_xml_dom_text_parse", @test_xml_dom_text_parse)
        ext.testly.addTest("test_xml_dom_parse_line_endings", @test_xml_dom_parse_line_endings)
    end sub

end namespace
