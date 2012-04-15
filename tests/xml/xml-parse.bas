# include once "ext/testly.bi"
# include once "ext/xml/dom.bi"

namespace ext.tests.xml

    private sub test_xml_dom_parse

        var txml = !"<xml>\n<tag><tag2 />\n</tag>\r</xml>"
        var tr = ext.xml.tree
        tr = txml

        TESTLY_ASSERT_STRING_EQUAL( "<xml><tag><tag2 /></tag></xml>", cast(string, tr) )
        TESTLY_ASSERT_TRUE( tr.root <> null )
        TESTLY_ASSERT_TRUE( tr.root->child(0) <> null )
        TESTLY_ASSERT_STRING_EQUAL( "xml", tr.root->child(0)->tag )
        TESTLY_ASSERT_TRUE( tr.root->child(0)->child(0) <> null )
        TESTLY_ASSERT_STRING_EQUAL( "tag", tr.root->child(0)->child(0)->tag )
        TESTLY_ASSERT_TRUE( tr.root->child(0)->child(0)->child(0) <> null )
        TESTLY_ASSERT_STRING_EQUAL( "tag2", tr.root->child(0)->child(0)->child(0)->tag )

    end sub

    private sub test_xml_dom_text_parse

        var txml = "<html><head><title>Extended Library</title></head></html>"
        var tr = ext.xml.tree
        tr = txml

        TESTLY_ASSERT_STRING_EQUAL( txml, tr )
        TESTLY_ASSERT_TRUE( tr.root->child(0)->child(0)->child(0) <> null )
        TESTLY_ASSERT_STRING_EQUAL( "Extended Library", tr.root->child(0)->child(0)->child(0)->getText() )

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-xml-dom-parse")
        ext.testly.addTest("test_xml_dom_parse", @test_xml_parse)
        ext.testly.addTest("test_xml_dom_text_parse", @test_xml_text_parse)
    end sub

end namespace
