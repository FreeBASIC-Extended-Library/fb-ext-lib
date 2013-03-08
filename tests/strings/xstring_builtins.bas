# include once "ext/testly.bi"
# include once "ext/xstring.bi"

namespace ext.tests.strings

    private sub test_xstring_arg

        var x = ext.strings.t("%1 %2 %3 %2 %1").arg("one").arg("two").arg("three")
        TESTLY_ASSERT_STRING_EQUAL( "one two three two one", x.m_str )

        var z = ext.strings.t("%1 %2 %3").arg("one").arg("two").arg("three")
        TESTLY_ASSERT_STRING_EQUAL( "one two three", z.m_str )

    end sub

    private sub test_xstring_instr

        var res = 0
        var teststrx = ext.strings.t("Hello, World")

        res = teststrx.instr(,",")
        TESTLY_ASSERT_EQUAL(res, 6 )

        res = teststrx.instr(, "e")
        TESTLY_ASSERT_EQUAL(res, 2 )

        res = teststrx.instr(, "o")
        TESTLY_ASSERT_EQUAL(res, 5 )

        res = teststrx.instr(6, "o")
        TESTLY_ASSERT_EQUAL(res, 9 )

    end sub

    private sub test_xstring_trims

        dim as ext.strings.xstring mystrx = " Test "

        mystrx.trim()
        TESTLY_ASSERT_STRING_EQUAL(mystrx.m_str, "Test")

        mystrx.m_str = " Test"
        mystrx.ltrim()
        TESTLY_ASSERT_STRING_EQUAL(mystrx.m_str, "Test")

        mystrx.m_str = "Test "
        mystrx.rtrim()
        TESTLY_ASSERT_STRING_EQUAL(mystrx.m_str, "Test")

    end sub

    private sub test_xstring_cases

        dim as ext.strings.xstring mystrx = "Test"

        mystrx.ucase()
        TESTLY_ASSERT_STRING_EQUAL(mystrx.m_str, "TEST")

        mystrx.lcase()
        TESTLY_ASSERT_STRING_EQUAL(mystrx.m_str, "test")

    end sub

    private sub test_xstring_transforms

        dim as ext.strings.xstring mystrx = "Test"

        var x = mystrx.left(1)
        TESTLY_ASSERT_STRING_EQUAL(x, "T")

        x = mystrx.right(1)
        TESTLY_ASSERT_STRING_EQUAL(x, "t")

        x = mystrx.mid(3,)
        TESTLY_ASSERT_STRING_EQUAL(x, "st")

        mystrx.mid("ro", 3, 2)
        TESTLY_ASSERT_STRING_EQUAL(mystrx.m_str, "Tero")

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-strings-xstring-builtins")
        ext.testly.addTest("xstring-arg", @test_xstring_arg)
        ext.testly.addTest("xstring-instr", @test_xstring_instr)
        ext.testly.addTest("xstring-trims", @test_xstring_trims)
        ext.testly.addTest("xstring-cases", @test_xstring_cases)
        ext.testly.addTest("xstring-transforms", @test_xstring_transforms)
    end sub

end namespace
