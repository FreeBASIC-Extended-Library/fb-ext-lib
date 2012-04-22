# include once "ext/testly.bi"
# include once "ext/strings.bi"

namespace ext.tests.strings

    private sub test_insertinto

        TESTLY_ASSERT_TRUE("Ext insert rocks!" = ext.strings.InsertInto(" insert", "Ext rocks!", 3))
        TESTLY_ASSERT_TRUE("You can even prepend strings!" = ext.strings.InsertInto("You can", " even prepend strings!", 0))
        TESTLY_ASSERT_TRUE("Or even append them!" = ext.strings.InsertInto(" append them!", "Or even", 6))

    end sub

    private sub register constructor
        ext.testly.addSuite("ext-strings-insertinto")
        ext.testly.addTest("InsertInto", @test_insertinto)
    end sub

end namespace
