# include once "ext/tests.bi"
# include once "ext/xstring.bi"

namespace ext.tests.strings

    private sub test_xstring_arg

        var x = ext.strings.t("%1 %2 %3 %2 %1").arg("one").arg("two").arg("three")
        ext_assert_STRING_EQUAL( "one two three two one", x.m_str )

        var z = ext.strings.t("%1 %2 %3").arg("one").arg("two").arg("three")
        ext_assert_STRING_EQUAL( "one two three", z.m_str )

    end sub

    private sub test_xstring_instr

        var res = 0
        var teststrx = ext.strings.t("Hello, World")

        res = teststrx.instr(,",")
        ext_assert_EQUAL(res, 6 )

        res = teststrx.instr(, "e")
        ext_assert_EQUAL(res, 2 )

        res = teststrx.instr(, "o")
        ext_assert_EQUAL(res, 5 )

        res = teststrx.instr(6, "o")
        ext_assert_EQUAL(res, 9 )

    end sub

    private sub test_xstring_trims

        dim as ext.strings.xstring mystrx = " Test "

        mystrx.trim()
        ext_assert_STRING_EQUAL(mystrx.m_str, "Test")

        mystrx.m_str = " Test"
        mystrx.ltrim()
        ext_assert_STRING_EQUAL(mystrx.m_str, "Test")

        mystrx.m_str = "Test "
        mystrx.rtrim()
        ext_assert_STRING_EQUAL(mystrx.m_str, "Test")

    end sub

    private sub test_xstring_cases

        dim as ext.strings.xstring mystrx = "Test"

        mystrx.ucase()
        ext_assert_STRING_EQUAL(mystrx.m_str, "TEST")

        mystrx.lcase()
        ext_assert_STRING_EQUAL(mystrx.m_str, "test")

    end sub

    private sub test_xstring_transforms

        dim as ext.strings.xstring mystrx = "Test"

        var x = mystrx.left(1)
        ext_assert_STRING_EQUAL(x, "T")

        x = mystrx.right(1)
        ext_assert_STRING_EQUAL(x, "t")

        x = mystrx.mid(3,)
        ext_assert_STRING_EQUAL(x, "st")

        mystrx.mid("ro", 3, 2)
        ext_assert_STRING_EQUAL(mystrx.m_str, "Tero")

    end sub

    private sub register constructor
        ext.tests.addSuite("ext-strings-xstring-builtins")
        ext.tests.addTest("xstring-arg", @test_xstring_arg)
        ext.tests.addTest("xstring-instr", @test_xstring_instr)
        ext.tests.addTest("xstring-trims", @test_xstring_trims)
        ext.tests.addTest("xstring-cases", @test_xstring_cases)
        ext.tests.addTest("xstring-transforms", @test_xstring_transforms)
    end sub

end namespace
