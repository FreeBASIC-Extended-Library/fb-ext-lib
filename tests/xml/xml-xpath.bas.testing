# include once "ext/testly.bi"
# include once "ext/xml/xpath.bi"

namespace ext.tests.xml

    const as string xmltouse = _
    !"<?xml version=\"1.0\" encoding=\"us-ascii\" ?><contacts><contact><name>Samuel Sumrall</name><phone type=\"mobile\">+15558675309</phone></contact><contact><name>Geico Lizard</name><phone type=\"office\">+1800GEICO42</phone></contact><contact><name>Vince McMahon</name><phone type=\"office\">+1405BRINGONTHEPAIN</phone></contact></contacts></xml>"

    private sub test_xml_xpath_from_root

        var tpath = "/contacts" 'all chilren of contacts from root
        dim xtree as ext.xml.tree = xmltouse
        var nlist = ext.xml.xpath( @xtree, tpath )

        TESTLY_ASSERT_FALSE_ERROR( nlist <> null )
        TESTLY_ASSERT_TRUE( nlist->Size = 3 )

        delete nlist

    end sub

    private sub test_xml_xpath_from_any

        var tpath = "//phone" 'all elements named phone
        dim xtree as ext.xml.tree = xmltouse
        var nlist = ext.xml.xpath( @xtree, tpath )

        TESTLY_ASSERT_FALSE_ERROR( nlist <> null )
        TESTLY_ASSERT_TRUE( nlist->Size = 3 )

        delete nlist

    end sub

    private sub test_xml_xpath_attributes

        var tpath = !"//phone[@type=\"office\"]" 'all elements named phone with the attribute type that equals "office"
        dim xtree as ext.xml.tree = xmltouse
        var nlist = ext.xml.xpath( @xtree, tpath )

        TESTLY_ASSERT_FALSE_ERROR( nlist <> null )
        TESTLY_ASSERT_TRUE( nlist->Size = 2 )

        delete nlist

    end sub

    private sub test_xml_xpath_element_sel_index

        var tpath = "/contacts/contact[2]" 'the second contact element under contacts from root
        dim xtree as ext.xml.tree = xmltouse
        var nlist = ext.xml.xpath( @xtree, tpath )

        TESTLY_ASSERT_FALSE_ERROR( nlist <> null )
        TESTLY_ASSERT_TRUE( nlist->Size = 1 )

        delete nlist

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-xml-xpath")
        ext.testly.addTest("test_xml_xpath_from_root", @test_xml_xpath_from_root)
        ext.testly.addTest("test_xml_xpath_from_any", @test_xml_xpath_from_any)
        ext.testly.addTest("test_xml_xpath_attributes", @test_xml_xpath_attributes)
        ext.testly.addTest("test_xml_xpath_element_sel_index", @test_xml_xpath_element_sel_index)
    end sub

end namespace
